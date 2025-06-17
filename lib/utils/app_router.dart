import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/home/presentation/view/home_page.dart';
import '../features/services/presentation/view/services_page.dart';
import '../features/services/presentation/view/service_details_page.dart';
import '../features/services/presentation/view/package_details_page.dart';
import '../features/services/presentation/view/service_request_page.dart';
import '../features/services/presentation/view/package_request_page.dart';
import '../features/gallery/presentation/view/gallery_page.dart';
import '../features/contact/presentation/view/contact_page.dart';
import '../features/portfolio/presentation/view/portfolio_page.dart';
import '../features/notifications/presentation/view/notifications_page.dart';
import '../features/settings/presentation/view/about_us_page.dart';
import '../features/settings/presentation/view/terms_page.dart';
import '../features/settings/presentation/view/language_page.dart';
import 'app_router_consts.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouterConsts.home,
    routes: [
      GoRoute(
        path: AppRouterConsts.home,
        name: AppRouterConsts.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRouterConsts.services,
        name: AppRouterConsts.services,
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: '${AppRouterConsts.serviceDetails}/:id',
        name: AppRouterConsts.serviceDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ServiceDetailsPage(serviceId: id);
        },
      ),
      GoRoute(
        path: '${AppRouterConsts.packageDetails}/:id',
        name: AppRouterConsts.packageDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return PackageDetailsPage(packageId: id);
        },
      ),
      GoRoute(
        path: '${AppRouterConsts.serviceRequest}/:id',
        name: AppRouterConsts.serviceRequest,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ServiceRequestPage(serviceId: id);
        },
      ),
      GoRoute(
        path: '${AppRouterConsts.packageRequest}/:id',
        name: AppRouterConsts.packageRequest,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return PackageRequestPage(packageId: id);
        },
      ),
      GoRoute(
        path: AppRouterConsts.gallery,
        name: AppRouterConsts.gallery,
        builder: (context, state) => const GalleryPage(),
      ),
      GoRoute(
        path: AppRouterConsts.contact,
        name: AppRouterConsts.contact,
        builder: (context, state) => const ContactPage(),
      ),
      GoRoute(
        path: AppRouterConsts.portfolio,
        name: AppRouterConsts.portfolio,
        builder: (context, state) => const PortfolioPage(),
      ),
      GoRoute(
        path: AppRouterConsts.notifications,
        name: AppRouterConsts.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRouterConsts.aboutUs,
        name: AppRouterConsts.aboutUs,
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: AppRouterConsts.termsOfUse,
        name: AppRouterConsts.termsOfUse,
        builder: (context, state) => const TermsPage(),
      ),
      GoRoute(
        path: AppRouterConsts.language,
        name: AppRouterConsts.language,
        builder: (context, state) => const LanguagePage(),
      ),
    ],
  );
}