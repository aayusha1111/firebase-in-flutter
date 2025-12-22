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