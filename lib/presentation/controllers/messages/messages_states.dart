abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesSearchUpdated extends MessagesState {}

class DeleteMessageLoadingState extends MessagesState {}

class DeleteMessageSuccessState extends MessagesState {}

class DeleteMessageErrorState extends MessagesState {}

class SelectChatState extends MessagesState {}

class RemoveSelectedState extends MessagesState {}

