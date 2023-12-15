class Collection {
  int databaseId;
  String nickname;
  String photo;
  String datePlanted;
  String lastWatered;
  String lastFertilized;
  String notes;

  Collection({
    required this.databaseId,
    required this.nickname,
    this.photo = "",
    this.datePlanted = "",
    this.lastWatered = "",
    this.lastFertilized = "",
    this.notes = "",
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      databaseId: json["databaseId"],
      nickname: json["nickname"],
      photo: json["photo"] ?? "",
      datePlanted: json["datePlanted"] ?? "",
      lastWatered: json["lastWatered"] ?? "",
      lastFertilized: json["lastFertilized"] ?? "",
      notes: json["notes"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'databaseId': databaseId,
      'nickname': nickname,
      'photo': photo,
      'datePlanted': datePlanted,
      'lastWatered': lastWatered,
      'lastFertilized': lastFertilized,
      'notes': notes,
    };
  }
}
