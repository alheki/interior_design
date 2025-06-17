import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../logic/contact_cubit.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("contact".tr),
      ),
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ContactError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ContactCubit>().loadContactInfo(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ContactLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    context,
                    "whatsapp".tr,
                    Icons.chat,
                    state.whatsappNumbers.map((number) => 
                      ListTile(
                        leading: const Icon(Icons.chat, color: Colors.green),
                        title: Text(number),
                        onTap: () => _launchWhatsApp(number),
                      )
                    ).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSection(
                    context,
                    "phone".tr,
                    Icons.phone,
                    state.phoneNumbers.map((number) => 
                      ListTile(
                        leading: const Icon(Icons.phone, color: Colors.blue),
                        title: Text(number),
                        onTap: () => _launchPhone(number),
                      )
                    ).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSection(
                    context,
                    "address".tr,
                    Icons.location_on,
                    [
                      ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.red),
                        title: Text(state.address),
                        subtitle: Text("location".tr),
                        onTap: () => _launchMap(state.location),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  void _launchWhatsApp(String number) async {
    final uri = Uri.parse('https://wa.me/$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchPhone(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchMap(String location) async {
    final uri = Uri.parse('https://maps.google.com/?q=$location');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}