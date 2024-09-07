import '../abstractions/constants.dart';
import '../abstractions/epsilon_non_deterministic_automaton.dart';
import '../abstractions/states.dart';

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
  Set<NonDeterministicState> extendedTransition(
    NonDeterministicState state,
    String input,
  ) {
    if (input.isEmpty) return {state};
    final possibleNextStates = state.executeTransition(input[0]);
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
  Set<NonDeterministicState> epsilonClosure(NonDeterministicState state) {
    final possibleNextStates = state.executeTransition(epsilon);
    if (possibleNextStates.isEmpty) return {state};
    return {
      state,
      ...possibleNextStates.map(epsilonClosure).reduce((a, b) => {...a, ...b}),
    };
  }
}
