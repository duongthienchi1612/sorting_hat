import 'package:sorting_hat/model/repository/master_data/question_entity.dart';
import 'package:sorting_hat/repository/base/base_repository.dart';
import 'package:sorting_hat/repository/interface/question_repository.dart';

class QuestionRepository extends BaseReadRepository<QuestionEntity> implements IQuestionRepository {
  QuestionRepository() : super();
}
