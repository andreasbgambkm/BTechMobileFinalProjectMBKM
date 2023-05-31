
part of 'checkin_cubit.dart';

abstract class CheckInState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isEmpty;
  final String error;
  final List<CheckInModel> checkInList;
  final int checkInCount;

  const CheckInState({
    required this.isLoading,
    required this.isSuccess,
    required this.isEmpty,
    required this.error,
    required this.checkInList,
    required this.checkInCount,
  });

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkInList,
    checkInCount,
  ];
}

class CheckInLoading extends CheckInState {
  const CheckInLoading()
      : super(
    isLoading: true,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object?> get props => super.props;
}

class CheckInSuccess extends CheckInState {
  CheckInSuccess(List<CheckInModel> checkIns) : super(
    isLoading: false,
    isSuccess: true,
    isEmpty: checkIns.isEmpty,
    error: '',
    checkInList: checkIns,
    checkInCount: checkIns.length,
  );

  @override
  List<Object?> get props => super.props;
}

class CheckInEmpty extends CheckInState {
  const CheckInEmpty()
      : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object?> get props => super.props;
}

class CheckInFailure extends CheckInState {
  const CheckInFailure(String error)
      : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: error,
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object?> get props => super.props;
}
