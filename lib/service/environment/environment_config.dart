
import 'package:home_services_app/core/enums.dart';
import 'package:home_services_app/core/info_helpers/device_app_helper.dart';

ApiEnvironments apiEnvironmentMode=ApiEnvironments.dev; // => to switch between environments change from here
PlatformDeviceTypeEnum platformDeviceTypeEnum=DeviceAppInformation.getDevicePlatform(); // => to switch between environments change from here


String apiBaseUrl(){
  switch(apiEnvironmentMode) {
    case ApiEnvironments.production:
      return '';
    case ApiEnvironments.preProduction:
      return '';
    case ApiEnvironments.test:
      return '';
    case ApiEnvironments.dev:
      return '';
    case ApiEnvironments.mob:
      return '';
  }
}