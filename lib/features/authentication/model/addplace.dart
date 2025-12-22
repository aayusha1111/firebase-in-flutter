class AddPlaceModel {
  String? destination;
  String? about;


  AddPlaceModel({
    this.destination,
    this.about,
  
  });

  AddPlaceModel.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    about = json['about'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['destination'] = destination;
    data['about'] = about;

    return data;
  }
}
