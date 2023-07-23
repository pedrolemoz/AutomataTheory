# Automata Theory

Implementations of some automatons in Dart.

### Created by Pedro Lemos ([@pedrolemoz](https://github.com/pedrolemoz)) in 22/07/2023

Current implementations:

- Deterministic Finite Automaton (DFA)
- Non-deterministic Finite Automaton (NFA)
- Non-deterministic Automaton with Epsilon transitions (eNFA)


### Deterministic Finite Automaton

```dart
// DFA over the set {a, b} that contains the substring "aabb"
void main() {
  final q0 = DeterministicState(name: 'q0', isInitial: true);
  final q1 = DeterministicState(name: 'q1');
  final q2 = DeterministicState(name: 'q2');
  final q3 = DeterministicState(name: 'q3');
  final q4 = DeterministicState(name: 'q4', isFinal: true);

  q0.setTransition((input) {
    switch (input) {
      case 'a':
        return q1;
      case 'b':
        return q0;
      default:
        throw InvalidInputException();
    }
  });

  q1.setTransition((input) {
    switch (input) {
      case 'a':
        return q2;
      case 'b':
        return q0;
      default:
        throw InvalidInputException();
    }
  });

  q2.setTransition((input) {
    switch (input) {
      case 'a':
        return q2;
      case 'b':
        return q3;
      default:
        throw InvalidInputException();
    }
  });

  q3.setTransition((input) {
    switch (input) {
      case 'a':
        return q1;
      case 'b':
        return q4;
      default:
        throw InvalidInputException();
    }
  });

  q4.setTransition((_) => q4);

  final automaton = DFA(
    states: {q0, q1, q2, q3, q4},
    alphabet: {'a', 'b'},
  );

  print(automaton.evaluate('aaabbb')); // true
  print(automaton.evaluate('abab')); // false
}
```

### Non-deterministic Finite Automaton

```dart
// NFA over the set {0, 1} that starts with the substring "10"
void main() {
  final q0 = NonDeterministicState(name: 'q0', isInitial: true);
  final q1 = NonDeterministicState(name: 'q1');
  final q2 = NonDeterministicState(name: 'q2', isFinal: true);

  q0.setTransition((input) {
    switch (input) {
      case '1':
        return {q1};
      default:
        return {};
    }
  });

  q1.setTransition((input) {
    switch (input) {
      case '0':
        return {q2};
      default:
        return {};
    }
  });

  q2.setTransition((_) => {q2});

  final automaton = NFA(
    states: {q0, q1, q2},
    alphabet: {'0', '1'},
  );

  print(automaton.evaluate('101111')); // true
  print(automaton.evaluate('110101')); // false
}
```

### Non-deterministic Automaton with Epsilon transitions

```dart
// eNFA over the set {a, b, c} that is exactly the substring "abc" or ends with the substring "cc"
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

  print(automaton.evaluate('abccc')); // true
  print(automaton.evaluate('abaaabb')); // false
}
```