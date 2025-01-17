import 'package:test/test.dart';
import 'package:todo_app/core/providers/providers.dart';

import 'utils/utils.dart';

void main() {
  group('tabIndexProvider Tests', () {
    test('Must initialize in 0', () {
      final container = createContainer();
      expect(container.read(tabIndexProvider), equals(0));
    });

    test('Must update state correctly', () {
      final container = createContainer();
      final notifier = container.read(tabIndexProvider.notifier);

      notifier.state = 2;
      expect(container.read(tabIndexProvider), equals(2));
    });
  });
}
