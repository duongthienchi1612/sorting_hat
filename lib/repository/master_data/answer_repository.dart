import '../../model/repository/master_data/answer_entity.dart';
import '../base/base_repository.dart';
import '../interface/answer_repository.dart';

class AnswerRepository extends BaseReadRepository<AnswerEntity> implements IAnswerRepository {
  AnswerRepository() : super();
}
