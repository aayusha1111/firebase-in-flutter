import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_event.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_state.dart';
import 'package:new_project/features/authentication/model/addplace.dart';
import 'package:new_project/utils/cloudinary.dart';

class AddPlaceBloc extends Bloc<AddPlaceEvent, AddPlaceState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPlaceBloc() : super(AddPlaceInitialState()) {

    // ================= ADD PLACE =================
    on<SubmitPlaceEvent>((event, emit) async {
      emit(AddPlaceLoadingState());

      try {
        final imageData =
            await CloudinaryService().uploadImage(event.imageFile);

        // ✅ CHANGE: create doc ref first
        final docRef = firestore.collection('places').doc();

        await docRef.set({
          'destination': event.place.destination,
          'about': event.place.about,
          'imageUrl': imageData['secure_url'],
          'public_id': imageData['public_id'],
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(AddPlaceLoadedState());
      } catch (e) {
        emit(AddPlaceErrorState(e.toString()));
      }
    });

    // ================= UPDATE PLACE =================
    on<UpdatePlaceEvent>((event, emit) async {
      emit(AddPlaceLoadingState());

      try {
        String? imageUrl;
        String? publicId;

        if (event.imageFile != null) {
          final imageData =
              await CloudinaryService().uploadImage(event.imageFile!);
          imageUrl = imageData['secure_url'];
          publicId = imageData['public_id'];
        }

        await firestore.collection('places').doc(event.place.id).update({
          'destination': event.place.destination,
          'about': event.place.about, // ✅ fixed key
          if (imageUrl != null) 'imageUrl': imageUrl, // ✅ fixed key
          if (publicId != null) 'public_id': publicId,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        emit(AddPlaceLoadedState());
      } catch (e) {
        emit(AddPlaceErrorState(e.toString()));
      }
    });
  }
}




class GetPlacesBloc extends Bloc<GetPlacesEvent, GetPlacesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetPlacesBloc() : super(GetPlacesInitialState()) {

    on<FetchPlacesEvent>((event, emit) async {
      emit(GetPlacesLoadingState());

      try {
        final snapshot = await firestore
            .collection('places')
            .orderBy('createdAt', descending: true)
            .get();

        final places = snapshot.docs.map((doc) {
          return AddPlaceModel.fromJson({
            'id': doc.id, // ✅ Firestore doc ID
            ...doc.data(),
          });
        }).toList();

        emit(GetPlacesLoadedState(places));
      } catch (e) {
        emit(GetPlacesErrorState(e.toString()));
      }
    });

    on<DeletePlaceEvent>((event, emit) async {
      emit(GetPlacesLoadingState());

      try {
        await firestore.collection('places').doc(event.id).delete();
        add(FetchPlacesEvent()); // ✅ reload after delete
      } catch (e) {
        emit(GetPlacesErrorState(e.toString()));
      }
    });
  }
}
