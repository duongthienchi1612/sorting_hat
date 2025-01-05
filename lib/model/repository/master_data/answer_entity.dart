import 'package:json_annotation/json_annotation.dart';
import 'package:sorting_hat/constants.dart';
import 'package:sorting_hat/model/base/base_entity.dart';

part 'answer_entity.g.dart';

@JsonSerializable()
class AnswerEntity extends CoreReadEntity {
  @override
  String get table => Database.answerTable;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'question_id')
  final int? questionId;

  @JsonKey(name: 'answer_text_vi')
  final String? answerTextVi;

  @JsonKey(name: 'answer_text_en')
  final String? answerTextEn;

  @JsonKey(name: 'points_gryffindor')
  final double? gryPoint;

  @JsonKey(name: 'points_ravenclaw')
  final double? ravPoint;

  @JsonKey(name: 'points_hufflepuff')
  final double? hufPoint;

  @JsonKey(name: 'points_slytherin')
  final double? slyPoint;

  AnswerEntity({
    this.id,
    this.questionId,
    this.answerTextVi,
    this.answerTextEn,
    this.gryPoint,
    this.ravPoint,
    this.hufPoint,
    this.slyPoint,
  });

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    var entity = AnswerEntity.fromJson(json);
    return entity as T;
  }

  factory AnswerEntity.fromJson(Map<String, dynamic> json) {
    return _$AnswerEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AnswerEntityToJson(this);
}