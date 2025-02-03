abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

//Login States
class ChangeVisibilityState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessfullyState extends AuthStates {}

class LoginErrorState extends AuthStates {}

class ClearSignInControllersState extends AuthStates {}

//SignOut States
class SignOutLoadingState extends AuthStates {}

class SignOutSuccessState extends AuthStates {}

class SignOutErrorState extends AuthStates {}

//Register States
class ChangeVisibilityState1 extends AuthStates {}

class ChangeVisibilityState2 extends AuthStates {}

class CheckUsernameAvailable extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessfullyState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

class ClearSignUpControllerState extends AuthStates {}
