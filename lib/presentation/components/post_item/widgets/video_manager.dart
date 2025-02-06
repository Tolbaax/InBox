import 'package:video_player/video_player.dart';

class VideoManager {
  static final VideoManager _instance = VideoManager._internal();
  VideoPlayerController? _currentController;

  factory VideoManager() => _instance;

  VideoManager._internal();

  void setController(VideoPlayerController newController) {
    if (_currentController != null && _currentController != newController) {
      _currentController!.pause();
    }
    _currentController = newController;
  }

  void stopCurrentVideo() {
    _currentController?.pause();
    _currentController = null;
  }
}
