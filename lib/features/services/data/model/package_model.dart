import 'package:equatable/equatable.dart';

class PackageModel extends Equatable {
  final int id;
  final String enPackageName;
  final String arPackageName;
  final String cover;
  final List<String> galleryImages;
  final double pricePerMeter;
  final List<PackagePoint>? points;
  final int serviceId;

  const PackageModel({
    required this.id,
    required this.enPackageName,
    required this.arPackageName,
    required this.cover,
    required this.galleryImages,
    required this.pricePerMeter,
    this.points,
    required this.serviceId,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as int,
      enPackageName: json['en_package_name'] as String,
      arPackageName: json['ar_package_name'] as String,
      cover: json['cover'] as String,
      galleryImages: List<String>.from(json['gallery_images'] as List),
      pricePerMeter: (json['price_per_meter'] as num).toDouble(),
      points: (json['points'] as List?)
          ?.map((point) => PackagePoint.fromJson(point))
          .toList(),
      serviceId: json['service_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en_package_name': enPackageName,
      'ar_package_name': arPackageName,
      'cover': cover,
      'gallery_images': galleryImages,
      'price_per_meter': pricePerMeter,
      'points': points?.map((point) => point.toJson()).toList(),
      'service_id': serviceId,
    };
  }

  String getName(String languageCode) {
    return languageCode == 'ar' ? arPackageName : enPackageName;
  }

  @override
  List<Object?> get props => [
        id,
        enPackageName,
        arPackageName,
        cover,
        galleryImages,
        pricePerMeter,
        points,
        serviceId,
      ];
}

class PackagePoint extends Equatable {
  final String enTitle;
  final String arTitle;

  const PackagePoint({
    required this.enTitle,
    required this.arTitle,
  });

  factory PackagePoint.fromJson(Map<String, dynamic> json) {
    return PackagePoint(
      enTitle: json['en_title'] as String,
      arTitle: json['ar_title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en_title': enTitle,
      'ar_title': arTitle,
    };
  }

  String getTitle(String languageCode) {
    return languageCode == 'ar' ? arTitle : enTitle;
  }

  @override
  List<Object?> get props => [enTitle, arTitle];
}