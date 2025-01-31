// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResponseModel _$CharacterResponseModelFromJson(
        Map<String, dynamic> json) =>
    CharacterResponseModel(
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterResponseModelToJson(
        CharacterResponseModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };
