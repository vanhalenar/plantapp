class Task {
  int databaseId;
  String nickname;
  int needWater;
  int needFertilizer;

  Task(
      {required this.databaseId,
      required this.nickname,
      required this.needWater,
      required this.needFertilizer});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        databaseId: json["databaseId"],
        nickname: json["nickname"],
        needWater: json["needWater"],
        needFertilizer: json["needFertilizer"]);
  }

  Map<String, dynamic> toJson() => {
        'databaseId': databaseId,
        'nickname': nickname,
        'needWater': needWater,
        'needFertilizer': needFertilizer
      };
}
