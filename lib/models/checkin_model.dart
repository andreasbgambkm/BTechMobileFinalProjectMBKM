class CheckInModel {
  int? id;
  String nik;
  String name;
  int isCheckedIn;
  String? checkinTime;

  CheckInModel({
    this.id,
    required this.nik,
    required this.name,
    this.isCheckedIn = 0,
    this.checkinTime,
  });

  // konversi dari objek CheckIn menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id'  : id,
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


