class WolluByMonth {
  List<Wollu> wollus =
      List.generate(31, (index) {
        return Wollu(index+1, 0);
      });
}

class Wollu {
  var day = -1;
  var time = -1;

  Wollu(this.day, this.time);

  void setTime(int time) {
    this.time = time;
  }
}