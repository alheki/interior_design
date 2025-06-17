import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:home_services_app/features/home/presentation/widget/app_drawer.dart';
import 'package:home_services_app/features/home/presentation/widget/home_offer_card_widget.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import '../../../../utils/app_router_consts.dart';
import '../../../services/logic/services_cubit.dart';
import '../../logic/home_cubit.dart';
import '../widget/service_card.dart';
import '../widget/package_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("app_name".tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.push(AppRouterConsts.notifications),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeCubit>().loadHomeData();
          context.read<ServicesCubit>().loadServices();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Offers Slider Section
              _buildOffersSection(context),
              const SizedBox(height: 24),
              
              // Services Section
              _buildPackagesSection(context),

              const SizedBox(height: 24),
              
              // Interior Design Packages Section
              _buildServicesSection(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffersSection(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "offers".tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (state is HomeLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
                items: state.offers.map((offer) {
                  return HomeOfferCardWidget(offer: offer,);
                }).toList(),
              );
            }
            
            return const SizedBox(height: 200);
          },
        ),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "services".tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is ServicesLoading) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (state is ServicesLoaded) {
              final regularServices = state.services.where((service) => !service.withPackages).toList();
              return SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: regularServices.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      service: regularServices[index],
                      onTap: () => context.push(
                        '${AppRouterConsts.serviceDetails}/${regularServices[index].id}',
                      ),
                    );
                  },
                ),
              );
            }
            
            return const SizedBox(height: 200);
          },
        ),
      ],
    );
  }

  Widget _buildPackagesSection(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "interior_design".tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is ServicesLoaded) {
              final interiorService = state.services.firstWhere((service) => service.withPackages);
              
              return SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: interiorService.packages.length,
                  itemBuilder: (context, index) {
                    return PackageCard(
                      package: interiorService.packages[index],
                      onTap: () => context.push(
                        '${AppRouterConsts.packageDetails}/${interiorService.packages[index].id}',
                      ),
                    );
                  },
                ),
              );
            }
            
            return const SizedBox(height: 200);
          },
        ),
      ],
    );
  }
}


