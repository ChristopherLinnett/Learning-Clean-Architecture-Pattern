import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:starting_project/core/errors/exceptions.dart';
import 'package:starting_project/core/utils/constants.dart';
import 'package:starting_project/src/authentication/data/models/user_model.dart';
import 'package:starting_project/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<User>> getUsers();
}

const kCreateUserEndpoint = '/users';
const kgetUsersEndpoint = '/users';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;
  const AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    /// 1. Check to make sure that it returns the right data when the status code
    /// is 200 or 201
    /// 2. Check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    /// right message when status code is bad

    try {
      final response =
          await _client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'createdAt': createdAt,
                'name': name,
                'avatar': avatar,
              }),
              headers: {'Content-Type': 'application/json'});
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      final response =
          await _client.get(Uri.https(kBaseUrl, kgetUsersEndpoint));
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body) as List)
          .map(
        (userData) {
          return UserModel.fromMap(userData);
        },
      ).toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
