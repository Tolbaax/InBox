import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/core/params/chat/message_params.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/data/datasources/chat/chat_remote_data_source.dart';
import 'package:inbox/data/datasources/user/user_remote_data_source.dart';
import 'package:inbox/data/models/message_model.dart';
import 'package:inbox/data/models/user_chat_model.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../core/params/chat/delete_message_params.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final UserRemoteDataSource _userRemoteDataSource;

  ChatRemoteDataSourceImpl(
    this.firestore,
    this.firebaseStorage,
    this.auth,
    this._userRemoteDataSource,
  );

  Future<void> _sendMessage({
    required MessageParams params,
    required MessageType messageType,
  }) async {
    try {
      final senderUser = await _userRemoteDataSource.getCurrentUser();
      final receiverUser =
          await _userRemoteDataSource.getUserById(params.receiverId);
      final timeSent = DateTime.now();
      final messageId = const Uuid().v1();
      final path =
          'chat/${params.messageType!.type}/${senderUser.uID}/${params.receiverId}/$messageId}';

      final fileUrl = await _uploadFileToFirebase(path, params.messageFile);

      String lastMessage;
      switch (messageType) {
        case MessageType.text:
          lastMessage = params.message;
          break;
        case MessageType.image:
          lastMessage = '📷 Photo';
          break;
        case MessageType.video:
          lastMessage = '🎥 Video';
          break;
        case MessageType.audio:
          lastMessage = '🎙️ Audio';
          break;
        case MessageType.gif:
          lastMessage = 'GIF';
          break;
        default:
          lastMessage = 'Other';
      }

      final senderChatContact = UserChatModel(
        name: receiverUser.name,
        profilePic: receiverUser.profilePic,
        userId: receiverUser.uID,
        lastMessageSenderId: senderUser.uID,
        lastMessage: lastMessage,
        isSeen: false,
        timeSent: timeSent,
      );

      final receiverChatContact = UserChatModel(
        name: senderUser.name,
        profilePic: senderUser.profilePic,
        userId: senderUser.uID,
        lastMessageSenderId: senderUser.uID,
        lastMessage: lastMessage,
        isSeen: false,
        timeSent: timeSent,
      );

      final senderChatReference = firestore
          .collection('users')
          .doc(senderUser.uID)
          .collection('chats')
          .doc(receiverUser.uID);

      final receiverChatReference = firestore
          .collection('users')
          .doc(receiverUser.uID)
          .collection('chats')
          .doc(senderUser.uID);

      final senderReference =
          senderChatReference.collection('messages').doc(messageId);
      final receiverReference =
          receiverChatReference.collection('messages').doc(messageId);

      final message = MessageModel(
        senderId: senderUser.uID,
        receiverId: receiverUser.uID,
        message:
            params.messageType == MessageType.audio ? fileUrl : params.message,
        messageId: messageId,
        timeSent: timeSent,
        isSeen: false,
        messageType: messageType,
        repliedMessage: params.messageReplay?.message ?? '',
        senderName: senderUser.name,
        repliedTo: params.messageReplay?.isMe == true
            ? senderUser.name
            : params.messageReplay?.repliedTo ?? '',
        repliedMessageType: params.messageReplay?.messageType ?? messageType,
        fileUrl: fileUrl,
      );

      final batch = firestore.batch();

      batch.set(senderChatReference, senderChatContact.toJson());
      batch.set(receiverChatReference, receiverChatContact.toJson());
      batch.set(senderReference, message.toJson());
      batch.set(receiverReference, message.toJson());

      // Commit the batch to perform all operations together
      await batch.commit();
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  @override
  Future<void> sendTextMessage(MessageParams params) async =>
      await _sendMessage(params: params, messageType: MessageType.text);

  @override
  Future<void> sendGifMessage(MessageParams params) async =>
      await _sendMessage(params: params, messageType: MessageType.gif);

  @override
  Future<void> sendFileMessage(MessageParams params) async =>
      await _sendMessage(params: params, messageType: params.messageType!);

  Future<String> _uploadFileToFirebase(String path, File? file) async {
    if (file == null || !file.existsSync()) return '';

    final uploadTask = firebaseStorage.ref().child(path).putFile(file);
    final snap = await uploadTask;
    final downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Stream<List<MessageEntity>> getChatMessages(String receiverId) {
    final uID = auth.currentUser!.uid;

    final messageCollection = firestore
        .collection('users')
        .doc(uID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent');

    final messages = messageCollection.snapshots().map((event) {
      List<MessageModel> messagesList =
          event.docs.map((e) => MessageModel.fromJson(e.data())).toList();

      return messagesList;
    });

    return messages;
  }

  @override
  Stream<List<UserChatEntity>> getUsersChat() {
    final uID = auth.currentUser!.uid;

    final chatsCollection = firestore
        .collection('users')
        .doc(uID)
        .collection('chats')
        .orderBy('timeSent', descending: true);

    final chats = chatsCollection.snapshots().map((event) {
      List<UserChatEntity> chatsList =
          event.docs.map((e) => UserChatModel.fromJson(e.data())).toList();

      return chatsList;
    });

    return chats;
  }

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) {
    final uID = auth.currentUser!.uid;

    final messagesCollection = firestore
        .collection('users')
        .doc(uID)
        .collection('chats')
        .doc(senderId)
        .collection('messages');

    // Create a query for unseen messages
    final unseenMessagesQuery =
        messagesCollection.where('isSeen', isEqualTo: false);

    // Listen for changes in the query and transform them into a stream of counts
    return unseenMessagesQuery.snapshots().map((event) => event.docs.length);
  }

  @override
  Future<void> setChatMessageSeen(SetChatMessageSeenParams params) async {
    final uID = auth.currentUser?.uid;
    if (uID == null) return;

    final batch = firestore.batch();
    final paths = [
      'users/$uID/chats/${params.receiverId}/messages/${params.messageId}',
      'users/${params.receiverId}/chats/$uID/messages/${params.messageId}',
      'users/$uID/chats/${params.receiverId}',
      'users/${params.receiverId}/chats/$uID',
    ];

    for (final path in paths) {
      batch.update(firestore.doc(path), {'isSeen': true});
    }

    await batch.commit();
  }

  @override
  Future<void> deleteMessages(DeleteMessageParams params) async {
    final uID = auth.currentUser!.uid;
    final batch = firestore.batch();
    final receiverId = params.receiverId;
    final isMyMessages = params.isMyMessages;
    final deleteForMeWithEveryOne = params.deleteForMeWithEveryOne;

    for (final messageId in params.messageIds) {
      final senderMessageRef = firestore
          .collection('users')
          .doc(uID)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .doc(messageId);

      batch.delete(senderMessageRef);

      if (isMyMessages && !deleteForMeWithEveryOne) {
        final receiverMessageRef = firestore
            .collection('users')
            .doc(receiverId)
            .collection('chats')
            .doc(uID)
            .collection('messages')
            .doc(messageId);

        batch.delete(receiverMessageRef);
      }
    }

    await batch.commit();
  }

  @override
  Future<void> deleteChat(List<String> selectedChatIds) async {
    final uID = auth.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;

    final userChatsCollection =
        firestore.collection('users').doc(uID).collection('chats');

    for (String chatId in selectedChatIds) {
      final messagesCollection =
          userChatsCollection.doc(chatId).collection('messages');

      final messagesSnapshot = await messagesCollection.get();
      final batch = firestore.batch();

      for (var messageDoc in messagesSnapshot.docs) {
        batch.delete(messageDoc.reference);
      }

      await batch.commit();

      await userChatsCollection.doc(chatId).delete();
    }
  }

  @override
  Stream<int> getUnreadChatsCount() {
    final uID = auth.currentUser!.uid;

    return firestore
        .collection('users')
        .doc(uID)
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.where((doc) {
        final chat = UserChatModel.fromJson(doc.data());

        // Ensure the chat has messages
        if (chat.lastMessage.isEmpty) return false;

        // Ensure last message is not sent by the current user and is not seen
        return chat.lastMessageSenderId != uID && !chat.isSeen;
      }).length;
    });
  }
}
