import 'package:shared_preferences/shared_preferences.dart';

class UserDataFromStorage {
  static late bool firstTime;
  static late bool userIsGuest;
  static late bool themeIsDarkMode;
  static String languageCodeFromStorage = 'en';
  static int languageIdFromStorage = 1;
  static String languageNameFromStorage = "langEnglish";

  static late int userIdFromStorage;
  static late String userImageFromStorage;
  static late String userFullNameFromStorage;
  static late String userEmailFromStorage;
  static late String phoneNumberFromStorage;
  static late String userTokenFromStorage;
  static late int userGenderIdFromStorage;
  static late int userCountryIdFromStorage;
  static late String userCountryCodeFromStorage;
  static late int useCurrencyIdFromStorage;
  static late String useCurrencyCodeFromStorage;
  static late String useCurrencyNameFromStorage;



  static setFirstTimeApp(bool value) {
    firstTime = value;
    _setData();
  }

  static setUseCurrencyCode(String value) {
    useCurrencyCodeFromStorage = value;
    _setData();
  }

  static setUseCurrencyName(String value) {
    useCurrencyNameFromStorage = value;
    _setData();
  }

  static setUseImage(String value) {
    userImageFromStorage = value;
    _setData();
  }

  static setUseCurrencyId(int value) {
    useCurrencyIdFromStorage = value;
    _setData();
  }



  static setUserId(int count) {
    userIdFromStorage = count;
    _setData();
  }

  static setUserGenderId(int count) {
    userGenderIdFromStorage = count;
    _setData();
  }

  static setUserCountryId(int value) {
    userCountryIdFromStorage = value;
    _setData();
  }
  static setUserCountryCode(String value) {
    userCountryCodeFromStorage = value;
    _setData();
  }

  static setUserIsGuest(bool block) {
    userIsGuest = block;
    _setData();
  }

  static setThemeIsDarkMode(bool darkMode) {
    themeIsDarkMode = darkMode;
    _setData();
  }


  static setUserFullName(String value) {
    userFullNameFromStorage = value;
    _setData();
  }


  static setUserEmail(String value) {
    userEmailFromStorage = value;
    _setData();
  }



  static setAppLanguageCode(String value) {
    languageCodeFromStorage = value;
    _setData();
  }
  static setAppLanguageId(int value) {
    languageIdFromStorage = value;
    _setData();
  }



  static setAppLanguageName(String value) {
    languageNameFromStorage = value;
    _setData();
  }


  static setToken(String value) {
    userTokenFromStorage = value;
    _setData();
  }


  static setPhoneNumber(String value) {
    phoneNumberFromStorage = value;
    _setData();
  }



  /// this function to remove all storage
  static removeAllDataFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// this function to remove any data from local storage by key
  static removeDataFromStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  //#region private
  static void _setData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("userIsGuest", userIsGuest);
    prefs.setBool("firstTime", firstTime);
    prefs.setBool("themeIsDarkMode", themeIsDarkMode);
    prefs.setString("userImageFromStorage", userImageFromStorage);
    prefs.setString("useCurrencyCodeFromStorage", useCurrencyCodeFromStorage);
    prefs.setString("useCurrencyNameFromStorage", useCurrencyNameFromStorage);
    prefs.setString("languageCodeFromStorage", languageCodeFromStorage);
    prefs.setInt("userCountryIdFromStorage", userCountryIdFromStorage);
    prefs.setInt("useCurrencyIdFromStorage", useCurrencyIdFromStorage);
    prefs.setInt("languageIdFromStorage", languageIdFromStorage);
    prefs.setString("languageNameFromStorage", languageNameFromStorage);
    prefs.setString("userTokenFromStorage", userTokenFromStorage);
    prefs.setString("phoneNumberFromStorage", phoneNumberFromStorage);
    prefs.setString("userEmailFromStorage", userEmailFromStorage);
    prefs.setString("userFullNameFromStorage", userFullNameFromStorage);
    prefs.setString("userCountryCodeFromStorage", userCountryCodeFromStorage);
    prefs.setInt("userIdFromStorage", userIdFromStorage);
    prefs.setInt("userGenderIdFromStorage", userGenderIdFromStorage);

  }






  static getData() async {
    final prefs = await SharedPreferences.getInstance();
    userIsGuest = prefs.getBool("userIsGuest") ?? true;
    firstTime = prefs.getBool("firstTime") ?? true;
    themeIsDarkMode = prefs.getBool("themeIsDarkMode") ?? false;
    userImageFromStorage = prefs.getString("userImageFromStorage") ?? '';
    languageCodeFromStorage = prefs.getString("languageCodeFromStorage") ?? 'en';
    userCountryIdFromStorage = prefs.getInt("userCountryIdFromStorage") ?? 1;
    useCurrencyIdFromStorage = prefs.getInt("useCurrencyIdFromStorage") ?? 1;
    languageIdFromStorage = prefs.getInt("languageIdFromStorage") ?? 1;
    useCurrencyCodeFromStorage = prefs.getString("useCurrencyCodeFromStorage") ?? 'L.E';
    useCurrencyNameFromStorage = prefs.getString("useCurrencyNameFromStorage") ?? 'Egyptian Pound';
    languageNameFromStorage = prefs.getString("languageNameFromStorage") ?? 'langEnglish';
    userFullNameFromStorage = prefs.getString("userFullNameFromStorage") ?? '';
    userCountryCodeFromStorage = prefs.getString("userCountryCodeFromStorage") ?? '';
    userTokenFromStorage = prefs.getString("userTokenFromStorage") ?? 'null';
    phoneNumberFromStorage = prefs.getString("phoneNumberFromStorage") ?? '';
    userEmailFromStorage = prefs.getString("userEmailFromStorage") ?? '';
    userIdFromStorage = prefs.getInt("userIdFromStorage") ?? 0;
    userGenderIdFromStorage = prefs.getInt("userGenderIdFromStorage") ?? 0;
  }



//#endregion
}
