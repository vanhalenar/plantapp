class Achievement {
  int databaseId;
  String nickname;
  String achievement;
  int type;
  int max;
  int current;

  Achievement(
      {required this.databaseId,
      required this.nickname,
      required this.achievement,
      required this.type,
      required this.max,
      required this.current});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
        databaseId: json["databaseId"],
        nickname: json["nickname"],
        achievement: json["achievement"],
        type: json["type"],
        max: json["max"],
        current: json["current"]);
  }

  Map<String, dynamic> toJson() => {
        'databaseId': databaseId,
        'nickname': nickname,
        'achievement': achievement,
        'type': type,
        'max': max,
        'current': current
      };
}
