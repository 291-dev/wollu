class Category {
  String image;
  String name;
  int time = 0;
  bool played = false;

  Category({
    required this.image,
    required this.name,
  });

  void togglePlay() {
    played = !played;
  }

  bool getPlay() {
    return played;
  }

  void setTime(int time) {
    this.time = time;
  }

  int getTime() {
    return time;
  }
}