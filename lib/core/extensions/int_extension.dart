extension IntExtension on int? {
  Duration get milliseconds => Duration(milliseconds: this ?? 0);

  Duration get seconds => Duration(seconds: this ?? 0);

  Duration get microseconds => Duration(microseconds: this ?? 0);

  Duration get hours => Duration(hours: this ?? 0);
}
