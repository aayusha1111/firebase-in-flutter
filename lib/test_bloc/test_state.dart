abstract class CounterState {
  final int count;
  final bool isVisible;
  const CounterState(this.count, this.isVisible);
}

class InitialState extends CounterState {
  const InitialState() : super(0, true);
}

class UpdatedState extends CounterState {
  const UpdatedState(int count, bool isVisible) : super(count, isVisible);
}
