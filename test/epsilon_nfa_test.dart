// ignore_for_file: lines_longer_than_80_chars

import 'package:automatons/abstractions/constants.dart';
import 'package:automatons/abstractions/state.dart';
import 'package:automatons/implementations/episilon_nfa.dart';
import 'package:test/test.dart';

void main() {
  final q0 = State(name: 'q0', isInitial: true);
  final q1 = State(name: 'q1');
  final q2 = State(name: 'q2');
  final q3 = State(name: 'q3');
  final q4 = State(name: 'q4', isFinal: true);
  final q5 = State(name: 'q5');
  final q6 = State(name: 'q6');
  final q7 = State(name: 'q7', isFinal: true);

  q0.transition = (input) {
    switch (input) {
      case epsilon:
        return {q1, q5};
      default:
        return <State>{};
    }
  };

  q1.transition = (input) {
    switch (input) {
      case 'a':
        return {q2};
      default:
        return <State>{};
    }
  };

  q2.transition = (input) {
    switch (input) {
      case 'b':
        return {q3};
      default:
        return <State>{};
    }
  };

  q3.transition = (input) {
    switch (input) {
      case 'c':
        return {q4};
      default:
        return <State>{};
    }
  };

  q4.transition = (input) => <State>{};

  q5.transition = (input) {
    switch (input) {
      case 'a':
        return {q5};
      case 'b':
        return {q5};
      case 'c':
        return {q5, q6};
      default:
        return <State>{};
    }
  };

  q6.transition = (input) {
    switch (input) {
      case 'c':
        return {q7};
      default:
        return <State>{};
    }
  };

  q7.transition = (input) => <State>{};

  final eNfa = EpsilonNFA(
    states: {q0, q1, q2, q3, q4, q5, q6, q7},
    alphabet: {'a', 'b', 'c'},
  );

  group(
      'eNFA over the set {a, b, c} that is exactly the substring "abc" or ends with the substring "cc"',
      () {
    test('Should accept the string "abc"', () {
      final result = eNfa.evaluate('abc');
      expect(result, true);
    });
    test('Should accept the string "cc"', () {
      final result = eNfa.evaluate('cc');
      expect(result, true);
    });
    test('Should accept the string "abccc"', () {
      final result = eNfa.evaluate('abccc');
      expect(result, true);
    });
    test('Should accept the string "aabbcc"', () {
      final result = eNfa.evaluate('aabbcc');
      expect(result, true);
    });
    test('Should accept the string "bbaacc"', () {
      final result = eNfa.evaluate('bbaacc');
      expect(result, true);
    });
    test('Should accept the string "cccccc"', () {
      final result = eNfa.evaluate('cccccc');
      expect(result, true);
    });
    test('Should accept the string "abababacc"', () {
      final result = eNfa.evaluate('abababacc');
      expect(result, true);
    });
    test('Should accept the string "cbcbcbccc"', () {
      final result = eNfa.evaluate('cbcbcbccc');
      expect(result, true);
    });
    test('Should reject the empty string', () {
      final result = eNfa.evaluate('');
      expect(result, false);
    });
    test('Should reject the string "abca"', () {
      final result = eNfa.evaluate('abca');
      expect(result, false);
    });
    test('Should reject the string "a"', () {
      final result = eNfa.evaluate('a');
      expect(result, false);
    });
    test('Should reject the string "b"', () {
      final result = eNfa.evaluate('b');
      expect(result, false);
    });
    test('Should reject the string "c"', () {
      final result = eNfa.evaluate('c');
      expect(result, false);
    });
    test('Should reject the string "aa"', () {
      final result = eNfa.evaluate('aa');
      expect(result, false);
    });
    test('Should reject the string "bb"', () {
      final result = eNfa.evaluate('bb');
      expect(result, false);
    });
    test('Should reject the string "aba"', () {
      final result = eNfa.evaluate('aba');
      expect(result, false);
    });
    test('Should reject the string "abaaabb"', () {
      final result = eNfa.evaluate('abaaabb');
      expect(result, false);
    });
    test('Should reject the string "bbabbabbabbbacca"', () {
      final result = eNfa.evaluate('bbabbabbabbbacca');
      expect(result, false);
    });
    test('Should reject the string "babacabacaba"', () {
      final result = eNfa.evaluate('babacabacaba');
      expect(result, false);
    });
  });
}
