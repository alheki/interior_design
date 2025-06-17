import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  Future<void> loadContactInfo() async {
    emit(ContactLoading());
    try {
      final jsonString = await rootBundle.loadString('assets/data/contact.json');
      final jsonData = json.decode(jsonString);
      
      final whatsappNumbers = List<String>.from(jsonData['whatsapp_numbers']);
      final phoneNumbers = List<String>.from(jsonData['phone_numbers']);
      final address = jsonData['address'] as String;
      final location = jsonData['location'] as String;
      
      emit(ContactLoaded(whatsappNumbers, phoneNumbers, address, location));
    } catch (e) {
      emit(ContactError('Failed to load contact info: $e'));
    }
  }
}