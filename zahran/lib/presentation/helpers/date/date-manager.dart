import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

abstract class DateManegerHelper {
  DateTime now();
  int nowInMillisecond();
}

class DateTimeManager implements DateManegerHelper {
  static const int SECONDS_PER_DAY = 86400;
  static const int MINUTES_PER_DAY = 1440;
  static const int HOURS_PER_DAY = 24;

  DateTime now() {
    return new DateTime.now();
  }

  int nowInMillisecond() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static String convertDateTimeToAppFormat(DateTime dateTime) {
    final DateFormat formatter = DateFormat.yMMMMd().add_jm();
    return formatter.format(dateTime);
  }

  static int convertDateToDurationInSeconds(String date) {
    var now = new DateTime.now();
    var dateVar = DateTime.parse(date);
    if (dateVar.isAfter(now)) {
      Duration difference = dateVar.difference(now);
      return difference.inSeconds;
    }
    return 0;
  }

  static String getFormattedTimeFromUTCTime(String time) {
    return formatDate(DateFormat("Hms").parse(time, true).toLocal(), ["h", ":", "nn", " ", "am"]);
  }

  static String getFormattedTimeFromUTCDate(String date) {
    return formatDate(DateFormat("yyyy-MM-ddThh:mmZ").parse(date, true).toLocal(), ["h", ":", "nn", " ", "am"]);
  }

  static String getFormattedDateFromUTCDate(String date) {
    return formatDate(DateFormat("yyyy-MM-ddThh:mmZ").parse(date, true).toLocal(), ["dd", " ", "M", " ", "yyyy"]);
  }

  static String getFormattedNonUTCDateFromDate(String date) {
    return formatDate(DateFormat("yyyy-MM-ddThh:mmZ").parse(date, false), ["dd", " ", "M", " ", "yyyy"]);
  }

  static String getFormattedDateTimeFromUTCDate(String date) {
    return formatDate(DateFormat("yyyy-MM-ddThh:mmZ").parse(date, true).toLocal(),
        ["dd", " ", "M", " ", "yyyy", " at ", "h", ":", "nn", " ", "am"]);
  }

  static bool isTimeBetween({String? value, String? from, String? to}) {
    Time time = getTimeObjectFromString(value ?? '');
    Time start = getTimeObjectFromString(from ?? '');
    Time end = getTimeObjectFromString(to ?? '');
    var currentDate = DateTime(2020, 1, 1, time.hour, time.minute).millisecondsSinceEpoch;
    var startDate = DateTime.utc(2020, 1, 1, start.hour, start.minute).toLocal().millisecondsSinceEpoch;
    var endDate = DateTime.utc(2020, 1, 1, end.hour, end.minute).toLocal().millisecondsSinceEpoch;

    if (startDate == endDate) {
      return true;
    } else if (endDate > startDate) {
      return (currentDate >= startDate && currentDate <= endDate);
    } else if (startDate > endDate) {
      return !(currentDate >= endDate && currentDate <= startDate);
    } else {
      return false;
    }
  }

  static Time getTimeObjectFromString(String timeString) {
    List<String> hourMinutes = timeString.split(":");
    String hour = hourMinutes[0];
    String minute = hourMinutes[1];
    int hourInt = int.parse(hour);
    int minuteInt = int.parse(minute);
    return Time(hour: hourInt, minute: minuteInt);
  }

  static String getCurrentFormattedTime() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm', "en");
    return formatter.format(now);
  }

  static String getTimerFormat(DateTime date) {
    return formatDate(date, [nn, ':', ss]);
  }

  static int getRemainingDaysCountByHours(String expiryDate) {
    int hours = DateTime.parse(expiryDate).difference(DateTime.now()).inHours;
    return (hours / HOURS_PER_DAY).ceil();
  }

  static int getRemainingDaysCountByMinutes(String expiryDate) {
    int minutes = DateTime.parse(expiryDate).difference(DateTime.now()).inMinutes;
    return (minutes / MINUTES_PER_DAY).ceil();
  }

  static int getRemainingDaysCountBySeconds(String expiryDate) {
    int seconds = DateTime.parse(expiryDate).difference(DateTime.now()).inSeconds;
    return (seconds / SECONDS_PER_DAY).ceil();
  }
}

class Time {
  int hour;
  int minute;

  Time({required this.hour, required this.minute});
}
