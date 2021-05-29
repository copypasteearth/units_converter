import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available VOLUME units
enum VOLUME {
  cubic_yards,
  cubic_meters,
  liters,
  imperial_gallons,
  us_gallons,
  imperial_pints,
  us_pints,
  milliliters,
  tablespoons_us,
  australian_tablespoons,
  cups,
  cubic_centimeters,
  cubic_feet,
  cubic_inches,
  cubic_millimeters,
  imperial_fluid_ounces,
  us_fluid_ounces,
  imperial_gill,
  us_gill,
}

class Volume extends Property<VOLUME, double> {
  //Map between units and its symbol
  final Map<VOLUME, String> mapSymbols = {
    VOLUME.cubic_yards: 'yd³',
    VOLUME.cubic_meters: 'm³',
    VOLUME.liters: 'l',
    VOLUME.imperial_gallons: 'imp gal',
    VOLUME.us_gallons: 'US gal',
    VOLUME.imperial_pints: 'imp pt',
    VOLUME.us_pints: 'US pt',
    VOLUME.milliliters: 'ml',
    VOLUME.tablespoons_us: 'tbsp.',
    VOLUME.australian_tablespoons: 'tbsp.',
    VOLUME.cups: 'cup',
    VOLUME.cubic_centimeters: 'cm³',
    VOLUME.cubic_feet: 'ft³',
    VOLUME.cubic_inches: 'in³',
    VOLUME.cubic_millimeters: 'mm³',
    VOLUME.imperial_fluid_ounces: 'imp fl oz',
    VOLUME.us_fluid_ounces: 'US fl oz',
    VOLUME.imperial_gill: 'Imp. gi.',
    VOLUME.us_gill: 'US. liq. gi',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for volume conversions, e.g. if you want to convert 1 liter in US Gallons:
  ///```dart
  ///var volume = Volume(removeTrailingZeros: false);
  ///volume.convert(Unit(VOLUME.liters, value: 1));
  ///print(VOLUME.us_gallons);
  /// ```
  Volume({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = VOLUME.values.length;
    this.name = name ?? PROPERTY.VOLUME;
    VOLUME.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(
      name: VOLUME.cubic_meters,
      leafNodes: [
        Node(coefficientProduct: 1e-3, name: VOLUME.liters, leafNodes: [
          Node(
            coefficientProduct: 4.54609,
            name: VOLUME.imperial_gallons,
          ),
          Node(
            coefficientProduct: 764.554858,
            name: VOLUME.cubic_yards,
          ),
          Node(
            coefficientProduct: 3.785411784,
            name: VOLUME.us_gallons,
          ),
          Node(
            coefficientProduct: 0.56826125,
            name: VOLUME.imperial_pints,
            leafNodes: [
              Node(
                coefficientProduct: 1 / 20,
                name: VOLUME.imperial_fluid_ounces,
                leafNodes: [
                  Node(coefficientProduct: 5, name: VOLUME.imperial_gill),
                ],
              ),
            ],
          ),
          Node(
            coefficientProduct: 0.473176473,
            name: VOLUME.us_pints,
            leafNodes: [
              Node(
                coefficientProduct: 1 / 16,
                name: VOLUME.us_fluid_ounces,
                leafNodes: [
                  Node(
                    coefficientProduct: 4,
                    name: VOLUME.us_gill,
                  ),
                ],
              ),
            ],
          ),
          Node(coefficientProduct: 1e-3, name: VOLUME.milliliters, leafNodes: [
            Node(
              coefficientProduct: 14.786774708700538,
              name: VOLUME.tablespoons_us,
            ),
            Node(
              coefficientProduct: 20.0,
              name: VOLUME.australian_tablespoons,
            ),
            Node(
              coefficientProduct: 240.0,
              name: VOLUME.cups,
            ),
          ]),
        ]),
        Node(coefficientProduct: 1e-6, name: VOLUME.cubic_centimeters, leafNodes: [
          Node(coefficientProduct: 16.387064, name: VOLUME.cubic_inches, leafNodes: [
            Node(
              coefficientProduct: 1728.0,
              name: VOLUME.cubic_feet,
            ),
          ]),
        ]),
        Node(
          coefficientProduct: 1e-9,
          name: VOLUME.cubic_millimeters,
        ),
      ],
    );
  }

  ///Converts a unit with a specific name (e.g. VOLUME.cubic_feet) and value to all other units
  @override
  void convert(VOLUME name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < VOLUME.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(VOLUME.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get cubic_meters => getUnit(VOLUME.cubic_meters);
  Unit get liters => getUnit(VOLUME.liters);
  Unit get imperial_gallons => getUnit(VOLUME.imperial_gallons);
  Unit get us_gallons => getUnit(VOLUME.us_gallons);
  Unit get imperial_pints => getUnit(VOLUME.imperial_pints);
  Unit get us_pints => getUnit(VOLUME.us_pints);
  Unit get milliliters => getUnit(VOLUME.milliliters);
  Unit get tablespoons_us => getUnit(VOLUME.tablespoons_us);
  Unit get australian_tablespoons => getUnit(VOLUME.australian_tablespoons);
  Unit get cups => getUnit(VOLUME.cups);
  Unit get cubic_centimeters => getUnit(VOLUME.cubic_centimeters);
  Unit get cubic_feet => getUnit(VOLUME.cubic_feet);
  Unit get cubic_inches => getUnit(VOLUME.cubic_inches);
  Unit get cubic_millimeters => getUnit(VOLUME.cubic_millimeters);
  Unit get imperial_fluid_ounces => getUnit(VOLUME.imperial_fluid_ounces);
  Unit get us_fluid_ounces => getUnit(VOLUME.us_fluid_ounces);
  Unit get imperial_gill => getUnit(VOLUME.imperial_gill);
  Unit get us_gill => getUnit(VOLUME.us_gill);
}
