abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ToggleVisibilityEvent extends CounterEvent{}

class LoginEvent extends CounterEvent{}

//api event
abstract class ApiEvent{}
class FetchDataEvent extends ApiEvent{}

