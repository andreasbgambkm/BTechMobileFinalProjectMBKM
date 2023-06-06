
class Kemandoran {
 String id;
 String divisionId;
 String estateId;
   String kemandoran;
   String group;

  Kemandoran({
    required this.id,
    required this.divisionId,
    required this.estateId,
    required this.kemandoran,
    required this.group
  });

  Map<String, dynamic> toMap() {
    return {
      'id_kemandoran': id,
      'id_division': divisionId,
      'id_estate': estateId,
      'kemandoran': kemandoran,
      'groupName': group
    };
  }

  factory Kemandoran.fromMap(Map<String, dynamic> map) {
    return Kemandoran(
      id: map['id_kemandoran'],
      divisionId: map['id_division'],
      estateId: map['id_estate'],
      kemandoran: map['kemandoran'],
      group: map['groupName']
    );
  }

  factory Kemandoran.fromJson(Map<String, dynamic> json) {
    return Kemandoran(
      id: json['id_kemandoran'],
      divisionId: json['id_division'],
      estateId: json['id_estate'],
      kemandoran: json['kemandoran'],
      group: json['groupName']
    );
  }

}
