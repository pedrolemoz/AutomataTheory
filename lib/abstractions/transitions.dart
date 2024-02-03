import 'deterministic_state.dart';
import 'non_deterministic_state.dart';

typedef DeterministicTranstitionFunction = DeterministicState Function(
  String input,
);

typedef NonDeterministicTranstitionFunction = Set<NonDeterministicState>
    Function(String input);
