import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';
import 'package:job_app/core/services/api/dio_client.dart';

import '../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*BLOCS / CUBITS
  //dark mode cubit

  sl.registerFactory<DarkModeCubit>(() => DarkModeCubit());

  //bottom navigation cubit
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  //DIO

  sl.registerSingleton<Dio>(await DioClient.createDio());
}
