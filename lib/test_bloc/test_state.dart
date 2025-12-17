import 'package:new_project/test_bloc/test_modal.dart';

abstract class CounterState {
  final int count;
  final bool isVisible;
  const CounterState(this.count,this.isVisible);
}

class InitialState extends CounterState {
  const InitialState() : super(0, true);
}

class UpdatedState extends CounterState {
  const UpdatedState(int count, bool isVisible) : super(count, isVisible);
}

//api state

abstract class ApiState{}

class ApiInitialState extends ApiState{}

class ApiLoadingState extends ApiState{}

class ApiLoadedState extends ApiState{
 final List<Post> posts;
  ApiLoadedState(this.posts);

}
class ApiErrorState extends ApiState{
  final String message;
  ApiErrorState(this.message);

}