import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:home_services_app/service/api_handler/urls.dart';
import '../data/model/service_model.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());

  Future<void> loadServices() async {
    emit(ServicesLoading());
    try {
      final jsonString = await rootBundle.loadString(servicesUrl);
      final jsonData = json.decode(jsonString);
      final services = (jsonData['services'] as List).map((service) => ServiceModel.fromJson(service)).toList();
      emit(ServicesLoaded(services));
    } catch (e) {
      emit(ServicesError('Failed to load services: $e'));
    }
  }

  Future<void> submitServiceRequest({
    required int serviceId,
    required String phoneNumber,
    required String fullName,
    required String address,
    required String note,
  }) async {
    emit(ServicesRequestSubmitting());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(ServicesRequestSubmitted());
    } catch (e) {
      emit(ServicesError('Failed to submit request: $e'));
    }
  }

  Future<void> submitPackageRequest({
    required int packageId,
    required String phoneNumber,
    required String fullName,
    required String address,
    required double unitSize,
    required int instalmentDuration,
  }) async {
    emit(ServicesRequestSubmitting());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(ServicesRequestSubmitted());
    } catch (e) {
      emit(ServicesError('Failed to submit request: $e'));
    }
  }
}