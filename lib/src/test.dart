void main() {
  print('mosab');
  List<DateTime> dd = getDates(6);
  dd.forEach((element) {
    print(element.toString());
  });
}

List<DateTime> getDates(int daysFormat) {
  List<DateTime> dates = [];
  DateTime initDate = DateTime.now();
  int weekNum = initDate.weekday;
  int value;
  switch (daysFormat) {
    case 6:
      value =
          (7 - weekNum) == 2 ? (weekNum + (7 - weekNum)) : (weekNum + 2) % 7;
      break;
    case 0:
      value =
          (7 - weekNum) == 1 ? (weekNum + (7 - weekNum)) : (weekNum + 1) % 7;
      break;
    case 1:
      value =
          (7 - weekNum) == 0 ? (weekNum + (7 - weekNum)) : (weekNum + 0) % 7;
      break;
    case 2:
      value =
          (7 - weekNum) == 6 ? (weekNum + (7 - weekNum)) : (weekNum + -1) % 7;
      break;
    case 3:
      value =
          (7 - weekNum) == 5 ? (weekNum + (7 - weekNum)) : (weekNum + -2) % 7;
      break;
    case 4:
      value =
          (7 - weekNum) == 4 ? (weekNum + (7 - weekNum)) : (weekNum + -3) % 7;
      break;
    case 5:
      value = (7 - weekNum) == 3
          ? (weekNum + (7 - weekNum))
          : (weekNum + (weekNum - 7)) % 7;
      break;
  }
  for (int i = 1; i <= 7; i++) {
    if (value < i) {
      dates.add(initDate.subtract(Duration(days: value - i)));
    } else if (value == i) {
      dates.add(initDate);
    } else {
      dates.add(initDate.add(Duration(days: i - value)));
    }
  }
  return dates;
}
