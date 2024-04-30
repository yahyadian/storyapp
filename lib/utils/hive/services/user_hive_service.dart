import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:submision_flutter_intermediate/global_bloc/app_bloc.dart';
import 'package:submision_flutter_intermediate/utils/hive/adapters/user.dart';
import 'package:submision_flutter_intermediate/utils/hive/adapters/user_locale.dart';

class UserHiveService {
  UserHiveService._();

  static const String boxName = 'user';
  static const String boxNameLocale = 'locale-user';
  static const String userKey = 'user-key';
  static const String localeKey = 'locale-key';

  static final box = Hive.box(boxName);
  static final boxLocale = Hive.box(boxNameLocale);

  static Locale? getLocale() {
    UserLocale? locale = boxLocale.get(localeKey);
    if (locale == null) {
      return null;
    }
    return Locale(locale.locale!);
  }

  static void setLocale(String locale) {
    for (final item in supportedLocales) {
      if (item.languageCode == locale) {
        boxLocale.put(localeKey, UserLocale(locale: locale));
        break;
      }
    }
    boxLocale.put(localeKey, UserLocale(locale: 'id'));
  }

  static UserData? getUserData() {
    UserData? user = box.get(userKey);
    return user;
  }

  static void setUserData(UserData user) {
    box.put(userKey, user);
  }

  static Future<void> deleteUser() async {
    await box.delete(userKey);
    await boxLocale.delete(localeKey);

    await box.clear();
    await boxLocale.clear();
  }
}
