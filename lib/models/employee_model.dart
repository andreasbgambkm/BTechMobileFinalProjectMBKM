class Employee {

  String nik;
  String name;
  int? age;
  String? position;
  String? division;
  String? kemandoran;
  int isCheckedIn ;
  int isCheckedOut;
  String? checkinTime;


  Employee({ this.isCheckedIn = 0, this.age, this.isCheckedOut = 0, required this.nik, required this.name, required this.position, this.division, this.kemandoran, this.checkinTime});

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'name': name,
      'age' : age,
      'position' : position,
      'division' : division,
      'kemandoran': kemandoran,
      'isCheckedIn': isCheckedIn,
      'isCheckedOut': isCheckedOut,
      'checkin_time': checkinTime,
    };
  }

  static Employee fromMap(Map<String, dynamic> map) {
    return Employee(
      nik: map['nik'],
      name: map['name'],
      age: map['age'],
      position: map['position'],
      division: map['division'],
      kemandoran: map['kemandoran'],
      isCheckedIn: map['isCheckedIn'],
      isCheckedOut: map['isCheckedOut'],
      checkinTime: map['checkin_time']

    );
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      nik: json['nik'],
      name: json['name'],
      age: json['age'],
      position: json['position'],
      division: json['division'],
      kemandoran: json['kemandoran'],
      isCheckedIn: json['isCheckedIn'],
      isCheckedOut: json['isCheckedOut'],
      checkinTime: json['checkinTime'],
    );
  }

}
