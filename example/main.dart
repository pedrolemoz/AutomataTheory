import 'dart:io';

import 'package:automata_theory/abstractions/constants.dart';
import 'package:automata_theory/abstractions/non_deterministic_state.dart';
import 'package:automata_theory/implementations/episilon_nfa.dart';

void main() {
  final q0 = NonDeterministicState(name: 'q0', isInitial: true);
  final q1 = NonDeterministicState(name: 'q1');
  final q2 = NonDeterministicState(name: 'q2');
  final q3 = NonDeterministicState(name: 'q3');
  final q4 = NonDeterministicState(name: 'q4', isFinal: true);
  final q5 = NonDeterministicState(name: 'q5');
  final q6 = NonDeterministicState(name: 'q6');
  final q7 = NonDeterministicState(name: 'q7', isFinal: true);

  q0.setTransition((input) {
    switch (input) {
      case epsilon:
        return {q1, q5};
      default:
        return {};
    }
  });

  q1.setTransition((input) {
    switch (input) {
      case 'a':
        return {q2};
      default:
        return {};
    }
  });

  q2.setTransition((input) {
    switch (input) {
      case 'b':
        return {q3};
      default:
        return {};
    }
  });

  q3.setTransition((input) {
    switch (input) {
      case 'c':
        return {q4};
      default:
        return {};
    }
  });

  q4.setTransition((input) => {});

  q5.setTransition((input) {
    switch (input) {
      case 'a':
        return {q5};
      case 'b':
        return {q5};
      case 'c':
        return {q5, q6};
      default:
        return {};
    }
  });

  q6.setTransition((input) {
    switch (input) {
      case 'c':
        return {q7};
      default:
        return {};
    }
  });

  q7.setTransition((input) => {});

  final automaton = EpsilonNFA(
    states: {q0, q1, q2, q3, q4, q5, q6, q7},
    alphabet: {'a', 'b', 'c'},
  );

  stdout
    ..writeln(automaton.evaluate('abccc')) // true
    ..writeln(automaton.evaluate('abaaabb')); // false
}
