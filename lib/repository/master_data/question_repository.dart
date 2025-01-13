import '../../model/repository/master_data/question_entity.dart';
import '../base/base_repository.dart';
import '../interface/question_repository.dart';

class QuestionRepository extends BaseReadRepository<QuestionEntity> implements IQuestionRepository {
  QuestionRepository() : super();
}
