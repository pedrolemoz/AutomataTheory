import 'states.dart';

sealed class Automaton<StateType extends State> {
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

  List<List<int>> get adjacencyMatrix {
    final matrix = <List<int>>[];

    for (var idxA = 0; idxA < states.length; idxA++) {
      final row = <int>[];

      final stateA = states.elementAt(idxA);
      final transitions = switch (this) {
        DeterministicAutomaton() => stateA.transitions.values,
        NonDeterministicAutomaton() =>
          stateA.transitions.values.expand((values) => values),
      };

      for (var idxB = 0; idxB < states.length; idxB++) {
        final stateB = states.elementAt(idxB);
        final quantity = transitions.where((state) => state == stateB).length;

        row.add(quantity);
      }

      matrix.add(row);
    }

    return matrix;
  }
}

abstract class DeterministicAutomaton extends Automaton<DeterministicState> {
  DeterministicAutomaton({required super.states, required super.alphabet});

  DeterministicState extendedTransition(DeterministicState state, String input);
}

abstract class NonDeterministicAutomaton
    extends Automaton<NonDeterministicState> {
  NonDeterministicAutomaton({required super.states, required super.alphabet});

  Set<NonDeterministicState> extendedTransition(
    NonDeterministicState state,
    String input,
  );
}

abstract class EpsilonNonDeterministicAutomaton
    extends NonDeterministicAutomaton {
  EpsilonNonDeterministicAutomaton({
    required super.states,
    required super.alphabet,
  });

  Set<NonDeterministicState> epsilonClosure(NonDeterministicState state);
}
