import 'package:flutter_test/flutter_test.dart';
import 'package:sky_utils/sky_utils.dart';

void main() {
  group('SkyUtilsNumExtension Initial tests', () {
    test('Formats simple integers correctly without decimals', () {
      expect(10.toAmountFormat(), '10');
      expect(0.toAmountFormat(), '0');
    });

    test('Formats doubles with decimals to exactly 2 places', () {
      expect(10.5.toAmountFormat(), '10.50');
      expect(10.256.toAmountFormat(), '10.26');
    });
  });
}
