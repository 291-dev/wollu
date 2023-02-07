class User {
  int id = 0;
  late String nickname;
  int salary = 0;
  int week_work = 0;
  int day_work = 0;
  late String job;
  late String annual;
  int sex = 0;
  late String age;

  User({
    required this.id,
    required this.nickname,
    required this.salary,
    required this.week_work,
    required this.day_work,
    required this.job,
    required this.annual,
    required this.sex,
    required this.age,
  });

  User.fromMap(Map<String, dynamic>? map) {
    nickname = map?['nickname'] ?? '';
    salary = map?['salary'] ?? '';
    week_work = map?['week_work'] ?? '';
    day_work = map?['day_work'] ?? '';
    job = map?['job'] ?? '';
    annual = map?['annual'] ?? '';
    sex = map?['sex'] ?? '';
    age = map?['age'] ?? '';
  }
}