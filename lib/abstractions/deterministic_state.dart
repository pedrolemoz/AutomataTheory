import 'constants.dart';
import 'exceptions.dart';
import 'state.dart';

class DeterministicState extends State<DeterministicState> {
  DeterministicState({
    required super.name,
    super.isInitial,
    super.isFinal,
  });

  DeterministicState executeTransition(String input) {
    if (transitions.isEmpty) throw InvalidTransitionException();

    final hasValidTransition =
        transitions.containsKey(input) || transitions.containsKey(epsilon);

    if (!hasValidTransition) throw InvalidInputException();

    return transitions[input] ?? transitions[epsilon]!;
  }
}
