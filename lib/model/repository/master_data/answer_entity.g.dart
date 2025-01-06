// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerEntity _$AnswerEntityFromJson(Map<String, dynamic> json) => AnswerEntity(
      id: (json['id'] as num?)?.toInt(),
      questionId: (json['question_id'] as num?)?.toInt(),
      answerTextVi: json['answer_text_vi'] as String?,
      answerTextEn: json['answer_text_en'] as String?,
      gryPoint: (json['points_gryffindor'] as num?)?.toDouble(),
      ravPoint: (json['points_ravenclaw'] as num?)?.toDouble(),
      hufPoint: (json['points_hufflepuff'] as num?)?.toDouble(),
      slyPoint: (json['points_slytherin'] as num?)?.toDouble(),
      imagePath: json['image_path'] as String?,
    );

Map<String, dynamic> _$AnswerEntityToJson(AnswerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'answer_text_vi': instance.answerTextVi,
      'answer_text_en': instance.answerTextEn,
      'points_gryffindor': instance.gryPoint,
      'points_ravenclaw': instance.ravPoint,
      'points_hufflepuff': instance.hufPoint,
      'points_slytherin': instance.slyPoint,
      'image_path': instance.imagePath,
    };
