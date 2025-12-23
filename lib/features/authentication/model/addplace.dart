class AddPlaceModel {
  final String destination;
  final String about;
 final String? url;
 final String? id;


  AddPlaceModel({
   required this.destination,
    required this.about,
    this.url,
    this.id
  
  });

  factory AddPlaceModel.fromJson(Map<String, dynamic> json) {
    return AddPlaceModel(
    destination : json['destination'],
    about : json['about'],
    url: json['imageUrl'],
    id:json['id']
    );

  }

  Map<String, dynamic> toJson() {
    return{
    'destination': destination,
    'about':about,
    'imageUrl':url,
  };
    
  }
}
