import 'dart:io';
import 'package:new_project/features/authentication/model/addplace.dart';

/// ================= ADD / UPDATE EVENTS =================

abstract class AddPlaceEvent {}

class SubmitPlaceEvent extends AddPlaceEvent {
  final AddPlaceModel place;
  final File imageFile;

  SubmitPlaceEvent({
    required this.place,
    required this.imageFile,
  });
}

class UpdatePlaceEvent extends AddPlaceEvent {
  final AddPlaceModel place;
  final File? imageFile;

  UpdatePlaceEvent({
    required this.place,
    required this.imageFile,
  });
}

/// ================= GET / DELETE EVENTS =================
/// ✅ CHANGE: separate, clean event hierarchy

abstract class GetPlacesEvent {}

class FetchPlacesEvent extends GetPlacesEvent {}

class DeletePlaceEvent extends GetPlacesEvent {
  // ✅ CHANGE: id is required and non-null
  final String id;

  DeletePlaceEvent({required this.id});
}
