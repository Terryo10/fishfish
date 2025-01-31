import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'character_model.dart';
import 'info.dart';

part 'character_response_model.g.dart';

@JsonSerializable()
class CharacterResponseModel extends Equatable {
    final Info? info;
    final List<CharacterModel>? results;

    const CharacterResponseModel({
        this.info,
        this.results,
    });

     factory CharacterResponseModel.fromJson(Map<String, dynamic> json) => 
    _$CharacterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResponseModelToJson(this);

  @override
  List<Object?> get props => [results, info,];

}
