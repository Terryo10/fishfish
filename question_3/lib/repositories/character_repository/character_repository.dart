import 'package:question_3/models/character_model.dart';

import '../../models/character_response_model.dart';
import 'character_provider.dart';

class CharacterRepository {
  final CharacterProvider provider;

  CharacterRepository({required this.provider});

  Future<CharacterResponseModel> getCharacters(int page) async {
    return CharacterResponseModel.fromJson(await provider.getCharacters(page));
  }

  Future<CharacterModel> getCharacter(int id) async {
    return CharacterModel.fromJson(await provider.getCharacter(id));
  }
}
