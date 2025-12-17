import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/test_bloc/test_event.dart';
import 'package:new_project/test_bloc/test_modal.dart';
import 'package:new_project/test_bloc/test_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialState()) {
    on<IncrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count + 1,state.isVisible));
      } else {
        emit(UpdatedState(1, true));
      }
    });

    on<DecrementEvent>((event, emit) {
      if (state is UpdatedState) {
        emit(UpdatedState((state as UpdatedState).count - 1, state.isVisible));
      } else {
        emit(UpdatedState(-1, true));
      }
    });

    on<LoginEvent>((event, emit) {});

    on<ToggleVisibilityEvent>((event, emit) {
      emit(UpdatedState(state.count,!state.isVisible));
    },);


    //api event


  }
}

class ApiBloc extends Bloc<ApiEvent,ApiState>{
  ApiBloc():super(ApiInitialState()){
    on<FetchDataEvent>(_fetchPosts);
    print("Fetching Posts");

  }
}

Future<void>_fetchPosts(
  FetchDataEvent event,Emitter<ApiState> emit
) async{
  emit(ApiLoadingState());
try{
  final response=await Dio().get(
    'https://dummyjson.com/posts',
  );
    
  if(response.statusCode==200){
    final data =response.data;
    final postsJson=data['posts'] as List<dynamic>;

    final posts=postsJson.map((e) => Post.fromJson(e)).toList();
    emit(ApiLoadedState(posts));
  } else{
    emit(ApiErrorState("failed to load data"));
  }
} catch(e){
  print("Error:$e");
  emit(ApiErrorState(e.toString()));
}

 
}
