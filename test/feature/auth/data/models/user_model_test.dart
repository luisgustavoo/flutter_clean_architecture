import 'dart:convert';

import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const userModel = UserModel(
    id: 1,
    name: 'John Doe',
    email: 'johndoe@domain.com',
  );

  test('Should be a subclass of User', () async {
    expect(userModel, isA<UserModel>());
  });

  group('fromJson toJson', () {
    late Map<String, dynamic> jsonMap;

    setUp(() {
      jsonMap = jsonDecode(FixtureReader.getJsonData('user.json'))
          as Map<String, dynamic>;
    });

    test('should return a valid model ', () async {
      final result = UserModel.fromMap(jsonMap);

      expect(result, userModel);
    });

    test('should return a valid Json', () async {
      final result = userModel.toMap();

      expect(result, jsonMap);
    });
  });
}
