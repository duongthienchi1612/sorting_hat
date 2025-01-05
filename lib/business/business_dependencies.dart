import 'package:get_it/get_it.dart';
import 'package:sorting_hat/business/master_data_business.dart';

class BusinessDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<MasterDataBusiness>(() => MasterDataBusiness());
  }
}
