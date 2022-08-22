class UserModel{
  String name,email,id;

  UserModel(
      { required this.name,
       required this.email,
       required this.id,
      });

  toMap(){
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
    };
  }
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }
}