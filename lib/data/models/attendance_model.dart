class Attendance {
  int? id;
  String nik;
  String name;
  int? idCheckIn;
  int? idCheckOut;
  int isCheckedIn;
  String? checkInTime;
  int isCheckedOut;
  String checkoutTime;
  String? note;
  String createdAt;

  Attendance({
     this.id,
    required this.nik,
    required this.name,
     this.idCheckIn,
    this.idCheckOut,
    required this.isCheckedIn,
    this.checkInTime,
    required this.isCheckedOut,
    required this.checkoutTime,
     this.note,
    required this.createdAt,
  });

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      nik: map['nik'],
      name: map['name'],
      idCheckIn: map['idCheckIn'],
      idCheckOut: map['idCheckOut'],
      isCheckedIn: map['isCheckedIn'],
      checkInTime: map['checkInTime'],
      isCheckedOut: map['isCheckedOut'],
      checkoutTime: map['checkoutTime'],
      note: map['note'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'idCheckIn': idCheckIn,
      'idCheckOut': idCheckOut,
      'isCheckedIn': isCheckedIn,
      'checkInTime': checkInTime,
      'isCheckedOut': isCheckedOut,
      'checkoutTime': checkoutTime,
      'note': note,
      'createdAt': createdAt,
    };
  }


}
