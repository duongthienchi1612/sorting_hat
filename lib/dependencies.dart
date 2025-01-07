import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/bloc_dependencies.dart';
import 'business/business_dependencies.dart';
import 'business/master_data_business.dart';
import 'model/model_dependencies.dart';
import 'model/preference/user_reference.dart';
import 'repository/repository_dependencies.dart';
import 'screen/screen_dependencies.dart';

import 'utilities/database_factory.dart';
import 'utilities/file_utility.dart';

final injector = GetIt.instance;

class AppDependencies {
  static Future<void> initialize() async {
    injector.registerLazySingleton<DatabaseFactory>(() => DatabaseFactory());
    injector.registerLazySingleton<UserReference>(() => UserReference());
    
    ModelDependencies.init(injector);
    RepositoryDependencies.init(injector);
    BusinessDependencies.init(injector);
    BlocDependencies.init(injector);
    ScreenDependencies.init(injector);

    final rootDirectory = await getApplicationDocumentsDirectory();
    injector.registerLazySingleton<FileUtility>(() => FileUtility(rootDirectory.path));
  }
}
