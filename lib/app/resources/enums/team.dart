import '../string_constants.dart';

enum Team {
  inSede(value: 0),
  ibrido(value: 1),
  fullRemote(value: 2);

  const Team({required this.value});

  final int value;

  @override
  String toString() {
    super.toString();
    switch (this) {
      case Team.inSede:
        return StringConsts.teamInSede;
      case Team.ibrido:
        return StringConsts.teamIbrido;
      case Team.fullRemote:
        return StringConsts.teamFullRemote;
      default:
        return StringConsts.teamFullRemote;
    }
  }
}
