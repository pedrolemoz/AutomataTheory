import 'automaton.dart';
import 'state.dart';

abstract class DeterministicAutomaton extends Automaton {
  DeterministicAutomaton({required super.states, required super.alphabet});

  State extendedTransition(State state, String input);
}
