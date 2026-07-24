import 'package:flutter_test/flutter_test.dart';
import 'package:sky_storage_isar/sky_storage_isar.dart';

class _TestCacheable with IsarCacheable {}

void main() {
  group('IsarCacheable', () {
    test('isExpired returns true when lastSyncedAt is null', () {
      final item = _TestCacheable();
      expect(item.isExpired(const Duration(minutes: 5)), isTrue);
    });

    test('isExpired returns false when lastSyncedAt is within TTL', () {
      final item = _TestCacheable()..lastSyncedAt = DateTime.now();
      expect(item.isExpired(const Duration(minutes: 5)), isFalse);
    });

    test('isExpired returns true when lastSyncedAt exceeds TTL', () {
      final item = _TestCacheable()
        ..lastSyncedAt = DateTime.now().subtract(const Duration(minutes: 10));
      expect(item.isExpired(const Duration(minutes: 5)), isTrue);
    });
  });
}
