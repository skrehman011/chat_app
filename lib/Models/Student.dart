class Student {
  String id, email, password, name;
  int age;
  String? token;
  int lastSeen;

//<editor-fold desc="Data Methods">
  Student({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    this.token,
    required this.lastSeen,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          password == other.password &&
          name == other.name &&
          age == other.age &&
          token == other.token &&
          lastSeen == other.lastSeen);

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ password.hashCode ^ name.hashCode ^ age.hashCode ^ token.hashCode ^ lastSeen.hashCode;

  @override
  String toString() {
    return 'Student{' +
        ' id: $id,' +
        ' email: $email,' +
        ' password: $password,' +
        ' name: $name,' +
        ' age: $age,' +
        ' token: $token,' +
        ' lastSeen: $lastSeen,' +
        '}';
  }

  Student copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    int? age,
    String? token,
    int? lastSeen,
  }) {
    return Student(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      age: age ?? this.age,
      token: token ?? this.token,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'password': this.password,
      'name': this.name,
      'age': this.age,
      'token': this.token,
      'lastSeen': this.lastSeen,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      token: map['token'] as String? ?? "",
      lastSeen: map['lastSeen'] as int? ?? 0,
    );
  }

//</editor-fold>
}