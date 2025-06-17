import 'package:equatable/equatable.dart';
import 'package:home_services_app/features/services/data/model/package_model.dart';

class ServiceModel extends Equatable {
  final int id;
  final String enName;
  final String arName;
  final String enDescription;
  final String arDescription;
  final String cover;
  final List<String> galleryImages;
  final bool withPackages;
  final List<PackageModel> packages;

  const ServiceModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.enDescription,
    required this.arDescription,
    required this.cover,
    required this.galleryImages,
    required this.withPackages,
    required this.packages,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int,
      enName: json['en_name'] as String,
      arName: json['ar_name'] as String,
      enDescription: json['en_description'] as String,
      arDescription: json['ar_description'] as String,
      cover: json['cover'] as String,
      galleryImages: List<String>.from(json['gallery_images'] as List),
      withPackages: json['with_packages'] as bool,
      packages: (json['packages'] as List?)
              ?.map((pkg) => PackageModel.fromJson(pkg))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_name': enName,
      'ar_name': arName,
      'en_description': enDescription,
      'ar_description': arDescription,
      'cover': cover,
      'gallery_images': galleryImages,
      'with_packages': withPackages,
      'packages': packages.map((pkg) => pkg.toJson()).toList(),
    };
  }

  String getName(String languageCode) {
    return languageCode == 'ar' ? arName : enName;
  }

  String getDescription(String languageCode) {
    return languageCode == 'ar' ? arDescription : enDescription;
  }

  @override
  List<Object?> get props => [
        id,
        enName,
        arName,
        enDescription,
        arDescription,
        cover,
        galleryImages,
        withPackages,
        packages,
      ];
}