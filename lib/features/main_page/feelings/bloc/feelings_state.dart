part of 'feelings_bloc.dart';

class FeelingsState extends Equatable {
  final FeelingsStatus status;
  final List<FeelingModel> listFeelings;
  final FeelingModel? currentFeeling;

  const FeelingsState._({
    required this.status,
    required this.listFeelings,
    required this.currentFeeling,
  });

  factory FeelingsState.initial() {
    return FeelingsState._(
      status: FeelingsStatus.initial,
      listFeelings: [],
      currentFeeling: null,
    );
  }

  FeelingsState copyWith({
    FeelingsStatus? status,
    List<FeelingModel>? listFeelings,
    FeelingModel? currentFeeling,
  }) {
    return FeelingsState._(
      status: status ?? this.status,
      listFeelings: listFeelings ?? this.listFeelings,
      currentFeeling: currentFeeling,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listFeelings,
        currentFeeling,
      ];
}
