import 'exceptions.dart';
import 'state.dart';
import 'transitions.dart';

class NonDeterministicState extends State {
  final _transitions = <NonDeterministicTranstitionFunction>[];

  NonDeterministicState({
    required super.name,
    super.isInitial,
    super.isFinal,
  });

  void setTransition(NonDeterministicTranstitionFunction transition) =>
      _transitions.add(transition);

  void setTransitions(List<NonDeterministicTranstitionFunction> transitions) =>
      _transitions.addAll(transitions);

  Set<NonDeterministicState> executeTransition(String input) {
    if (_transitions.isEmpty) throw InvalidTransitionException();
    return _transitions
        .map((transition) => transition(input))
        .firstWhere((result) => result.isNotEmpty, orElse: () => {});
  }
}
