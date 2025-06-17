import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_services_app/core/localizations/localization_state.dart';
import 'package:home_services_app/core/shared_preference.dart';

class LocalizationsCubit extends Cubit<LocalizationState> {
  LocalizationsCubit() : super(AppInitState());

  Locale _appLocale = const Locale('en');
  Locale get appLocal => _appLocale;

  static LocalizationsCubit get(context) => BlocProvider.of(context);

  void myCallback(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }


  listen(){
    emit(AnyUserState());
  }

  fetchLocalization() async {
    UserDataFromStorage.getData();
    if (UserDataFromStorage.languageIdFromStorage==-1) {
      _appLocale = const Locale("en");
      emit(AnyUserState());
      changeLanguage(languageCode: "en");
      if (kDebugMode) {
        print('lang ........................... ${UserDataFromStorage.languageCodeFromStorage}');
      }

      return null;
    }else {
      _appLocale = Locale(UserDataFromStorage.languageCodeFromStorage);
    }
    if (kDebugMode) {
      print('i have old lang ===${_appLocale.toString()}');
    }
    return null;
  }

  Future changeLanguage({required String languageCode,}) async {
    _appLocale =  Locale(languageCode);
    if (kDebugMode) {
      print('language after ........................ change to  ${_appLocale.toString()}');
    }
    emit(AnyUserState());
  }


}
