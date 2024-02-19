// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:my_config/my_config.dart';

void main() {
  group('MyConfig', () {
    test('can be instantiated', () {
      expect(MyConfig(), isNotNull);
    });
  });
}
