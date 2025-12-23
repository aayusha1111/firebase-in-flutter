import 'dart:io';
import 'package:new_project/features/authentication/model/addplace.dart';


abstract class AddPlaceEvent {}

class SubmitPlaceEvent extends AddPlaceEvent {
  final AddPlaceModel place;
  final File imageFile;

 SubmitPlaceEvent({
    required this.place,
    required this.imageFile,
  });
}


//get places event
abstract class GetPlacesEvent{}
class FetchPlacesEvent extends GetPlacesEvent{}


class DeletePlaceEvent extends GetPlacesEvent{
  String? id;
  DeletePlaceEvent({this.id});
}




