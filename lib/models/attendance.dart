class Attendance {
  int id;
  int employeeId;
  int checkInId;
  int checkOutId;
  String createdAt;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.checkInId,
    required this.checkOutId,
    required this.createdAt,
  });
}
