//model
class User {
  String? gender;
  String? title;
  String? first;
  String? last;
  String? location;
  String? email;
  String? phone;
  String? picture;

  User(
      {this.gender,
      this.title,
      this.first,
      this.last,
      this.location,
      this.email,
      this.phone,
      this.picture});

  User.fromJson(Map<String, dynamic> json) {
    gender = json["gender"];
    title = json["name"]["title"];
    first = json["name"]["first"];
    last = json["name"]["last"];
    location = json["location"]["city"];
    email = json["email"];
    phone = json["phone"];
    picture = json["picture"]["large"];
  }
}
