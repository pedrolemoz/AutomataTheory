abstract class State<T> {
  final String name;
  bool isInitial;
  bool isFinal;

  State({
    required this.name,
    this.isInitial = false,
    this.isFinal = false,
  });

  final Map<String, T> _transitions = {};

  Map<String, T> get transitions => _transitions;

  void setTransition(MapEntry<String, T> transition) =>
      _transitions.putIfAbsent(transition.key, () => transition.value);

  void setTransitions(List<MapEntry<String, T>> transitions) =>
      _transitions.addEntries(transitions);
}
