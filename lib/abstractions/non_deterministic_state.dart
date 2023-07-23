import 'exceptions.dart';
import 'state.dart';
import 'transitions.dart';

class NonDeterministicState extends State {
  NonDeterministicTranstitionFunction? _transition;

  NonDeterministicState({
    required super.name,
    super.isInitial,
    super.isFinal,
  });

  void setTransition(NonDeterministicTranstitionFunction transition) {
    _transition = transition;
  }

  Set<NonDeterministicState> executeTransition(String input) {
    if (_transition == null) throw InvalidTransitionException();
    return _transition!(input);
  }
}
