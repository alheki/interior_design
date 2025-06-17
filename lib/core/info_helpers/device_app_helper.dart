
import 'dart:io';

import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kDebugMode, kIsWeb;
import 'package:home_services_app/core/enums.dart';

class DeviceAppInformation{

  static String deviceLanguageCode='ar';

  static PlatformDeviceTypeEnum getDevicePlatform(){
    if (kIsWeb) {
      if(defaultTargetPlatform==TargetPlatform.android){

        return PlatformDeviceTypeEnum.webAndroidDevice;
      }
      else if(defaultTargetPlatform==TargetPlatform.iOS){

        return PlatformDeviceTypeEnum.webIosDevice;
      }
      else{
        return PlatformDeviceTypeEnum.webDesktop;

      }
    }
    else{
      if(Platform.isAndroid){
        return PlatformDeviceTypeEnum.androidApplication;
      }
      else if(Platform.isIOS){
        return PlatformDeviceTypeEnum.iosApplication;
      }
      else if(Platform.isMacOS){
        return PlatformDeviceTypeEnum.macOsApplication;
      }
      else if(Platform.isLinux){
        return PlatformDeviceTypeEnum.linuxApplication;
      }
      else if(Platform.isWindows){
        return PlatformDeviceTypeEnum.webAndroidDevice;
      }
    }
    return PlatformDeviceTypeEnum.webDesktop;

  }

  static getDeviceLanguageCode()async{
    deviceLanguageCode= Platform.localeName.toString()[0]+Platform.localeName.toString()[1];
    if (kDebugMode) {
      print('device Language Code is $deviceLanguageCode');
    }

  }

}



