import 'automaton.dart';
import 'non_deterministic_state.dart';

abstract class NonDeterministicAutomaton
    extends Automaton<NonDeterministicState> {
  NonDeterministicAutomaton({required super.states, required super.alphabet});

  Set<NonDeterministicState> extendedTransition(
    NonDeterministicState state,
    String input,
  );
}
