import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uID;
  final String username;
  final String name;
  final String email;
  final String profilePic;
  final String bio;
  final bool isOnline;
  final int postsCount;
  final List following;
  final List followers;
  final List drafts;
  final DateTime lastSeen;

  const UserEntity({
    required this.uID,
    required this.username,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.bio,
    required this.isOnline,
    required this.postsCount,
    required this.following,
    required this.followers,
    required this.drafts,
    required this.lastSeen,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        uID,
        username,
        name,
        email,
        profilePic,
        bio,
        isOnline,
        postsCount,
        following,
        followers,
        drafts,
        lastSeen,
      ];
}
