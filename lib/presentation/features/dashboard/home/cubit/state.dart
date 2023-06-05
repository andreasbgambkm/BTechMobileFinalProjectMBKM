part of 'cubit.dart';

class HomeState extends Equatable {
  final String greeting;
  final String formattedDate;

  HomeState({required this.greeting, required this.formattedDate});

  @override
  List<Object?> get props => [greeting, formattedDate];

  HomeState copyWith({String? greeting, String? formattedDate}) {
    return HomeState(
      greeting: greeting ?? this.greeting,
      formattedDate: formattedDate ?? this.formattedDate,
    );
  }

}
