import 'package:json_annotation/json_annotation.dart';
import '../../../constants.dart';
import '../../base/base_entity.dart';

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

  @JsonKey(name: 'image_path')
  final String? imagePath;

  AnswerEntity({
    this.id,
    this.questionId,
    this.answerTextVi,
    this.answerTextEn,
    this.gryPoint,
    this.ravPoint,
    this.hufPoint,
    this.slyPoint,
    this.imagePath,
  });

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    final entity = AnswerEntity.fromJson(json);
    return entity as T;
  }

  factory AnswerEntity.fromJson(Map<String, dynamic> json) {
    return _$AnswerEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$AnswerEntityToJson(this);
}
