import 'package:flutter_test/flutter_test.dart';
import 'package:startup_namer/logic/loginUtil.dart';


void main() {
  group("Test  function : bool checkUserPhoneInput(userPhoneFild)", () {

    test('Empty string', () {
      expect(checkUserPhoneInput(""), false);
    });

    test('Exceeded the required length (more than 10 characters).', () {
      expect(checkUserPhoneInput("05384758689334"), false);
    });

    test('Add not numbers characters .', () {
      expect(checkUserPhoneInput("053sdfssd334"), false);
    });

    test('Extreme case (1) .', () {
      expect(checkUserPhoneInput("053820293r"), false);
    });

    test('Extreme case (2) .', () {
      expect(checkUserPhoneInput("w538202931"), false);
    });



  });
}
