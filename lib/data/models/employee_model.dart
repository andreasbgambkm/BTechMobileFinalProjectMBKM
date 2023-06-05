class Employee {

  String nik;
  String name;
  int? age;
  String? position;
  String? division;
  String? kemandoran;


  Employee({required this.nik, required this.name, required this.position, this.division, this.kemandoran, });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'name': name,
      'age' : age,
      'position' : position,
      'division' : division,
      'kemandoran': kemandoran,
    };
  }

  static Employee fromMap(Map<String, dynamic> map) {
    return Employee(
      nik: map['nik'],
      name: map['name'],
      position: map['position'],
      division: map['division'],
      kemandoran: map['kemandoran'],

    );
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      nik: json['nik'],
      name: json['name'],
      position: json['position'],
      division: json['division'],
      kemandoran: json['kemandoran'],
    );
  }

}
