import 'package:json_annotation/json_annotation.dart';
import 'package:sorting_hat/constants.dart';
import 'package:sorting_hat/model/base/base_entity.dart';

part 'question_entity.g.dart';

@JsonSerializable()
class QuestionEntity extends CoreReadEntity {
  @override
  String get table => Database.questionTable;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'question_text_vi')
  final String? questionTextVi;

  @JsonKey(name: 'question_text_en')
  final String? questionTextEn;

  @JsonKey(name: 'image_path')
  final String? imagePath;

  @JsonKey(name: 'type')
  final String? type;

  QuestionEntity({
    this.id,
    this.questionTextVi,
    this.questionTextEn,
    this.imagePath,
    this.type,
  });

  @override
  T fromJsonConvert<T extends CoreReadEntity>(Map<String, dynamic> json) {
    var entity = QuestionEntity.fromJson(json);
    return entity as T;
  }

  factory QuestionEntity.fromJson(Map<String, dynamic> json) {
    return _$QuestionEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$QuestionEntityToJson(this);
}
