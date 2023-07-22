import '../abstractions/constants.dart';
import '../abstractions/epsilon_non_deterministic_automaton.dart';

class EpsilonNFA extends EpsilonNonDeterministicAutomaton {
  const EpsilonNFA({
    required super.states,
    required super.alphabet,
    required super.transitions,
    required super.initialState,
    required super.finalStates,
  });

  @override
  bool evaluate(String input) {
    if (!hasValidInput(input)) return false;
    final eClosure = epsilonClosure(initialState);
    final states = eClosure
        .map((cState) => extendedTransition(cState, input))
        .reduce((a, b) => a += b);
    return states.any(finalStates.contains);
  }

  @override
  List<String> extendedTransition(String state, String input) {
    if (input.isEmpty) return [state];
    final possibleNextStates = transitions[state]![input[0]];
    if (possibleNextStates == null) return [];
    return possibleNextStates
        .map(
          (nextState) => epsilonClosure(nextState)
              .map((cState) => extendedTransition(cState, input.substring(1)))
              .reduce((a, b) => a += b),
        )
        .reduce((a, b) => a += b);
  }

  @override
  List<String> epsilonClosure(String state) {
    if (!transitions[state]!.containsKey(epsilon)) return [state];
    final possibleNextStates = transitions[state]![epsilon]!;
    return [state] +
        possibleNextStates.map(epsilonClosure).reduce((a, b) => a += b);
  }
}
