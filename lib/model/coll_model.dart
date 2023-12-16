class Collection {
  int databaseId;
  String nickname;
  String photo;
  DateTime datePlanted;
  DateTime lastWatered;
  DateTime lastFertilized;
  String notes;

  Collection({
    required this.databaseId,
    required this.nickname,
    this.photo = "",
    DateTime? datePlanted,
    DateTime? lastWatered,
    DateTime? lastFertilized,
    this.notes = "",
  })  : datePlanted = datePlanted ?? DateTime.now(),
        lastWatered = lastWatered ?? DateTime.now(),
        lastFertilized = lastFertilized ?? DateTime.now();

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      databaseId: json["databaseId"],
      nickname: json["nickname"],
      photo: json["photo"] ?? "",
       datePlanted: json["datePlanted"] != null
          ? DateTime.parse(json["datePlanted"])
          : DateTime.now(),
      lastWatered: json["lastWatered"] != null
          ? DateTime.parse(json["lastWatered"])
          : DateTime.now(),
      lastFertilized: json["lastFertilized"] != null
          ? DateTime.parse(json["lastFertilized"])
          : DateTime.now(),
      notes: json["notes"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'databaseId': databaseId,
      'nickname': nickname,
      'photo': photo,
      'datePlanted': datePlanted.toIso8601String(),
      'lastWatered': lastWatered.toIso8601String(),
      'lastFertilized': lastFertilized.toIso8601String(),
      'notes': notes,
    };
  }
}
