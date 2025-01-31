class AppState {
  final int count;

  const AppState({required this.count});

  factory AppState.initial() => const AppState(count: 0);

  AppState copyWith({int? count}) {
    return AppState(count: count ?? this.count);
  }
}