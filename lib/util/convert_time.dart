String intToTimeLeft(int value) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value)) ~/ 60;

  s = value - (m * 60);

  // String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

  String minuteLeft =
  m.toString().length < 2 ? "0" + m.toString() : m.toString();

  String secondsLeft =
  s.toString().length < 2 ? "0" + s.toString() : s.toString();

  String result = "$minuteLeft:$secondsLeft";

  return result;
}