class Plant {
  int databaseId;
  String nickname;

  Plant({
    required this.databaseId,
    required this.nickname
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      databaseId: json["databaseId"],
      nickname: json["nickname"],
    );
  }

  Map<String, dynamic> toJson() => {
    'databaseId': databaseId,
    'nickname': nickname,
  };
}