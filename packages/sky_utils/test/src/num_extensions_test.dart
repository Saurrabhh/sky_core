import 'package:flutter_test/flutter_test.dart';
import 'package:sky_utils/sky_utils.dart';

void main() {
  group('SkyUtilsNumExtension toAmountFormat', () {
    group('Basic values (No grouping, no currency)', () {
      test('Formats positive and negative integers', () {
        expect(10.toAmountFormat(), '10');
        expect(0.toAmountFormat(), '0');
        expect((-5).toAmountFormat(), '-5');
      });

      test('Formats double representing integer as integer string', () {
        expect(10.0.toAmountFormat(), '10');
        expect((-10.0).toAmountFormat(), '-10');
      });

      test('Formats decimals to exactly two decimal places', () {
        expect(10.5.toAmountFormat(), '10.50');
        expect(10.256.toAmountFormat(), '10.26');
        expect((-10.256).toAmountFormat(), '-10.26');
      });
    });

    group('Millions (Western grouping)', () {
      test('Groups thousands correctly', () {
        expect(1000.toAmountFormat(), '1,000');
        expect(12345.toAmountFormat(), '12,345');
        expect(1234567.toAmountFormat(), '1,234,567');
        expect((-1234567).toAmountFormat(), '-1,234,567');
      });

      test('Groups thousands with decimals correctly', () {
        expect(1234.56.toAmountFormat(), '1,234.56');
        expect(1234567.89.toAmountFormat(), '1,234,567.89');
        expect((-1234567.89).toAmountFormat(), '-1,234,567.89');
      });
    });

    group('Lakhs (Indian grouping)', () {
      test('Groups thousands, lakhs, and crores correctly', () {
        expect(
          1000.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '1,000',
        );
        expect(
          12345.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '12,345',
        );
        expect(
          1234567.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '12,34,567',
        );
        expect(
          12345678.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '1,23,45,678',
        );
        expect(
          (-12345678).toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '-1,23,45,678',
        );
      });

      test('Groups lakhs/crores with decimals correctly', () {
        expect(
          1234567.89.toAmountFormat(groupingSystem: DigitGroupingSystem.lakhs),
          '12,34,567.89',
        );
        expect(
          (-12345678.9).toAmountFormat(
            groupingSystem: DigitGroupingSystem.lakhs,
          ),
          '-1,23,45,678.90',
        );
      });
    });

    group('Currency Placement & Spacing', () {
      test('Default placement (Prefix, no space)', () {
        expect(10.toAmountFormat(currencySymbol: r'$'), r'$10');
        expect(12345.6.toAmountFormat(currencySymbol: '₹'), '₹12,345.60');
        expect((-10.5).toAmountFormat(currencySymbol: '₹'), '-₹10.50');
      });

      test('Prefix with space', () {
        expect(
          12345.6.toAmountFormat(currencySymbol: 'USD', spaceBetween: true),
          'USD 12,345.60',
        );
        expect(
          (-10.5).toAmountFormat(currencySymbol: 'USD', spaceBetween: true),
          '-USD 10.50',
        );
      });

      test('Suffix placement', () {
        expect(
          10.toAmountFormat(currencySymbol: '元', symbolOnRight: true),
          '10元',
        );
        expect(
          12345.6.toAmountFormat(
            currencySymbol: 'USD',
            symbolOnRight: true,
            spaceBetween: true,
          ),
          '12,345.60 USD',
        );
        expect(
          (-10.5).toAmountFormat(
            currencySymbol: 'USD',
            symbolOnRight: true,
            spaceBetween: true,
          ),
          '-10.50 USD',
        );
      });
    });

    group('AppCurrencySymbols Tests', () {
      test('Unicode constants match their respective symbols', () {
        expect(AppCurrencySymbols.rupee, '₹');
        expect(AppCurrencySymbols.dollar, r'$');
        expect(AppCurrencySymbols.euro, '€');
        expect(AppCurrencySymbols.pound, '£');
        expect(AppCurrencySymbols.yen, '¥');
      });

      test('Format amounts using AppCurrencySymbols constants', () {
        expect(
          12345.6.toAmountFormat(
            currencySymbol: AppCurrencySymbols.rupee,
            groupingSystem: DigitGroupingSystem.lakhs,
          ),
          '₹12,345.60',
        );
        expect(
          1234567.89.toAmountFormat(
            currencySymbol: AppCurrencySymbols.dollar,
            spaceBetween: true,
          ),
          r'$ 1,234,567.89',
        );
      });
    });
  });
}
