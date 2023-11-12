class RainState {
  final String? data;
  final String? errorMessage;

  const RainState({
    this.data,
    this.errorMessage,
  });

  RainState copyWith({
    String? data,
    String? errorMessage,
  }) {
    return RainState(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props => [
        data,
        errorMessage,
      ];
}
