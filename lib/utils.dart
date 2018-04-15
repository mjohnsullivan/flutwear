/// Length of the side of a square that fits inside a circle:
/// sqrt(2) * r. Use to fit images, etc. inside a round watch face
double boxInsetLength(double radius) => radius * 1.4142;

/// Builds a string showsing readable time, optionally displaying seconds
String buildTime({bool seconds}) {
  seconds = seconds ?? false; // Default seconds to false
  final time = new DateTime.now();
  final minuteStr = ':' + time.minute.toString().padLeft(2, '0');
  final secondStr = seconds ? ':' + time.second.toString().padLeft(2, '0') : '';
  return '${time.hour}$minuteStr$secondStr';
}
