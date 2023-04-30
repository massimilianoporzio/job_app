import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_patterns/connection.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get_it/get_it.dart';

import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';
import 'package:job_app/app/presentation/cubit/sound/sound_cubit.dart';
import 'package:job_app/core/presentation/cubit/annuncio_cubit.dart';
import 'package:job_app/core/services/api/api_client.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource_impl.dart';
import 'package:job_app/features/aziende/data/mappers/annuncio_azienda_mapper.dart';
import 'package:job_app/features/aziende/data/repositories/aziende_repository_impl.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_all_annunci.dart';
import 'package:job_app/features/aziende/domain/usecases/load_annunci.dart';
import 'package:job_app/features/aziende/presentation/cubit/annunci/aziende_cubit.dart';

import 'package:job_app/features/aziende/presentation/cubit/filters/aziende_filter_cubit.dart';
import 'package:job_app/features/freelancers/data/datasources/freelancers_datasource.dart';
import 'package:job_app/features/freelancers/data/datasources/freelancers_datasource_impl.dart';
import 'package:job_app/features/freelancers/data/repositories/freelancers_repo_impl.dart';
import 'package:job_app/features/freelancers/domain/repositories/freelancers_repo.dart';
import 'package:job_app/features/freelancers/domain/usecases/load_annunci_freelancer.dart';
import 'package:job_app/features/freelancers/domain/usecases/refresh_annunci_freelancer.dart';
import 'package:job_app/features/freelancers/presentation/cubit/annunci/freelancers_cubit.dart';
import 'package:job_app/features/freelancers/presentation/cubit/filters/freelancers_filters_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../app/tools/connection/connectivity_plus_repository.dart';
import '../../features/aziende/domain/usecases/refresh_annunci.dart';
import '../../features/freelancers/data/mappers/annuncio_freelancers_mapper.dart';
import '../domain/usecases/fetch_annuncio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*DATASOURCES
  sl.registerLazySingleton<AziendeDatasource>(() => AziendeDatasourceImpl(
        dio: sl<Dio>(),
        prefs: sl<SharedPreferences>(),
      ));

  sl.registerLazySingleton<FreelancersDatasource>(
      () => FreelancersDataSourceImpl(dio: sl<Dio>()));

  //*REPOSITORIES
  sl.registerLazySingleton<ConnectionRepository>(
      () => ConnectivityPlusRepository(sl<Connectivity>()));

  sl.registerLazySingleton<AziendeRepository>(
      () => AziendeRepositoryImpl(remoteDS: sl<AziendeDatasource>()));

  sl.registerLazySingleton<FreelancersRepository>(
      () => FreelancersRepositoryImpl(remoteDS: sl<FreelancersDatasource>()));

  //*USECASES
  //aziende:
  sl.registerLazySingleton<FetchAnnunciAzienda>(
      () => FetchAnnunciAzienda(repository: sl<AziendeRepository>()));

  sl.registerLazySingleton<LoadAnnunciAzienda>(
      () => LoadAnnunciAzienda(repository: sl<AziendeRepository>()));
  sl.registerLazySingleton<RefreshAnnunciAzienda>(
      () => RefreshAnnunciAzienda(repository: sl<AziendeRepository>()));

  //freelancers:
  sl.registerLazySingleton<LoadAnnunciFreelancers>(
      () => LoadAnnunciFreelancers(repository: sl<FreelancersRepository>()));
  sl.registerLazySingleton<RefreshAnnunciFreelancer>(
      () => RefreshAnnunciFreelancer(repository: sl<FreelancersRepository>()));

  sl.registerLazySingleton<FetchAnnuncio>(() => FetchAnnuncio());

  //*BLOCS / CUBITS

  //sound cubit
  sl.registerFactory<SoundCubit>(() => SoundCubit());

  //dark mode cubit
  sl.registerFactory<DarkModeCubit>(() => DarkModeCubit());

  //bottom navigation cubit
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  //dettaglio annuncio (Either) NON USATO
  sl.registerFactory<AnnuncioCubit>(
      () => AnnuncioCubit(fetchAnnuncioUsecase: sl<FetchAnnuncio>()));

  //filtri e ricerca per aziende
  sl.registerFactory<AziendeFilterCubit>(() => AziendeFilterCubit());
  //filtri e ricerca per freelancers
  sl.registerFactory<FreelancersFiltersCubit>(() => FreelancersFiltersCubit());

  //annunci aziende cubit
  sl.registerFactory<AziendeCubit>(() => AziendeCubit(
        fetchAnnunciUsecase: sl<FetchAnnunciAzienda>(),
        loadAnnunciUsecase: sl<LoadAnnunciAzienda>(),
        refreshAnnunciUsecase: sl<RefreshAnnunciAzienda>(),
      ));
  //Annunci freelancers
  sl.registerFactory<FreelancersCubit>(() => FreelancersCubit(
        loadAnnunciUsecase: sl<LoadAnnunciFreelancers>(),
        refreshAnnunciUsecase: sl<RefreshAnnunciFreelancer>(),
      ));

  //*MAPPERS
  sl.registerLazySingleton<AnnuncioAziendaMapper>(
      () => AnnuncioAziendaMapper());
  sl.registerLazySingleton<AnnuncioFreelancersMapper>(
      () => AnnuncioFreelancersMapper());

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
