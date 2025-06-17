import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit() : super(PortfolioInitial());

  Future<void> loadPortfolio() async {
    emit(PortfolioLoading());
    try {
      final jsonString = await rootBundle.loadString('assets/data/portfolio.json');
      final jsonData = json.decode(jsonString);
      
      final vision = jsonData['vision'] as String;
      final mission = jsonData['mission'] as String;
      final values = jsonData['values'] as String;
      final customersServed = jsonData['customers_served'] as int;
      final projectsCompleted = jsonData['projects_completed'] as int;
      final yearsExperience = jsonData['years_experience'] as int;
      
      emit(PortfolioLoaded(
        vision,
        mission,
        values,
        customersServed,
        projectsCompleted,
        yearsExperience,
      ));
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio: $e'));
    }
  }
}