import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:home_services_app/service/api_handler/urls.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final jsonString = await rootBundle.loadString(offersUrl);
      final jsonData = json.decode(jsonString);
      
      final offers = (jsonData['offers'] as List).map((offer) => offer as String).toList();
      
      emit(HomeLoaded(offers));
    } catch (e) {
      emit(HomeError('Failed to load home data: $e'));
    }
  }
}