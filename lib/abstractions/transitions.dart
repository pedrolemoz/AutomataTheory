import 'state.dart';

typedef DeterministicTranstitionFunction = State Function(String input);

typedef NonDeterministicTranstitionFunction = Set<State> Function(String input);
