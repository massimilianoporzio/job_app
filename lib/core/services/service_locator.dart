import 'package:get_it/get_it.dart';
import 'package:job_app/app/presentation/cubit/dark_mode_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*BLOCS / CUBITS
  //dark mode cubit
  //singleton per l'intera app
  sl.registerFactory<DarkModeCubit>(() => DarkModeCubit());
}
