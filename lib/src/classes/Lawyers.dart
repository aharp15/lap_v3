class Lawyers{
  String id;
  String fName;
  String lName;
  String city;
  String address;
  String email;
  String phone;
  String firmName;
  String url;
  String category;
  double rating;

  Map<String, dynamic> toJSON ()=> {
    "id": id,
    "fName": fName,
    "lName": lName,
    "city": city,
    "address": address,
    "email": email,
    "phone": phone,
    "firmName": firmName,
    "url": url,
    "category": category,
    "rating": rating,

  };

  Lawyers({this.fName, this.lName, this.address, this.city, this.email, this.phone, this.firmName, this.url, this.category, this.rating, this.id});
}