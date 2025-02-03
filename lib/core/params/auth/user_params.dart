import 'package:equatable/equatable.dart';

class UserParams extends Equatable {
  final String username;
  final String name;
  final String bio;
  final String profileUrl;

  const UserParams({
    required this.username,
    required this.name,
    required this.bio,
    required this.profileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [username, name, bio, profileUrl];
}
