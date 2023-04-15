import '../../../app/resources/string_constants.dart';

enum Contratto {
  fullTime(value: 0),
  partTime(value: 1);

  const Contratto({required this.value});

  final int value;

  @override
  String toString() {
    super.toString();
    switch (this) {
      case Contratto.fullTime:
        return StringConsts.contrattoFullTime;
      case Contratto.partTime:
        return StringConsts.contrattoPartTime;
      default:
        return StringConsts.contrattoDefault;
    }
  }
}
