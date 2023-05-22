class CheckOutModel {
  int? id;
  String nik;
  String name;
  int isCheckedOut;
  String? checkoutTime;
  String? note;

  CheckOutModel({
    this.id,
    required this.nik,
    required this.name,
    this.isCheckedOut = 0,
    this.checkoutTime,
    this.note

  });

  // konversi dari objek CheckIn menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id'  : id,
      'nik': nik,
      'name': name,
      'isCheckedOut': isCheckedOut,
      'checkoutTime': checkoutTime,
      'note'        : note,
    };
  }

  // konversi dari Map menjadi objek CheckIn
  factory CheckOutModel.fromMap(Map<String, dynamic> map) {
    return CheckOutModel(
      id: map['id'],
      nik: map['nik'],
      name: map['name'],
      isCheckedOut: map['isCheckedOut'],
      checkoutTime: map['checkoutTime'],
      note: map['note'],
    );
  }



}


