abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesSearchUpdated extends MessagesState {}

class DeleteChatLoadingState extends MessagesState {}

class DeleteChatSuccessState extends MessagesState {}

class DeleteChatErrorState extends MessagesState {}

class SelectChatState extends MessagesState {}

class RemoveSelectedState extends MessagesState {}

class ClearSearchState extends MessagesState {}
