import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_patterns/connection.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get_it/get_it.dart';

import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';
import 'package:job_app/app/presentation/cubit/sound/sound_cubit.dart';
import 'package:job_app/core/services/api/api_client.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource_impl.dart';
import 'package:job_app/features/aziende/data/repositories/aziende_repository_impl.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_all_annunci.dart';
import 'package:job_app/features/aziende/presentation/cubit/annunci/aziende_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../app/tools/connection/connectivity_plus_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*DATASOURCES
  sl.registerLazySingleton<AziendeDatasource>(() => AziendeDatasourceImpl(
        dio: sl<Dio>(),
        prefs: sl<SharedPreferences>(),
      ));

  //*REPOSITORIES
  sl.registerLazySingleton<ConnectionRepository>(
      () => ConnectivityPlusRepository(sl<Connectivity>()));

  sl.registerLazySingleton<AziendeRepository>(
      () => AziendeRepositoryImpl(remoteDS: sl()));

  //*USECASES
  sl.registerLazySingleton<FetchAnnunciAzienda>(
      () => FetchAnnunciAzienda(repository: sl()));

  //*BLOCS / CUBITS

  //sound cubit
  sl.registerFactory<SoundCubit>(() => SoundCubit());

  //dark mode cubit
  sl.registerFactory<DarkModeCubit>(() => DarkModeCubit());

  //bottom navigation cubit
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  //annunci anziende cubit
  sl.registerFactory<AziendeCubit>(() => AziendeCubit(
        fetchAnnunciUsecase: sl<FetchAnnunciAzienda>(),
      ));

  //*third party

  //Emoji parser
  var serverParser = EmojiParser(init: true);
  sl.registerSingleton<EmojiParser>(serverParser);

  //AUDIOPLAYER
  AudioPlayer player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  sl.registerSingleton<AudioPlayer>(player);

  //DIO
  sl.registerSingleton<Dio>(await DioClient.createDio(
      isMock: false)); //is mock è per leggere da un json per fare test
  //shared prefs
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  //connectivity
  Connectivity connectivity = Connectivity();
  sl.registerLazySingleton<Connectivity>(() => connectivity);
}
