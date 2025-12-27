import 'package:new_project/features/authentication/model/addplace.dart';

abstract class AddPlaceState{}

class AddPlaceInitialState extends AddPlaceState{}
class AddPlaceLoadingState extends AddPlaceState{}
class AddPlaceLoadedState extends AddPlaceState{}

class AddPlaceErrorState extends AddPlaceState {
   final String message;
  AddPlaceErrorState(this.message);
}


//get places state

abstract class GetPlacesState{}
class GetPlacesInitialState extends GetPlacesState{}
class GetPlacesLoadingState extends GetPlacesState{}

class GetPlacesLoadedState extends GetPlacesState{
final List<AddPlaceModel> places;
  GetPlacesLoadedState(this.places);

}

class GetPlacesErrorState extends GetPlacesState {
  final String message;
  GetPlacesErrorState(this.message);
}


//delete place state

abstract class DeletePlaceState {}
class DeletePlaceInitialState extends DeletePlaceState {}
class DeletePlaceLoadingState extends DeletePlaceState {}
class DeletePlaceSuccessState extends DeletePlaceState {
  final String placeId;
  DeletePlaceSuccessState(this.placeId);
}
class DeletePlaceErrorState extends DeletePlaceState {
  final String error;
  DeletePlaceErrorState(this.error);
}

