class UserColl {
  String collName;
  var plantIds = [];
  var plantNames = [];

  UserColl({
    required this.collName,
    required this.plantIds,
    required this.plantNames
  });

  factory UserColl.fromJson(Map<String, dynamic> json) {
    return UserColl(
      collName: json["collName"],
      plantIds: json["plantIds"],
      plantNames: json["plantNames"]
    );
  }

  Map<String, dynamic> toJson() => {
    'collName': collName,
    'plantIds': plantIds,
    'plantNames': plantNames
  };
}