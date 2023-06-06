class AssistanceOut {
  final String id;
  final String assistanceType;
  final String employeeNik;
  final String employeeName;
  final int employeeAge;
  final String employeePosition;
  final String division;
  final String kemandoran;
  final String estate;
  final String assistanceOutTime;

  AssistanceOut({
    required this.id,
    required this.assistanceType,
    required this.employeeNik,
    required this.employeeName,
    required this.employeeAge,
    required this.employeePosition,
    required this.division,
    required this.kemandoran,
    required this.estate,
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
      'assistance_out_time': assistanceOutTime,
    };
  }

  factory AssistanceOut.fromMap(Map<String, dynamic> map) {
    return AssistanceOut(
      id: map['id_assistance'],
      assistanceType: map['assistance_type'],
      employeeNik: map['employee_nik'],
      employeeName: map['employee_name'],
      employeeAge: map['employee_age'],
      employeePosition: map['employee_position'],
      division: map['division'],
      kemandoran: map['kemandoran'],
      estate: map['estate'],
      assistanceOutTime: map['assistance_out_time'],
    );
  }
}