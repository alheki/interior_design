import 'package:package_info/package_info.dart';

class AppInfoFromStore {
  static late String appName ;
  static late String packageName ;
  static late String version ;
  static late String buildNumber ;

  AppInfoFromStore._();

  static Future<void> getAppInformationFromStore() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

  }


}
