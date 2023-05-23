part of 'checkin_cubit.dart';

class CheckInState extends Equatable {
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

  factory CheckInState.initial() {
    return const CheckInState(
      isLoading: false,
      isSuccess: false,
      isEmpty: true,
      error: '',
      checkInList: [],
      checkInCount: 0,
    );
  }

  factory CheckInState.loading() {
    return const CheckInState(
      isLoading: true,
      isSuccess: false,
      isEmpty: true,
      error: '',
      checkInList: [],
      checkInCount: 0,
    );
  }

  factory CheckInState.success(List<CheckInModel> checkIns) {
    return CheckInState(
      isLoading: false,
      isSuccess: true,
      isEmpty: checkIns.isEmpty,
      error: '',
      checkInList: checkIns,
      checkInCount: checkIns.length,
    );
  }

  factory CheckInState.empty() {
    return const CheckInState(
      isLoading: false,
      isSuccess: false,
      isEmpty: true,
      error: '',
      checkInList: [],
      checkInCount: 0,
    );
  }

  factory CheckInState.failure(String error) {
    return CheckInState(
      isLoading: false,
      isSuccess: false,
      isEmpty: true,
      error: error,
      checkInList: [],
      checkInCount: 0,
    );
  }

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

class CheckInInitial extends CheckInState {
  const CheckInInitial() : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkInList,
    checkInCount,
  ];
}

class CheckInLoading extends CheckInState {
  const CheckInLoading() : super(
    isLoading: true,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkInList,
    checkInCount,
  ];
}

class CheckInSuccess extends CheckInState {
  const CheckInSuccess(List<CheckInModel> checkIns) : super(
    isLoading: false,
    isSuccess: true,
    isEmpty: false,
    error: '',
    checkInList: checkIns,
    checkInCount: checkIns.length,
  );

  @override
  List<Object> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkInList,
    checkInCount,
  ];
}

class CheckInEmpty extends CheckInState {
  const CheckInEmpty() : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkInList,
    checkInCount,
  ];
}

class CheckInFailure extends CheckInState {
  const CheckInFailure(String error) : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: error,
    checkInList: const [],
    checkInCount: 0,
  );

  @override
  List<Object> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkInList,
    checkInCount,
  ];
}
