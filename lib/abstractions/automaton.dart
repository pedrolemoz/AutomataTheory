import 'state.dart';

abstract class Automaton {
  final Set<State> states;
  final Set<String> alphabet;
  late final State initialState;
  late final Set<State> finalStates;

  Automaton({
    required this.states,
    required this.alphabet,
  }) {
    initialState = states.firstWhere((state) => state.isInitial);
    finalStates = states.where((state) => state.isFinal).toSet();
  }

  bool hasValidInput(String input) {
    final symbols = input.split('');
    return symbols.every(alphabet.contains);
  }

  bool evaluate(String input);
}
