import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inbox/core/error/failure.dart';
import 'package:inbox/core/params/chat/delete_message_params.dart';
import 'package:inbox/core/params/chat/set_chat_message_seen_params.dart';
import 'package:inbox/core/params/chat/message_params.dart';
import 'package:inbox/data/datasources/chat/chat_remote_data_source.dart';
import 'package:inbox/domain/entities/message_entity.dart';
import 'package:inbox/domain/entities/user_chat_entity.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepositoryImpl(this._chatRemoteDataSource);

  @override
  Stream<List<MessageEntity>> getChatMessages(String receiverId) =>
      _chatRemoteDataSource.getChatMessages(receiverId);

  @override
  Stream<int> getNumOfMessageNotSeen(String senderId) =>
      _chatRemoteDataSource.getNumOfMessageNotSeen(senderId);

  @override
  Stream<List<UserChatEntity>> getUsersChat() =>
      _chatRemoteDataSource.getUsersChat();

  @override
  Future<Either<Failure, void>> sendFileMessage(
      MessageParams parameters) async {
    final result = await _chatRemoteDataSource.sendFileMessage(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> sendGifMessage(MessageParams parameters) async {
    final result = await _chatRemoteDataSource.sendGifMessage(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage(
      MessageParams parameters) async {
    final result = await _chatRemoteDataSource.sendTextMessage(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setChatMessageSeen(
      SetChatMessageSeenParams parameters) async {
    final result = await _chatRemoteDataSource.setChatMessageSeen(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessages(
      DeleteMessageParams parameters) async {
    final result = await _chatRemoteDataSource.deleteMessages(parameters);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChat(List<String> selectedChatIds) async {
    final result = await _chatRemoteDataSource.deleteChat(selectedChatIds);
    try {
      return Right(result);
    } on FirebaseAuthException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

}
