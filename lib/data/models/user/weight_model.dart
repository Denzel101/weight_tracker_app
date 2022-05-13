class WeightModel {
  final String userWeight;
  final String id;
  final String uid;
  final DateTime dateTime;

  WeightModel(
      {required this.userWeight,
      required this.id,
      required this.uid,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'userWeight': userWeight,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'id': id,
      'uid': uid,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      userWeight: map['userWeight'] ?? '',
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }
}
