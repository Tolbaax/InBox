abstract class MessagesStates {}

class MessagesInitialState extends MessagesStates {}

class DeleteMessageLoadingState extends MessagesStates {}

class DeleteMessageSuccessState extends MessagesStates {}

class DeleteMessageErrorState extends MessagesStates {}

class SelectChatState extends MessagesStates {}
