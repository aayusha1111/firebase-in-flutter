import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/test_bloc/test_event.dart';
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
  }
}
