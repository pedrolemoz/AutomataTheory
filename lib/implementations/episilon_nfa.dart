import '../abstractions/constants.dart';
import '../abstractions/epsilon_non_deterministic_automaton.dart';
import '../abstractions/state.dart';

class EpsilonNFA extends EpsilonNonDeterministicAutomaton {
  EpsilonNFA({required super.states, required super.alphabet});

  @override
  bool evaluate(String input) {
    if (!hasValidInput(input)) return false;
    final eClosure = epsilonClosure(initialState);
    final states = eClosure
        .map((closureState) => extendedTransition(closureState, input))
        .reduce((a, b) => {...a, ...b});
    return states.any(finalStates.contains);
  }

  @override
  Set<State> extendedTransition(State state, String input) {
    if (input.isEmpty) return {state};
    final possibleNextStates = state.transition(input[0]) as Set<State>;
    if (possibleNextStates.isEmpty) return {};
    return possibleNextStates
        .map(
          (nextState) => epsilonClosure(nextState)
              .map(
                (closureState) => extendedTransition(
                  closureState,
                  input.substring(1),
                ),
              )
              .reduce((a, b) => {...a, ...b}),
        )
        .reduce((a, b) => {...a, ...b});
  }

  @override
  Set<State> epsilonClosure(State state) {
    final Set<State> possibleNextStates = state.transition(epsilon);
    if (possibleNextStates.isEmpty) return {state};
    return {
      state,
      ...possibleNextStates.map(epsilonClosure).reduce((a, b) => {...a, ...b})
    };
  }
}
