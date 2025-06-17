import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  Future<void> loadGallery() async {
    emit(GalleryLoading());
    try {
      final jsonString = await rootBundle.loadString('assets/data/services.json');
      final jsonData = json.decode(jsonString);
      final services = jsonData['services'] as List;
      
      Map<String, List<String>> galleryData = {};
      for (var service in services) {
        final serviceName = service['en_name'] as String;
        final images = List<String>.from(service['gallery_images'] as List);
        galleryData[serviceName] = images;
      }
      
      emit(GalleryLoaded(galleryData));
    } catch (e) {
      emit(GalleryError('Failed to load gallery: $e'));
    }
  }
}