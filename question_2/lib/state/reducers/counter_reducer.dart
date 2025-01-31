import '../actions/counter_action.dart';
import '../app_state.dart';

AppState counterReducer(AppState state, dynamic action) {
  switch (action) {
    case CounterAction.increment:
      return state.copyWith(count: state.count + 1);
    case CounterAction.decrement:
      if (state.count > 0) {
        return state.copyWith(count: state.count - 1);
      }
      return state;
    default:
      return state;
  }
}