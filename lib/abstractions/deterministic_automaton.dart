import 'automaton.dart';
import 'deterministic_state.dart';

abstract class DeterministicAutomaton extends Automaton<DeterministicState> {
  DeterministicAutomaton({required super.states, required super.alphabet});

  DeterministicState extendedTransition(DeterministicState state, String input);
}
