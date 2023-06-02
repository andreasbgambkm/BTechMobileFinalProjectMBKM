part of 'scan_checkin_cubit.dart';

abstract class ScanCheckinState extends Equatable {
  const ScanCheckinState();

  @override
  List<Object> get props => [];
}

class ScanCheckinInitial extends ScanCheckinState {}

class ScanCheckinLoading extends ScanCheckinState {}
class ScanCheckinSuccess extends ScanCheckinState {
  final String barcodeType;
  final String data;
  final Employee employee; // Tambahkan atribut employee

  ScanCheckinSuccess(this.barcodeType, this.data, this.employee);
}

class ScanCheckinError extends ScanCheckinState {
  final String errorMessage;

  ScanCheckinError(this.errorMessage);
}

class CameraState extends ScanCheckinState {
  final bool isCameraOpen;

  const CameraState(this.isCameraOpen);

  @override
  List<Object> get props => [isCameraOpen];
}