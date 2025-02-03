import 'package:intl/intl.dart';

class DateConverter {
  static String getChatContactTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();

    if (localDateTime.isAfter(now.subtract(const Duration(days: 1)))) {
      // Within the last 24 hours
      String amPm = localDateTime.hour < 12 ? 'AM' : 'PM';
      int hour = localDateTime.hour > 12
          ? localDateTime.hour - 12
          : localDateTime.hour;
      String minute = localDateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute $amPm';
    } else if (localDateTime.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return dateConverterMonthNum(dateTime.toString());
    }
  }

  static String getChatDayTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Today';
    } else if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return 'Yesterday';
    } else {
      return dateConverterMonth(dateTime.toString());
    }
  }

  static String getLastSeenDayTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();

    if (isSameDay(now, localDateTime)) {
      return 'today';
    } else if (isSameDay(now.subtract(const Duration(days: 1)), localDateTime)) {
      return 'yesterday';
    } else {
      return dateConverterMonthNum(dateTime.toString());
    }
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String dateConverterHoursAmPmMode(DateTime dateTime) {
    final String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }

  static String dateConverterMonth(String string) {
    String monthNum = string.substring(5, 7);
    String dayNum = string.substring(8, 10);

    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    int monthIndex = int.parse(monthNum) - 1; // Convert to 0-based index

    String formattedDate =
        '$dayNum ${months[monthIndex]} ${string.substring(0, 4)}';
    return formattedDate;
  }

  static String dateConverterMonthNum(String string) {
    String monthNum = string.substring(5, 7);
    String dayNum = string.substring(8, 10);

    List<String> mN = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ];

    for (int i = 0; i < 12; ++i) {
      if (monthNum == mN[i]) {
        return '$dayNum/${mN[i]}/${string.substring(2, 4)}';
      }
    }

    return "";
  }

  static String dateConverterOnly(String string) {
    String s = "";
    s = string.split("T")[0];
    return s;
  }

  static String dateConverterSince(String string) {
    int apiDay = int.parse(string.substring(8, 10));
    int currentDay = DateTime.now().day;

    if (currentDay == apiDay) {
      return "Today";
    } else if (currentDay == apiDay + 1) {
      return "Yesterday";
    } else if (currentDay > apiDay + 1) {
      return "Since ${currentDay - apiDay} days";
    }

    return "";
  }

  static String dateConverterHours24Mode(String string) {
    return string.substring(11, 16);
  }
}
