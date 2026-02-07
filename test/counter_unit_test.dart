// test/counter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo_and_code/counter.dart';

void main() {
  /// Writing tests ungrouped
  test('Counter value should start at 0', () {
    final counter = Counter();
    expect(counter.value, 0); // initial value should be 0
  });

  test('Counter value should be incremented', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1); // after one increment, value should be 1
  });

  test('Counter value should be decremented', () {
    final counter = Counter();
    counter.decrement();
    expect(counter.value, -1); // after one decrement, value should be -1
  });

  /// Writing tests grouped for better organization
  group('Counter', () {
    // This group contains multiple related tests for Counter.

    test('starts at 0', () {
      expect(Counter().value, 0);
    });

    test('increments value', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });

    test('decrements value', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });

    /// this one will fail: 
    test('decrementing twice should give 0', () {
      final counter = Counter();
      counter.decrement();
      counter.decrement();
      expect(counter.value, 0); // This will fail because the value is not updated correctly
    });
  });
}
