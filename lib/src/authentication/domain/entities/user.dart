// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
            id: '1',
            createdAt: '_empty.string',
            name: '_empty.string',
            avatar: '_empty.string');

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ name.hashCode ^ avatar.hashCode;
  }

}
