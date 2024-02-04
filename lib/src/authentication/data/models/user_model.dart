// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:starting_project/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.avatar,
    required super.name,
    required super.createdAt,
  });

  const UserModel.empty()
      : this(
            id: '1',
            name: '_empty.string',
            createdAt: '_empty.string',
            avatar: '_empty.string');

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'avatar': avatar,
      'name': name,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      avatar: map['avatar'] as String,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, createdAt: $createdAt, name: $name, avatar: $avatar)';
  }
}
