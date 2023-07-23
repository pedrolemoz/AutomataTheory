typedef DeterministicTranstitionFunction = State Function(String input);

typedef NonDeterministicTranstitionFunction = Set<State> Function(String input);

class State {
  final String name;
  final bool isInitial;
  final bool isFinal;
  late dynamic transition;

  State({
    required this.name,
    this.isInitial = false,
    this.isFinal = false,
  });
}
