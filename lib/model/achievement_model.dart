class Achievement {
  int databaseId;
  String achievement;
  int max;
  int current;

  Achievement(
      {required this.databaseId,
      required this.achievement,
      required this.max,
      required this.current});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
        databaseId: json["databaseId"],
        achievement: json["achievement"],
        max: json["max"],
        current: json["current"]);
  }

  Map<String, dynamic> toJson() => {
        'databaseId': databaseId,
        'achievement': achievement,
        'max': max,
        'current': current
      };
}
