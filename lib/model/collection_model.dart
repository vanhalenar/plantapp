class Plant {
  int databaseId;
  String nickname;
  int needWater;
  int needFertilizer;

  Plant(
      {required this.databaseId,
      required this.nickname,
      required this.needWater,
      required this.needFertilizer});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        databaseId: json["databaseId"],
        nickname: json["nickname"],
        needWater: json["needWater"],
        needFertilizer: json["needFertilizer"]);
  }
}
