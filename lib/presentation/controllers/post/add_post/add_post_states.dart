import 'dart:io';

abstract class AddPostStates {}

class AddPostInitialStates extends AddPostStates {}

class PickPostImageSuccessState extends AddPostStates {}

class DeletePostImageState extends AddPostStates {}

class DisposeVideoState extends AddPostStates {}

class DisposeGifState extends AddPostStates {}

class PickVideoSuccessState extends AddPostStates {
  final File video;

  PickVideoSuccessState({required this.video});
}

class PickedGifSuccessState extends AddPostStates {}

class PickedGifErrorState extends AddPostStates {}

class AddPostLoadingState extends AddPostStates {}

class AddPostSuccessState extends AddPostStates {}

class AddPostErrorState extends AddPostStates {}
