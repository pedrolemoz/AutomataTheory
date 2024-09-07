import 'states.dart';

abstract class Automaton<StateType extends State> {
  final Set<StateType> states;
  final Set<String> alphabet;
  late final StateType initialState;
  late final Set<StateType> finalStates;

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
