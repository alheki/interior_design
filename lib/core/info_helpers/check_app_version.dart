// import 'dart:async';
//
// import 'package:provider/provider.dart';
// import 'package:wfi/helpers/info_helpers/app_info_store.dart';
// import 'package:wfi/main.dart';
// import 'package:wfi/pages/splash/provider/api/api_os_version_provider.dart';
//
// class CheckAppVersion {
//
//   static bool showAndroidUpdatePopUp=false;
//   static bool showIosUpdatePopUp=false;
//
//
//   CheckAppVersion._();
//
//   late int firstFromApi ;
//   late int secondFromApi ;
//   late int thirdFromApi ;
//   late int firstFromStore ;
//   late int secondFromApiStore ;
//   late int thirdFromApiStore ;
//
//
//   static Future<void> getVersion() async {
//     final apiOsVersionProvider=Provider.of<ApiOsVersionProvider>(WfiApp.navigatorKey.currentState!.context,listen: false,);
//
//     await apiOsVersionProvider.getVersion();
//     await AppInfoFromStore.getAppInformationFromStore();
//
//     bool apiAndroidForce=apiOsVersionProvider.osVersionModel.data.android.force;
//     bool apiIosForce=apiOsVersionProvider.osVersionModel.data.iOs.force;
//     bool androidHaveNewVersion=false;
//     bool iosHaveNewVersion=false;
//
//
//     String apiAndroidVersion=apiOsVersionProvider.osVersionModel.data.android.version;
//     String apiIosVersion=apiOsVersionProvider.osVersionModel.data.iOs.version;
//     String storeVersion=AppInfoFromStore.version;
//
//
//
//     // if (kDebugMode) {
//     //   print(' packageName from store is :${AppInfoFromStore.packageName} ' );
//     //
//     //   print(' version from store is :${AppInfoFromStore.version} ' );
//     //
//     //   print(' buildNumber from store is :${AppInfoFromStore.buildNumber} ' );
//     // }
//
//
//     int? firstAndroidFromApi = int.tryParse(apiAndroidVersion.toString().split('.')[0]);
//     int? secondAndroidFromApi = int.tryParse(apiAndroidVersion.toString().split('.')[1]);
//     int? thirdAndroidFromApi = int.tryParse(apiAndroidVersion.toString().split('.')[2]);
//
//     int? firstIosFromApi = int.tryParse(apiIosVersion.toString().split('.')[0]);
//     int? secondIosFromApi = int.tryParse(apiIosVersion.toString().split('.')[1]);
//     int? thirdIosFromApi = int.tryParse(apiIosVersion.toString().split('.')[2]);
//
//     int? firstFromStore = int.tryParse(storeVersion.toString().split('.')[0]);
//     int? secondFromStore = int.tryParse(storeVersion.toString().split('.')[1]);
//     int? thirdFromStore = int.tryParse(storeVersion.toString().split('.')[2]);
//
//     // android have new version
//     if(firstAndroidFromApi!>firstFromStore!||secondAndroidFromApi!>secondFromStore!||thirdAndroidFromApi!>thirdFromStore!){
//       androidHaveNewVersion=true;
//     }
//     else{
//       androidHaveNewVersion=false;
//     }
//
//     // ios have new version
//     if(firstIosFromApi!>firstFromStore||secondIosFromApi!>secondFromStore!||thirdIosFromApi!>thirdFromStore!){
//       iosHaveNewVersion=true;
//     }
//     else {
//       iosHaveNewVersion=false;
//     }
//
//
//     // android have new  version and force to update
//     if(androidHaveNewVersion&&apiAndroidForce){
//       showAndroidUpdatePopUp=true;
//     }
//     else{
//       showAndroidUpdatePopUp=false;
//     }
//
//
//     // ios have new version and force to update
//     if(iosHaveNewVersion&&apiIosForce){
//       showIosUpdatePopUp=true;
//     }
//     else{
//       showIosUpdatePopUp=false;
//     }
//
//
//   }
// }
//
//
