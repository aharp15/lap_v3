class Users{

  String id;
  String fName;
  String lName;
  String email;
  String password;
  String gender;

  Map<String, dynamic> toJSON ()=> {
    "id": id,
    "fName": fName,
    "lName": lName,
    "email": email,
    "password": password,
    "gender": gender

  };

  Users({this.id, this.fName, this.lName, this.email, this.password, this.gender});
}

