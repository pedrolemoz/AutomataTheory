import '../abstractions/non_deterministic_automaton.dart';
import '../abstractions/state.dart';

class NFA extends NonDeterministicAutomaton {
  NFA({required super.states, required super.alphabet});

  @override
  bool evaluate(String input) {
    if (!hasValidInput(input)) return false;
    final states = extendedTransition(initialState, input);
    return states.any(finalStates.contains);
  }

  @override
  Set<State> extendedTransition(State state, String input) {
    if (input.isEmpty) return {state};
    final possibleNextStates = state.transition(input[0]) as Set<State>;
    if (possibleNextStates.isEmpty) return {};
    return possibleNextStates
        .map((nextState) => extendedTransition(nextState, input.substring(1)))
        .reduce((a, b) => {...a, ...b});
  }
}
