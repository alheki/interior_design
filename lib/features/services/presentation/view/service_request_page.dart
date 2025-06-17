import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import '../../logic/services_cubit.dart';

class ServiceRequestPage extends StatefulWidget {
  final int serviceId;

  const ServiceRequestPage({super.key, required this.serviceId});

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('request_service'.tr),
      ),
      body: BlocListener<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is ServicesRequestSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("request_sent".tr)),
            );
            context.pop();
          } else if (state is ServicesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "request_form".tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "phone_number".tr,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: "full_name".tr,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _addressController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "address".tr,
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "note".tr,
                    prefixIcon: const Icon(Icons.note),
                  ),
                ),
                const SizedBox(height: 32),
                
                BlocBuilder<ServicesCubit, ServicesState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is ServicesRequestSubmitting
                            ? null
                            : _submitRequest,
                        child: state is ServicesRequestSubmitting
                            ? const CircularProgressIndicator()
                            : Text("send_request".tr),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      context.read<ServicesCubit>().submitServiceRequest(
        serviceId: widget.serviceId,
        phoneNumber: _phoneController.text,
        fullName: _fullNameController.text,
        address: _addressController.text,
        note: _noteController.text,
      );
    }
  }
}