import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';
import 'package:job_app/core/services/api/api_client.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource_impl.dart';
import 'package:job_app/features/aziende/data/repositories/aziende_repository_impl.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_annunci_azienda.dart';
import 'package:job_app/features/aziende/presentation/cubit/aziende_cubit.dart';

import '../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*DATASOURCES
  sl.registerLazySingleton<AziendeDatasource>(
      () => AziendeDatasourceImpl(dio: sl()));

  //*REPOSITORIES

  sl.registerLazySingleton<AziendeRepository>(
      () => AziendeRepositoryImpl(remoteDS: sl()));

  //*USECASES
  sl.registerLazySingleton<FetchAnnunciAzienda>(
      () => FetchAnnunciAzienda(repository: sl()));

  //*BLOCS / CUBITS
  //dark mode cubit

  sl.registerFactory<DarkModeCubit>(() => DarkModeCubit());

  //bottom navigation cubit
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  //annunci anziende cubit
  sl.registerFactory<AziendeCubit>(
      () => AziendeCubit(fectAnnunciUsecase: sl<FetchAnnunciAzienda>()));

  //DIO

  sl.registerSingleton<Dio>(await DioClient.createDio());
}
