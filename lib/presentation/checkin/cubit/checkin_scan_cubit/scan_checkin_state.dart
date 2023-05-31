
part of 'scan_checkin_cubit.dart';

abstract class QRScannerState {

}

class QRScannerInitial extends QRScannerState {}

class QRScannerLoading extends QRScannerState {}

class QRScannerSuccess extends QRScannerState {
  final Employee employee;
  final String barcodeType;

  QRScannerSuccess(this.employee, this.barcodeType);
}

class QRScannerError extends QRScannerState {
  final String errorMessage;

  QRScannerError(this.errorMessage);
}

class QRScannerSelectOption extends QRScannerState{

  final String selectedOption;
  QRScannerSelectOption(this.selectedOption);
}