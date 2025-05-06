import 'package:intl/intl.dart';

// Function to find the next Tuesday
DateTime findNextTuesday(DateTime date) {
  // Find the number of days to add to reach the next Tuesday
  const int daysInWeek = 7;
  const int tuesday = DateTime.tuesday;

  // Calculate the difference in days between the given date's weekday and Tuesday
  int daysToAdd = (tuesday - date.weekday + daysInWeek) % daysInWeek;

  // If the given date is already a Tuesday, we return it as is
  if (daysToAdd == 0) {
    return date;
  }

  // Add the calculated number of days to the given date
  return date.add(Duration(days: daysToAdd));
}

String returnDay(DateTime date) {
  var outputFormat = DateFormat('dd MMM');
  var output = outputFormat.format(date.toLocal());

  return output.toString();
}
