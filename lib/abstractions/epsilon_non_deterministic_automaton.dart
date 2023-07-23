import 'non_deterministic_automaton.dart';
import 'non_deterministic_state.dart';

abstract class EpsilonNonDeterministicAutomaton
    extends NonDeterministicAutomaton {
  EpsilonNonDeterministicAutomaton({
    required super.states,
    required super.alphabet,
  });

  Set<NonDeterministicState> epsilonClosure(NonDeterministicState state);
}
