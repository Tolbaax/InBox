import 'package:intl/intl.dart';

String formatPostTime(String postTimeStr) {
  final postTime = DateTime.parse(postTimeStr);
  final now = DateTime.now();
  final difference = now.difference(postTime);
  final timeFormatter = (postTime.year == now.year)
      ? DateFormat('MMM d')
      : DateFormat('MMM d, yyyy');

  if (difference.inSeconds < 60) {
    return 'now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d';
  } else {
    return timeFormatter.format(postTime);
  }
}
