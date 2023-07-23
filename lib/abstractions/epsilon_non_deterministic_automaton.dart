import 'non_deterministic_automaton.dart';
import 'state.dart';

abstract class EpsilonNonDeterministicAutomaton
    extends NonDeterministicAutomaton {
  EpsilonNonDeterministicAutomaton({
    required super.states,
    required super.alphabet,
  });

  Set<State> epsilonClosure(State state);
}
