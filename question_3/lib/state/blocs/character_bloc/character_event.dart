part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharacterEvent {}

class LoadMoreCharacters extends CharacterEvent {}

class SelectCharacter extends CharacterEvent {
  final int characterId;

  const SelectCharacter(this.characterId);

  @override
  List<Object> get props => [characterId];
}
