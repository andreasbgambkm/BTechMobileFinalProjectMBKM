
part of'checkout_cubit_cubit.dart';

class CheckOutState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isEmpty;
  final String error;
  final List<CheckOutModel> CheckOutList;
  final int CheckOutCount;

  const CheckOutState({
    required this.isLoading,
    required this.isSuccess,
    required this.isEmpty,
    required this.error,
    required this.CheckOutList,
    required this.CheckOutCount,
  });

  factory CheckOutState.initial() {
    return const CheckOutState(
      isLoading: false,
      isSuccess: false,
      isEmpty: true,
      error: '',
      CheckOutList: [],
      CheckOutCount: 0,
    );
  }

  factory CheckOutState.loading() {
    return const CheckOutState(
      isLoading: true,
      isSuccess: false,
      isEmpty: true,
      error: '',
      CheckOutList: [],
      CheckOutCount: 0,
    );
  }

  factory CheckOutState.success(List<CheckOutModel> CheckOuts) {
    return CheckOutState(
      isLoading: false,
      isSuccess: true,
      isEmpty: CheckOuts.isEmpty,
      error: '',
      CheckOutList: CheckOuts,
      CheckOutCount: CheckOuts.length,
    );
  }

  factory CheckOutState.empty() {
    return const CheckOutState(
      isLoading: false,
      isSuccess: false,
      isEmpty: true,
      error: '',
      CheckOutList: [],
      CheckOutCount: 0,
    );
  }

  factory CheckOutState.failure(String error) {
    return CheckOutState(
      isLoading: false,
      isSuccess: false,
      isEmpty: true,
      error: error,
      CheckOutList: [],
      CheckOutCount: 0,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isEmpty, error, CheckOutList, CheckOutCount];
}
