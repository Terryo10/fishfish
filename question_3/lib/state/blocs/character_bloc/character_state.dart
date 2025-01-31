part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {
  final List<CharacterModel> characters;
  final bool hasReachedMax;
  final int currentPage;

  const CharactersLoaded(this.hasReachedMax, this.currentPage,
      {this.characters = const []});

  @override
  List<Object?> get props => [characters, hasReachedMax, currentPage];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}
