import 'package:sorting_hat/model/repository/master_data/answer_entity.dart';
import 'package:sorting_hat/repository/base/base_repository.dart';
import 'package:sorting_hat/repository/interface/answer_repository.dart';

class AnswerRepository extends BaseReadRepository<AnswerEntity> implements IAnswerRepository {
  AnswerRepository() : super();
}
