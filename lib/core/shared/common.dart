import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox/core/enums/message_type.dart';
import 'package:inbox/core/functions/app_dialogs.dart';
import 'package:inbox/core/utils/app_colors.dart';
import 'package:path_provider/path_provider.dart';

import '../../presentation/controllers/chat/chat_cubit.dart';
import '../injection/injector.dart';
import '../params/chat/message_params.dart';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  final status = await permission.request();
  return status.isGranted;
}

Future<File?> pickImageFile(BuildContext context,
    {ImageSource imageSource = ImageSource.gallery}) async {
  File? image;

  try {

    // Pick image
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    } else {
      AppDialogs.showToast(msg: 'No image selected');
    }
  } catch (e) {
    AppDialogs.showToast(msg: 'Error picking image: ${e.toString()}');
  }
  return image;
}


Future<CroppedFile?> cropImage(String path,
    {String? title, bool isProfile = false}) async {
  return await ImageCropper().cropImage(
    sourcePath: path,
    aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    compressQuality: 100,
    maxWidth: 400,
    maxHeight: 400,
    compressFormat: ImageCompressFormat.jpg,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: title,
        toolbarColor: AppColors.charlestonGreen,
        statusBarColor: AppColors.charlestonGreen,
        toolbarWidgetColor: Colors.white,
        activeControlsWidgetColor: AppColors.primary,
        backgroundColor: AppColors.black,
        lockAspectRatio: true,
        initAspectRatio: CropAspectRatioPreset.square,
        cropStyle: isProfile ? CropStyle.circle : CropStyle.rectangle,
      ),
      IOSUiSettings(
        title: title,
        aspectRatioLockEnabled: true,
        aspectRatioPickerButtonHidden: true,
        resetButtonHidden: true,
        rotateButtonsHidden: true,
        rotateClockwiseButtonHidden: true,
        doneButtonTitle: 'Done',
        cancelButtonTitle: 'Cancel',
      ),
    ],
  );
}

// This method takes a string as input and converts it to title case.
String convertToTitleCase(String text) {
  // Split the input string into a list of words using space as the delimiter.
  List<String> words = text.split(" ");

  // Iterate through each word in the list.
  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    // Check if the word is not empty.
    if (word.isNotEmpty) {
      // Capitalize the first letter of the word and keep the rest in lowercase.
      words[i] = "${word[0].toUpperCase()}${word.substring(1)}";
    }
  }

  // Join the modified words back together into a single string with spaces.
  return words.join(" ");
}

// Function to check internet connectivity
Future<bool> checkInternetConnectivity() async {
  List<ConnectivityResult> connectivityResults =
      await Connectivity().checkConnectivity();
  return connectivityResults.any((result) =>
      result == ConnectivityResult.mobile || result == ConnectivityResult.wifi);
}

Future<bool> checkUsernameAvailability(String username) async {
  final firestore = sl<FirebaseFirestore>();

  final QuerySnapshot result = await firestore
      .collection('users')
      .where('username', isEqualTo: username.trim())
      .limit(1)
      .get();
  return result.docs.isNotEmpty;
}

// Checks whether the input text contains any Arabic characters.
bool isArabic(String text) {
  final arabicRegex = RegExp('[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');

  return arabicRegex.hasMatch(text);
}

bool isFirstCharacterArabic(String input) {
  final words = input.split(' ');

  for (String word in words) {
    if (word.isNotEmpty) {
      // Check the first character of each word
      final firstChar = word[0];
      final isArabic = isArabicCharacter(firstChar);

      if (isArabic) {
        return true;
      }
    }
  }

  return false;
}

bool isArabicCharacter(String character) {
  // Check if the character is in the Arabic Unicode range
  final codeUnit = character.codeUnitAt(0);
  return (codeUnit >= 0x0600 && codeUnit <= 0x06FF);
}

// Remove empty lines from a string
String removeEmptyLines(String text) {
  List<String> lines =
      text.trim().split('\n').where((line) => line.trim().isNotEmpty).toList();
  return lines.join('\n');
}

String formatNumber(int number) {
  if (number < 10000) {
    // If the number is less than 10,000, return it as is.
    return number.toString();
  } else if (number < 1000000) {
    // If the number is between 10,000 and 999,999, format it with 'k'.
    double thousands = number / 1000;
    return '${thousands.toStringAsFixed(0)}k';
  } else if (number >= 1000000) {
    // If the number is one million or more, format it with 'M'.
    double millions = number / 1000000;
    return '${millions.toStringAsFixed(0)}M';
  }
  return number.toString();
}

Future<GiphyGif?> pickGif(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyGet.getGif(
      context: context,
      apiKey: 'dsW7gRQ0OrEqegEYi9Xh8MeOjFwuiZTW',
    );
  } catch (e) {
    AppDialogs.showToast(msg: e.toString());
  }
  return gif;
}

Future<void> selectGif(ChatCubit cubit, context, receiverId) async {
  final gif = await pickGif(context);
  if (gif != null) {
    cubit.sendGifMessage(
      MessageParams(
        receiverId: receiverId,
        message: gif.images!.original!.url,
        messageType: MessageType.gif,
        messageReplay: cubit.messageReplay,
      ),
    );
  }
}

/// Deletes a file safely
Future<void> deleteFile(File? file) async {
  if (file != null && await file.exists()) {
    try {
      await file.delete();
    } catch (e) {
      if (kDebugMode) print("Error deleting file: $e");
    }
  }
}

/// Clears the cache directory
Future<void> clearCache() async {
  try {
    final tempDir = await getTemporaryDirectory();
    await tempDir.delete(recursive: true);
  } catch (e) {
    if (kDebugMode) {
      print("Error clearing cache: $e");
    }
  }
}
