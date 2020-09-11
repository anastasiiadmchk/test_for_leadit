class User{
  int id;
  String name;
  String username;
  String email;
  String phone;

  User(this.id, this.email, this.name, this.phone, this.username);

  User.fromJson(Map<String, dynamic> json) :
  id = json['id'],
  name = json['name'],
  username = json['username'],
  email = json['email'];

  Map<String, dynamic> toJson() =>
    {
      'id' : id,
      'username ' : username,
      'name' : name,
      'email' : email,
    };

}