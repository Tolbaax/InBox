abstract class UserStates {}

class UserInitialState extends UserStates {}

//Get CurrentUser States
class GetCurrentUserLoadingState extends UserStates {}

class GetCurrentUserErrorState extends UserStates {}

class GetCurrentUserSuccessState extends UserStates {}

//Get User By ID States
class GetUserByIDLoadingState extends UserStates {}

class GetUserByIDErrorState extends UserStates {}

class GetUserByIDSuccessState extends UserStates {}

//Set User State
class SetUserStateErrorState extends UserStates {}

class SetUserStateSuccessState extends UserStates {}

//Update User Data
class UpdateUserDataLoadingState extends UserStates {}

class UpdateUserDataSuccessState extends UserStates {}

class UpdateUserDataErrorState extends UserStates {}

class SelectProfileImageFromGalleryState extends UserStates {}

//Follow User
class FollowUserLoadingState extends UserStates {}

class FollowUserSuccessState extends UserStates {}

class FollowUserErrorState extends UserStates {}

//UnFollow User
class UnFollowUserLoadingState extends UserStates {}

class UnFollowUserSuccessState extends UserStates {}

class UnFollowUserErrorState extends UserStates {}

//Delete User Account
class DeleteUserAccountLoadingState extends UserStates {}

class DeleteUserAccountSuccessState extends UserStates {}

class DeleteUserAccountErrorState extends UserStates {}
