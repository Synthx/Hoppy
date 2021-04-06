import 'package:hive/hive.dart';
import 'package:hoppy/data/data.dart';

class SettingsRepository {
  Future<Settings> load() async {
    var box = await Hive.openBox('settings');
    return Settings(
      darkMode: box.get('darkMode'),
      firstVisit: box.get('firstVisit'),
      name: box.get('name'),
      birthDate: box.get('birthDate'),
    );
  }

  Future<void> setDarkMode(bool? value) async {
    var box = await Hive.openBox('settings');
    await box.put('darkMode', value);
  }

  Future<void> setFirstVisit(bool? value) async {
    var box = await Hive.openBox('settings');
    await box.put('firstVisit', value);
  }

  Future<void> setName(String? value) async {
    var box = await Hive.openBox('settings');
    await box.put('name', value);
  }

  Future<void> reset() async {
    await setName(null);
    await setDarkMode(null);
  }
}
