class User {
  String? name;
  String? address;
  String? email;
  String? password;
  Identity? identity;
  String? profileUrl;

  User(
      {this.name,
      this.address,
      this.email,
      this.password,
      this.identity,
      this.profileUrl});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    identity = json['identity'] != null
        ?  Identity.fromJson(json['identity'])
        : null;
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.identity != null) {
      data['identity'] = this.identity!.toJson();
    }
    data['profile_url'] = this.profileUrl;
    return data;
  }
}

class Identity {
  String? type;
  String? url;

  Identity({this.type, this.url});

  Identity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}