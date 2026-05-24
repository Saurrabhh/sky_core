import 'package:fpdart/fpdart.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:test/test.dart';

// Test Entity
class UserEntity extends Entity<String> {
  const UserEntity({
    required String id,
    required this.name,
    required this.email,
  }) : super(id);
  final String name;
  final String email;
}

// Test ValueObject
class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String input) {
    if (input.contains('@')) {
      return EmailAddress._(Either.right(input));
    }
    return EmailAddress._(
      Either.left(const ValidationFailure(message: 'Invalid email address')),
    );
  }
  const EmailAddress._(this.value);

  @override
  final Either<Failure, String> value;
}

void main() {
  group('DDD Primitives', () {
    group('Entity', () {
      test('compares equality strictly based on the unique ID', () {
        const entity1 = UserEntity(
          id: 'user_123',
          name: 'Saurabh',
          email: 'saurabh@sky.com',
        );

        // Same ID, different properties
        const entity2 = UserEntity(
          id: 'user_123',
          name: 'Saurabh Kumar',
          email: 'saurabh.k@sky.com',
        );

        // Different ID, same properties
        const entity3 = UserEntity(
          id: 'user_456',
          name: 'Saurabh',
          email: 'saurabh@sky.com',
        );

        expect(entity1, equals(entity2));
        expect(entity1, isNot(equals(entity3)));
        expect(entity1.hashCode, equals(entity2.hashCode));
        expect(entity1.name, equals('Saurabh'));
        expect(entity1.email, equals('saurabh@sky.com'));
      });
    });

    group('ValueObject', () {
      test('Right value is valid and retrieves successfully', () {
        final email = EmailAddress('test@sky.com');

        expect(email.isValid(), isTrue);
        expect(email.isInvalid(), isFalse);
        expect(email.getOrElse('fallback@sky.com'), equals('test@sky.com'));
      });

      test('Left value is invalid and uses fallback', () {
        final email = EmailAddress('invalid_email');

        expect(email.isValid(), isFalse);
        expect(email.isInvalid(), isTrue);
        expect(email.getOrElse('fallback@sky.com'), equals('fallback@sky.com'));
      });
    });
  });
}
