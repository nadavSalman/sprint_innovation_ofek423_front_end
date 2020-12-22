/**
 * Unit test example :
 */
import 'package:flutter_test/flutter_test.dart';

/**
 * The test writen using the pub.dev -> test libery
 * https://pub.dev/packages/test
 */
void main() {
  group("Test  behaviors of choosing a unit", () {
    test('TTest the behavior of choosing the right unit', () {
      expect(true, true);
    });

    test('Test the behavior of choosing the not preferred unit', () {
      expect(false, false);
    });
  });
}
