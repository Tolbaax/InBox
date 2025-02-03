import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
