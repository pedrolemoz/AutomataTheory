class State {
  final String name;
  final bool isInitial;
  final bool isFinal;

  const State({
    required this.name,
    this.isInitial = false,
    this.isFinal = false,
  });
}
