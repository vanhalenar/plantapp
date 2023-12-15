class Task {
  int databaseId;
  String nickname;
  int needWater;
  int needFertilizer;
  DateTime date;

  Task(
      {required this.databaseId,
      required this.nickname,
      required this.needWater,
      required this.needFertilizer,
      required this.date});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        databaseId: json["databaseId"],
        nickname: json["nickname"],
        needWater: json["needWater"],
        needFertilizer: json["needFertilizer"],
        date: DateTime.parse(json["date"]));
  }

  Map<String, dynamic> toJson() => {
        'databaseId': databaseId,
        'nickname': nickname,
        'needWater': needWater,
        'needFertilizer': needFertilizer,
        'date': date.toIso8601String()
      };
}
