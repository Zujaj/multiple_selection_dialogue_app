import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Holds the flavour names.
  List<String> flavours;

  /// Holds the flavour names with boolean values.
  Map<String, bool> mappedFlavours = {};

  /// Converts the list of flavours to a map.
  Map<String, bool> convertToMap(List<String> flavours) {
    return Map.fromIterable(flavours,
        key: (k) => k.toString(),
        value: (v) {
          if (v != true && v != false)
            return false;
          else
            return v as bool;
        });
  }

  group('Flavours Test Case:\n', () {
    test('List is null', () => expect(flavours, isNull));
    test('List is empty', () {
      flavours = [];
      expect(flavours, isEmpty);
    });

    /// #####################################################
    /// [ 'Chocolate', 'Caramel', 'Vanilla', 'Peanut Butter']
    /// ######################################################
    test('List is not empty', () {
      flavours = ['Chocolate', 'Caramel', 'Vanilla', 'Peanut Butter'];
      expect(flavours, isNotEmpty);
    });
    test('List has total four flavours', () {
      expect(flavours.length, greaterThan(0));
      expect(flavours.length, lessThan(5));
    });
    test('First flavour of list is Chocolate',
        () => expect(flavours.first, equals('Chocolate')));
    test('Last flavour of list is Peanut Butter',
        () => expect(flavours.last, isNot(equals('Chocolate'))));

    /// #########################
    /// ['Chocolate','Caramel']
    /// #########################

    test(
        'List has two flavours starting with letter C',
        () => expect(
            flavours.where((flavour) => flavour.startsWith('C')).length,
            equals(2)));

    /// Regular Expression Reference:
    /// https://stackoverflow.com/questions/22478492/regex-matching-world-which-contain-only-vowels-or-consonants

    /// ################
    /// ooaeaaeaiaeauue
    /// ################
    test('List has total fifteen vowels', () {
      var vowels = [];
      flavours.forEach((flavour) =>
          vowels.add(flavour.split(RegExp('[^aeiouyAEIOUY0-9\W]+')).join()));

      expect(vowels.join().length, equals(15));
    });

    ///#####################
    /// ChcltCrmlVnllPntBttr
    /// ####################
    test('List has total twenty consonants', () {
      var consonants = [];
      flavours.forEach((flavour) =>
          consonants.add(flavour.split(RegExp(r'[AaEeIiOoUu ]')).join()));

      expect(consonants.join().length, equals(20));
    });

    test('Lists are not same', () => expect(flavours == [], isFalse));
  });

  group('Map Test Case:\n', () {
    test('Map is not null', () => expect(mappedFlavours, isNotNull));
    test('Map is empty', () => expect(mappedFlavours, isEmpty));
    test('Map Key is a string',
        () => expect(mappedFlavours.keys.runtimeType != int, isTrue));
    test('Map Value is a bool',
        () => expect(mappedFlavours.values.runtimeType == String, isFalse));
  });

  group('Function Test Case:\n', () {
    test('convertToMap requires a List<String> Parameter',
        () => expect(convertToMap == () => {'': false}, isFalse));
    test('convertToMap return type is Map<String,bool>', () {
      var tempFunction = (List<String> temp) => Map<String, bool>();
      expect(convertToMap.runtimeType, isNot(equals((List<String> temp) => 0)));
      expect(convertToMap.runtimeType, equals(tempFunction.runtimeType));
    });
    test('mappedFlavour should not be empty', () {
      if (mappedFlavours.isEmpty) {
        mappedFlavours = convertToMap(flavours);
      }
      expect(mappedFlavours, isNotEmpty);
    });
  });

  group('Post Conversion Test Case:\n', () {
    test('mappedFlavour has no key Cherry',
        () => expect(!mappedFlavours.containsKey('Cherry'), isTrue));
    test('mappedFlavour has no value 0',
        () => expect(!mappedFlavours.containsValue(0), isTrue));
    test(
        'mappedFlavour has no blank entries',
        () => expect(
            mappedFlavours.containsKey('') && mappedFlavours.containsValue(''),
            isFalse));
  });
}
