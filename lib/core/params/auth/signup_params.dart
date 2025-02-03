import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String username;
  final String name;
  final String email;
  final String password;

  const SignUpParams({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, name, email, password];
}