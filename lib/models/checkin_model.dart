
final String tableName = 'CheckIn';

class CheckInModel {
  int? id;
  String? nik;
  String? name;
  int? isCheckedIn;
  String? checkinTime;

  CheckInModel({
    this.id,
    this.nik,
    this.name,
    this.isCheckedIn,
    this.checkinTime,
  });

  // konversi dari objek CheckIn menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'isCheckedIn': isCheckedIn,
      'checkinTime': checkinTime,
    };
  }

  // konversi dari Map menjadi objek CheckIn
  factory CheckInModel.fromMap(Map<String, dynamic> map) {
    return CheckInModel(
      id: map['id'],
      nik: map['nik'],
      name: map['name'],
      isCheckedIn: map['isCheckedIn'],
      checkinTime: map['checkinTime'],
    );
  }
}
