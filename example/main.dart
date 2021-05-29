import 'package:jro_units_converter/units_converter.dart';
import 'dart:core';

void main() {
  var yards = Volume(removeTrailingZeros: true);
  yards.convert(VOLUME.cubic_yards, 1);
  print(yards.tablespoons_us.stringValue);
}
