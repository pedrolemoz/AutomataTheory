import 'automaton.dart';
import 'state.dart';

abstract class NonDeterministicAutomaton extends Automaton {
  NonDeterministicAutomaton({required super.states, required super.alphabet});

  Set<State> extendedTransition(State state, String input);
}
