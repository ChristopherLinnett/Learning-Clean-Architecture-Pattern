import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:starting_project/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:starting_project/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:starting_project/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:starting_project/src/authentication/domain/use_cases/create_user.dart';
import 'package:starting_project/src/authentication/domain/use_cases/get_users.dart';
import 'package:starting_project/src/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl
  // App logic
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))
  // Usecases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
  // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
  // Datasources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
  // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
