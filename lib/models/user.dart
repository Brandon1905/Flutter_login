final String tableUser = 'user';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, gmail, name, pass
  ];

  static final String id = '_id';
  static final String gmail = 'gmail';
  static final String name = 'name';
  static final String pass = 'pass';
}

class User {
  final int id;
  final String gmail;
  final String name;
  final String pass;

  const User({
    this.id,
     this.gmail,
     this.name,
     this.pass,
  });

  User copy({
    int id,
    String gmail,
    String name,
    String pass,
  }) =>
      User(
        id: id ?? this.id,
        gmail: gmail ?? this.gmail,
        name: name ?? this.name,
        pass: pass ?? this.pass,
      );

  static User fromJson(Map<String, Object> json) => User(
        id: json[UserFields.id] as int,
        gmail: json[UserFields.gmail] as String,
        name: json[UserFields.name] as String,
        pass: json[UserFields.pass] as String
        );
      

  Map<String, Object> toJson() => {
        UserFields.id: id,
        UserFields.gmail: gmail,
        UserFields.name: name,
        UserFields.pass: pass,
      };
}
