abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class SendMessageLoadingState extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {}

class SetMessageSeenSuccessState extends ChatStates {}

class SetMessageSeenErrorState extends ChatStates {}

class MessageSwipeLoadingState extends ChatStates {}

class MessageSwipeState extends ChatStates {}

class CancelReplayState extends ChatStates {}

class ShowEmojiContainerState extends ChatStates {}

class HideEmojiContainerState extends ChatStates {}

class PickMessageImageSuccessState extends ChatStates {}

class CropMessageImageState extends ChatStates {}

class ToggleFlashState extends ChatStates {}

class ToggleCameraFrontState extends ChatStates {}

class StartVideoRecordingState extends ChatStates {}

class StopVideoRecordingState extends ChatStates {}
