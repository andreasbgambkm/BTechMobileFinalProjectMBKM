class CheckInModel {
  final String name;
  final String nik;
  final DateTime? checkin_time;
  final String? note;
  final String label;


  CheckInModel(this.name, this.nik, this.checkin_time, this.note, this.label);
}