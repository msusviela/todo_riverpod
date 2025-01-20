import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/home/home.dart';

import 'utils/utils.dart';

void main() {
  group('homeStateProvider Tests', () {
    test('Must initialize in 0', () {
      final container = createContainer();
      expect(container.read(homeStateProvider),
          equals(const HomeState(tabIndex: 0)));
    });

    test('Must update state correctly', () {
      final container = createContainer();
      final notifier = container.read(homeStateProvider.notifier);
      const newState = HomeState(tabIndex: 2);

      notifier.state = newState;
      expect(container.read(homeStateProvider),
          equals(const HomeState(tabIndex: 2)));
    });
  });
}
