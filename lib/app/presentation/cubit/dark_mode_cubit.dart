import 'package:hydrated_bloc/hydrated_bloc.dart';

class DarkModeCubit extends HydratedCubit<bool> {
  DarkModeCubit(super.state);

  //restituisce il bool salvato dentro la mappa sotto la chiave 'enabled'
  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['enabled'] as bool;
  }

  //restituisce la mappa con la chiave 'enabled' contenente lo stato
  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'enabled': state};
  }

  //Metodo del cubit per cambiare lo stato
  void toggle() => emit(!state); //emette nuovo stato 'opposto' a quello in uso
}
