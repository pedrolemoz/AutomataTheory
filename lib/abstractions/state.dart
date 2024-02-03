abstract class State {
  final String name;
  bool isInitial;
  bool isFinal;

  State({
    required this.name,
    this.isInitial = false,
    this.isFinal = false,
  });
}
