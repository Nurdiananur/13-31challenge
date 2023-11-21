import 'package:get_it/get_it.dart';
import 'package:sanzhyra/app/db_helper.dart';
import 'package:sanzhyra/data/impls/api_repo_impl.dart';
import 'package:sanzhyra/data/impls/auth_repo_impl.dart';
import 'package:sanzhyra/data/impls/local_repo_impl.dart';
import 'package:sanzhyra/data/impls/map_repo_impl.dart';
import 'package:sanzhyra/data/services/app_var.dart';
import 'package:sanzhyra/domain/interfaces/api_repo.dart';
import 'package:sanzhyra/domain/interfaces/auth_repo.dart';
import 'package:sanzhyra/domain/interfaces/local_repo.dart';
import 'package:sanzhyra/domain/interfaces/map_repo.dart';

final GetIt locator = GetIt.instance;

configureDependencies() async {
  locator.registerFactory<AuthRepo>(() => AuthRepoImpl());
  // locator.registerFactoryAsync<DatabaseHelper>(() async {
  //   final dbHelper = DatabaseHelper();
  //   await dbHelper.initDb();
  //   return dbHelper;
  // });

  locator.registerFactory<LocalRepo>(() => LocalRepoImpl());
  locator.registerFactory<MapRepo>(() => MapRepoImpl());
  locator.registerFactory<ApiRepo>(() => ApiRepoImpl());
  locator.registerLazySingleton<AppVar>(() => AppVar());
}
