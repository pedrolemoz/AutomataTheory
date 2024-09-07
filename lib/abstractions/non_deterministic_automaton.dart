import 'automaton.dart';
import 'states.dart';

abstract class NonDeterministicAutomaton
    extends Automaton<NonDeterministicState> {
  NonDeterministicAutomaton({required super.states, required super.alphabet});

  Set<NonDeterministicState> extendedTransition(
    NonDeterministicState state,
    String input,
  );
}
