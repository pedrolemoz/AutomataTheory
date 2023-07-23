import 'exceptions.dart';
import 'state.dart';
import 'transitions.dart';

class DeterministicState extends State {
  DeterministicTranstitionFunction? _transition;

  DeterministicState({
    required super.name,
    super.isInitial,
    super.isFinal,
  });

  void setTransition(DeterministicTranstitionFunction transition) {
    _transition = transition;
  }

  DeterministicState executeTransition(String input) {
    if (_transition == null) throw InvalidTransitionException();
    return _transition!(input);
  }
}
