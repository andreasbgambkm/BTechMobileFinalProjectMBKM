
part of 'checkout_cubit.dart';

abstract class CheckOutState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isEmpty;
  final String error;
  final List<CheckOutModel> checkoutList;
  final int checkoutCount;

  const CheckOutState({
    required this.isLoading,
    required this.isSuccess,
    required this.isEmpty,
    required this.error,
    required this.checkoutList,
    required this.checkoutCount,
  });

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isEmpty,
    error,
    checkoutList,
    checkoutCount,
  ];
}

class CheckOutLoading extends CheckOutState {
  const CheckOutLoading()
      : super(
    isLoading: true,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkoutList: const [],
    checkoutCount: 0,
  );

  @override
  List<Object?> get props => super.props;
}

class CheckOutSuccess extends CheckOutState {
  CheckOutSuccess(List<CheckOutModel> checkouts) : super(
    isLoading: false,
    isSuccess: true,
    isEmpty: checkouts.isEmpty,
    error: '',
    checkoutList: checkouts,
    checkoutCount: checkouts.length,
  );

  @override
  List<Object?> get props => super.props;
}

class CheckOutEmpty extends CheckOutState {
  const CheckOutEmpty()
      : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: '',
    checkoutList: const [],
    checkoutCount: 0,
  );

  @override
  List<Object?> get props => super.props;
}

class CheckOutFailure extends CheckOutState {
  const CheckOutFailure(String error)
      : super(
    isLoading: false,
    isSuccess: false,
    isEmpty: true,
    error: error,
    checkoutList: const [],
    checkoutCount: 0,
  );

  @override
  List<Object?> get props => super.props;
}
