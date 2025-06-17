import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';
import '../../logic/services_cubit.dart';
import '../../data/model/package_model.dart';

class PackageRequestPage extends StatefulWidget {
  final int packageId;

  const PackageRequestPage({super.key, required this.packageId});

  @override
  State<PackageRequestPage> createState() => _PackageRequestPageState();
}

class _PackageRequestPageState extends State<PackageRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _unitSizeController = TextEditingController();
  
  int _selectedInstalment = 0; // 0 = cash
  final List<int> _instalmentOptions = [0, 6, 12,24]; // months

  @override
  void dispose() {
    _phoneController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _unitSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text('package_request'.tr),
      ),
      body: BlocListener<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is ServicesRequestSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("package_request".tr)),
            );
            context.pop();
          } else if (state is ServicesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is ServicesLoaded) {
              PackageModel? package;
              for (final service in state.services) {
                for (final pkg in service.packages) {
                  if (pkg.id == widget.packageId) {
                    package = pkg;
                    break;
                  }
                }
                if (package != null) break;
              }

              if (package == null) {
                return const Center(child: Text('Package not found'));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Package Info Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                package.getName(languageCode),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${'price_per_meter'.tr}: ${package.pricePerMeter.toStringAsFixed(0)} L.E',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Unit Size
                      TextFormField(
                        controller: _unitSizeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "unit_size".tr,
                          prefixIcon: const Icon(Icons.square_foot),
                          suffixText: 'm²',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter unit size';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onChanged: (value) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      
                      // Total Price Display
                      if (_unitSizeController.text.isNotEmpty &&
                          double.tryParse(_unitSizeController.text) != null) ...[
                        Card(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("total_price".tr),
                                    Text(
                                      '${(package.pricePerMeter * double.parse(_unitSizeController.text)).toStringAsFixed(0)} L.E',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                if (_selectedInstalment > 0) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('price_per_month'.tr),
                                      Text(
                                        '${((package.pricePerMeter * double.parse(_unitSizeController.text)) / _selectedInstalment).toStringAsFixed(0)} L.E',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      
                      // Instalment Duration
                      Text(
                        'instalment_duration'.tr,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._instalmentOptions.map((months) => RadioListTile<int>(
                        title: Text(months == 0 
                          ? 'cash'.tr : '$months ${"months".tr}'),
                        value: months,
                        groupValue: _selectedInstalment,
                        onChanged: (value) {
                          setState(() {
                            _selectedInstalment = value!;
                          });
                        },
                      )).toList(),
                      const SizedBox(height: 24),
                      
                      // Contact Information
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
                          labelText: 'address'.tr,
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      // Submit Button
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
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      final unitSize = double.parse(_unitSizeController.text);
      
      context.read<ServicesCubit>().submitPackageRequest(
        packageId: widget.packageId,
        phoneNumber: _phoneController.text,
        fullName: _fullNameController.text,
        address: _addressController.text,
        unitSize: unitSize,
        instalmentDuration: _selectedInstalment,
      );
    }
  }
}