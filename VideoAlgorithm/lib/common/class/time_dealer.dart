class TimeDealer{
  static String getTimeFromSecond(int second) {
    int minutes = second ~/ 60;
    int finalSecond = second - minutes * 60;
    int finalHour = minutes ~/ 60;
    int finalMinutes = minutes - finalHour * 60;
    if (finalHour != 0) {
      return "${"$finalHour".padLeft(2, "0")}:${"$finalMinutes".padLeft(
          2, "0")}:${"$finalSecond".padLeft(2, "0")} Hours";
    }
    else if (finalMinutes != 0) {
      return "${"$finalMinutes".padLeft(2, "0")}:${"$finalSecond".padLeft(
          2, "0")} Minutes";
    }
    else {
      return "${finalSecond.toString().padLeft(2, "0")} Seconds";
    }
  }

}