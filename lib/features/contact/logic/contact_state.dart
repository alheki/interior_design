part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<String> whatsappNumbers;
  final List<String> phoneNumbers;
  final String address;
  final String location;

  const ContactLoaded(
    this.whatsappNumbers,
    this.phoneNumbers,
    this.address,
    this.location,
  );

  @override
  List<Object> get props => [whatsappNumbers, phoneNumbers, address, location];
}

class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);

  @override
  List<Object> get props => [message];
}