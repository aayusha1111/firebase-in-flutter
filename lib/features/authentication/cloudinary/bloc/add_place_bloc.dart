import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_event.dart';
import 'package:new_project/features/authentication/cloudinary/bloc/add_place_state.dart';
import 'package:new_project/features/authentication/model/addplace.dart';
import 'package:new_project/utils/cloudinary.dart';

class AddPlaceBloc extends Bloc<AddPlaceEvent, AddPlaceState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPlaceBloc() : super(AddPlaceInitialState()) {
    on<SubmitPlaceEvent>((event, emit) async {
      emit(AddPlaceLoadingState());

      try {
        final imageUrl =
            await CloudinaryService().uploadImage(event.imageFile);

        await firestore.collection('places').add({
          ...event.place.toJson(),
          'imageUrl': imageUrl['secure_url'],
          'public_id': imageUrl['public_id'],
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        emit(AddPlaceLoadedState());
      } catch (e) {
        emit(AddPlaceErrorState(e.toString()));
      }
    });
  }
}

//get places bloc

class GetPlacesBloc extends Bloc<GetPlacesEvent,GetPlacesState>{
  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  GetPlacesBloc():super(GetPlacesInitialState()) {
    on<FetchPlacesEvent>((event, emit) async {
      emit(GetPlacesLoadingState());

      try{
        final snapshot = await firestore
            .collection('places')
            .orderBy('createdAt', descending: true)
            .get();

            final places = snapshot.docs.map((doc) {
               final data = doc.data() as Map<String, dynamic>;

          return AddPlaceModel.fromJson({
         'id': doc.id,
         ...data,
    });
        }).toList();
        print(places);
       emit(GetPlacesLoadedState(places));
      } catch(e){
         emit(GetPlacesErrorState(e.toString()));
      }
      });

      on<DeletePlaceEvent>((event, emit) async{
            emit(GetPlacesLoadingState());
             try{
         await firestore
        .collection('places')
        .doc(event.id)
        .delete();

         final snapshot = await firestore
            .collection('places')
            .orderBy('createdAt', descending: true)
            .get();

            final places = snapshot.docs.map((doc) {
               final data = doc.data() as Map<String, dynamic>;

          return AddPlaceModel.fromJson({
         'id': doc.id,
         ...data,
    });
        }).toList();
      
      
       emit(GetPlacesLoadedState(places));
      } catch(e){
         emit(GetPlacesErrorState(e.toString()));
      }
        
      },);
      }
}
