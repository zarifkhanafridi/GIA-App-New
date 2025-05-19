class User {
  final String? firstName;
  final String? lastName;
  final int? age;
  final int? age1;

  const User({
    this.firstName,
    this.lastName,
    this.age,
    this.age1,
  });

  User copy({
    String? firstName,
    String? lastName,
    int? age,
    int? age1,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        age1: age1 ?? this.age1,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          age == other.age &&
          age1 == other.age1;

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ age.hashCode ^ age1.hashCode;
}
