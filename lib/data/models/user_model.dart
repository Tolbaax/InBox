import 'package:inbox/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uID,
    required super.username,
    required super.name,
    required super.email,
    required super.profilePic,
    required super.bio,
    required super.isOnline,
    required super.postsCount,
    required super.following,
    required super.followers,
    required super.drafts,
    required super.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uID: json['uID'] ?? '',
        username: json['username'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        profilePic: json['profilePic'] ?? '',
        bio: json['bio'] ?? '',
        isOnline: json['isOnline'] ?? false,
        postsCount: json['postsCount'] ?? 0,
        following: json['following'] ?? [],
        followers: json['followers'] ?? [],
        drafts: json['drafts'] ?? [],
        lastSeen: DateTime.fromMicrosecondsSinceEpoch(json['lastSeen']),
      );

  Map<String, dynamic> toJson() => {
        'uID': uID,
        'username': username,
        'name': name,
        'email': email,
        'profilePic': profilePic,
        'bio': bio,
        'isOnline': isOnline,
        'postsCount': postsCount,
        'following': following,
        'followers': followers,
        'drafts': drafts,
        'lastSeen': lastSeen.microsecondsSinceEpoch,
      };
}
