import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import '../../../../utils/app_router_consts.dart';
import '../../../home/presentation/widget/service_card.dart';
import '../../../home/presentation/widget/package_card.dart';
import '../../logic/services_cubit.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('services'.tr),
      ),
      body: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServicesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ServicesCubit>().loadServices(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ServicesLoaded) {
            final regularServices = state.services.where((service) => !service.withPackages).toList();
            final packageServices = state.services.where((service) => service.withPackages).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (regularServices.isNotEmpty) ...[
                    Text(
                      "services".tr,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
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
                  ],
                  
                  if (packageServices.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      "interior_design".tr,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...packageServices.map((service) => Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: service.packages.length,
                          itemBuilder: (context, index) {
                            return PackageCard(
                              package: service.packages[index],
                              onTap: () => context.push(
                                '${AppRouterConsts.packageDetails}/${service.packages[index].id}',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    )).toList(),
                  ],
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}