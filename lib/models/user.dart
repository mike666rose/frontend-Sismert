class User {
  String? name;
  String? image;
  String? us_login;
  String? us_contrasenia;

  User({
    this.name,
    this.image,
    this.us_login,
    this.us_contrasenia,
  });


  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      us_login: json['us_login'],
       us_contrasenia: json['us_contrasenia'],
    );
  }
}