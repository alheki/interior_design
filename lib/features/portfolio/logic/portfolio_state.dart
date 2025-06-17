part of 'portfolio_cubit.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final String vision;
  final String mission;
  final String values;
  final int customersServed;
  final int projectsCompleted;
  final int yearsExperience;

  const PortfolioLoaded(
    this.vision,
    this.mission,
    this.values,
    this.customersServed,
    this.projectsCompleted,
    this.yearsExperience,
  );

  @override
  List<Object> get props => [
    vision,
    mission,
    values,
    customersServed,
    projectsCompleted,
    yearsExperience,
  ];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object> get props => [message];
}