class AssistanceOutModel {
   int? id;
  final String assistanceType;
  final String employeeNik;
  final String employeeName;
   int? employeeAge;
  final String employeePosition;
  final String division;
  final String kemandoran;
  final String estate;
  int isAssistedOut;
  final String assistanceOutTime;

  AssistanceOutModel({
    this.id,
    required this.assistanceType,
    required this.employeeNik,
    required this.employeeName,
    this.employeeAge,
    required this.employeePosition,
    required this.division,
    required this.kemandoran,
    required this.estate,
    this.isAssistedOut = 0,
    required this.assistanceOutTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_assistance': id,
      'assistance_type': assistanceType,
      'employee_nik': employeeNik,
      'employee_name': employeeName,
      'employee_age': employeeAge,
      'employee_position': employeePosition,
      'division': division,
      'kemandoran': kemandoran,
      'estate': estate,
      'isAssistedOut': isAssistedOut,
      'assistance_out_time': assistanceOutTime,
    };
  }

  factory AssistanceOutModel.fromMap(Map<String, dynamic> map) {
    return AssistanceOutModel(
      id: map['id_assistance'],
      assistanceType: map['assistance_type'],
      employeeNik: map['employee_nik'],
      employeeName: map['employee_name'],
      employeeAge: map['employee_age'],
      employeePosition: map['employee_position'],
      division: map['division'],
      kemandoran: map['kemandoran'],
      estate: map['estate'],
      isAssistedOut: map['isAssistedOut'],
      assistanceOutTime: map['assistance_out_time'],
    );
  }
}