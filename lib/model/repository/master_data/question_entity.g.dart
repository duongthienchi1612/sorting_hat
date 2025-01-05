// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionEntity _$QuestionEntityFromJson(Map<String, dynamic> json) =>
    QuestionEntity(
      id: (json['id'] as num?)?.toInt(),
      questionTextVi: json['question_text_vi'] as String?,
      questionTextEn: json['question_text_en'] as String?,
      imagePath: json['image_path'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$QuestionEntityToJson(QuestionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_text_vi': instance.questionTextVi,
      'question_text_en': instance.questionTextEn,
      'image_path': instance.imagePath,
      'type': instance.type,
    };
