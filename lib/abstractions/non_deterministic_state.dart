import 'constants.dart';
import 'state.dart';

class NonDeterministicState extends State<Set<NonDeterministicState>> {
  NonDeterministicState({
    required super.name,
    super.isInitial,
    super.isFinal,
  });

  Set<NonDeterministicState> executeTransition(String input) =>
      transitions[input] ?? transitions[epsilon] ?? {};
}
