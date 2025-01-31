import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:question_3/models/character_model.dart';

import '../../../repositories/character_repository/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  CharacterBloc({required this.repository}) : super(CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
    on<SelectCharacter>(_onSelectCharacter);
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      emit(CharacterLoading());
      final response = await repository.getCharacters(1);
      emit(CharactersLoaded(
       characters:  response.results ?? [],
        response.info?.next == null,
        1,
      ));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    if (state is CharactersLoaded) {
      final currentState = state as CharactersLoaded;
      if (!currentState.hasReachedMax) {
        try {
          final nextPage = currentState.currentPage + 1;
          final response = await repository.getCharacters(nextPage);
          emit(CharactersLoaded(
            characters :[...currentState.characters, ...?response.results],
            response.info?.next == null,
            nextPage,
          ));
        } catch (e) {
          emit(CharacterError(e.toString()));
        }
      }
    }
  }

  Future<void> _onSelectCharacter(
    SelectCharacter event,
    Emitter<CharacterState> emit,
  ) async {
    //TODO: lol
  }
}
