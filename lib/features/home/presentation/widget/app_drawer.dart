import 'package:flutter/material.dart';
import '../../../../utils/app_router_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:home_services_app/features/home/presentation/widget/home_offer_card_widget.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import '../../../../utils/app_router_consts.dart';
import '../../../services/logic/services_cubit.dart';
import '../../logic/home_cubit.dart';
import 'service_card.dart';
import 'package_card.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              "app_name".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text("home".tr),
            onTap: () => context.go(AppRouterConsts.home),
          ),
          ListTile(
            leading: const Icon(Icons.design_services),
            title: Text("services".tr),
            onTap: () => context.push(AppRouterConsts.services),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text("gallery".tr),
            onTap: () => context.push(AppRouterConsts.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: Text("contact".tr),
            onTap: () => context.push(AppRouterConsts.contact),
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text("portfolio".tr),
            onTap: () => context.push(AppRouterConsts.portfolio),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text("about_us".tr),
            onTap: () => context.push(AppRouterConsts.aboutUs),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text("terms_of_use".tr),
            onTap: () => context.push(AppRouterConsts.termsOfUse),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text("language".tr),
            onTap: () => context.push(AppRouterConsts.language),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text("theme".tr),
            onTap: () => _showThemeDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text("share_app".tr),
            onTap: () => _shareApp(),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    // Implementation for theme selection dialog
  }

  void _shareApp() {
    // Implementation for sharing the app
  }
}