import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:starting_project/src/authentication/data/models/user_model.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testModel = UserModel.empty();
  final testJson = fixture('user.json');
  final testMap = jsonDecode(testJson) as Map<String, dynamic>;
  test('should be a subclass of [User] entity', () {
    // Act
    // Assert
    expect(testModel, isA<User>());
  });
  group('fromMap', () {
    test('should return a user model with correct data from given map', () {
      // Arrange
      // Act
      final result = UserModel.fromMap(testMap);
      expect(result, equals(testModel));
      // Assert
    });
  });
  group('fromJson', () {
    test('should return a user model with correct data from given JSON', () {
      // Arrange
      // Act
      final result = UserModel.fromJson(testJson);
      expect(result, equals(testModel));
      // Assert
    });
  });
  group('toMap', () {
    test(
        'should return a [Map<String,dynamic>] with the correct data from a [UserModel]',
        () {
      // Arrange
      // Act
      final result = const UserModel.empty().toMap();
      expect(result, equals(testMap));
      // Assert
    });
  });
  group('testJson', () {
    test('should return a JSON string with the correct data from a [UserModel]',
        () {
      // Arrange
      // Act
      final result = const UserModel.empty().toJson();
      expect(result, equals(testJson));
      // Assert
    });
  });
  group('copyWith', () {
    test('should return a [UserModel] with 1 newly updated property', () {
      // Arrange

      // Act
      final result = testModel.copyWith(name: 'Paul');
      // Assert
      expect(result.name, equals('Paul'));
      expect(result.avatar, equals('_empty.string'));
    });
  });
}
