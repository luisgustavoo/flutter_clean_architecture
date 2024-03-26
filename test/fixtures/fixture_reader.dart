import 'dart:io';

class FixtureReader {
  FixtureReader._();

  static String getJsonData(String name) =>
      File('test/fixtures/$name').readAsStringSync();
}
