import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'core/bloc_observer.dart';
import 'core/services/service_locator.dart' as di;

import 'app/my_app.dart';

void main() async {
  //si assicura che tutto sia inizializzato a livello native
  WidgetsFlutterBinding.ensureInitialized();
  //inizializzo per avero lo storage per hydrated_bloc (hive)
  //usando una directory temporanea sul dispostivo (path_provider)
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  //iniziallizza il logger con la stampa a video colorata
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  //inizializzo tutte le dipendenze che verranno iniettate
  await di.init();
  Bloc.observer = AppBlocObserver();
  //Imposto il locale italiano
  Intl.defaultLocale = 'it';
  //faccio girare la mia app:
  runApp(const MyApp());
}
