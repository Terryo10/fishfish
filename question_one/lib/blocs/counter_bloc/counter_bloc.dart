import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';
part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<IncrementEvent>(_onIncrement);
    on<DecrementEvent>(_onDecrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(state.count + 1));
  }

  void _onDecrement(DecrementEvent event, Emitter<CounterState> emit) {
    if (state.count > 0) {
      emit(CounterState(state.count - 1));
    }
  }
}
