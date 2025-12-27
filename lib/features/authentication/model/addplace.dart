class AddPlaceModel {
  final String destination;
  final String about;
  final String? imageUrl; // ✅ CHANGE: consistent naming
  final String? id; // ✅ Firestore doc id (NOT stored)

  AddPlaceModel({
    required this.destination,
    required this.about,
    this.imageUrl,
    this.id,
  });

  factory AddPlaceModel.fromJson(Map<String, dynamic> json) {
    return AddPlaceModel(
      destination: json['destination'],
      about: json['about'],
      imageUrl: json['imageUrl'], // ✅ consistent key
      id: json['id'], // ✅ comes from doc.id
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'about': about,
      'imageUrl': imageUrl,
      // ❌ id REMOVED on purpose
    };
  }
}
