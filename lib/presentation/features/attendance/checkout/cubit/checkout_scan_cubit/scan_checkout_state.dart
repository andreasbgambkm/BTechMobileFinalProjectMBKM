part of 'scan_checkout_cubit.dart';

abstract class ScanCheckoutState extends Equatable {
  const ScanCheckoutState();

  @override
  List<Object> get props => [];
}

class ScanCheckoutInitial extends ScanCheckoutState {}

class ScanCheckoutLoading extends ScanCheckoutState {}
class ScanCheckoutSuccess extends ScanCheckoutState {
  final String barcodeType;
  final String data;
  final Employee employee; // Tambahkan atribut employee

  ScanCheckoutSuccess(this.barcodeType, this.data, this.employee);
}

class ScanCheckoutError extends ScanCheckoutState {
  final String errorMessage;

  ScanCheckoutError(this.errorMessage);
}

class CameraState extends ScanCheckoutState {
  final bool isCameraOpen;

  const CameraState(this.isCameraOpen);

  @override
  List<Object> get props => [isCameraOpen];
}