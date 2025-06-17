import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_services_app/core/check_network_image_url.dart';
import 'package:home_services_app/widget/custom_asset_image_widget.dart';
import 'package:path/path.dart' as my_path;
import 'package:lottie/lottie.dart';

class CustomImageNetwork extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageUrl;
  final String? errorImage;
  final BoxFit? fit;
  final bool textDirection;
  final BoxFit? errorFit;
  final Color? errorBackground;
  final Color? loadingColor;
  final double? errorImageSize;
  final EdgeInsets? errorPadding;
  final Alignment? errorAlignment;
  final bool showOnTap;
  final bool applyColorOnPng;
  final Color? svgColor;
  final double? loadingSize;
  final double? svgSize;
  final double? errorCardSize;
  final Alignment? alignment;
  final BorderRadius? borderRadius;

  const CustomImageNetwork({
    super.key,
    required this.imageUrl,
    this.fit,
    this.textDirection=false,
    this.errorBackground,
    this.errorFit,
    this.errorImage,
    this.errorImageSize,
    this.errorPadding,
    this.loadingColor,
    this.errorAlignment,
    this.height,
    this.svgColor,
    this.width,
    this.loadingSize,
    this.errorCardSize,
    this.svgSize,
    this.alignment,
    this.borderRadius,
    this.showOnTap = false,
    this.applyColorOnPng = false,
  });

  @override
  Widget build(BuildContext context) {
    if(imageUrl ==null || imageUrl!.isEmpty||!CheckImageUrl.checkHttp(imageUrl.toString())||!CheckImageUrl.checkExtensions(imageUrl.toString())){
      return _imageError();
    }

    if(my_path.extension(imageUrl!)==".svg"){
      return ClipRRect(
        borderRadius: borderRadius??BorderRadius.zero,
        child: SvgPicture.network(
          imageUrl!,
          width: width??svgSize,
          color: svgColor,
          height:height?? svgSize,
          alignment: alignment??Alignment.center,
          colorFilter: svgColor!=null?ColorFilter.mode(svgColor??Colors.grey.shade300, BlendMode.srcIn):null,
          placeholderBuilder: (context) =>Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius??BorderRadius.zero,
              color: loadingColor??Colors.grey.shade300,
            ),
          ),

          errorBuilder: (context, error, stackTrace) {
            return _imageError();
          },

        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.zero,
      child: CachedNetworkImage(
        height: height,
        matchTextDirection: textDirection,
        fit: fit,
        width: width??double.infinity,
        alignment: alignment??Alignment.center,
        imageUrl: imageUrl??"",
        color: applyColorOnPng?svgColor:null,
        // imageUrl: baseUrl().replaceAll("/api", "")+image.toString(),
        placeholder: (context, error,) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius??BorderRadius.zero,
              color: loadingColor??Colors.grey.shade300,
            ),
          );
        },
        errorWidget: (context, error, stackTrace) {
          return _imageError();
        },
      ),
    );
  }

  Widget _imageError() {
    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.zero,
      child: Container(
        color: errorBackground,
        margin: errorPadding,
        height: errorCardSize,
        child: Center(
          child: Builder(

              builder: (context) {
                if(errorImage!=null&&errorImage!.contains(".json")){
                  return Lottie.asset(
                    errorImage??'assets/image/error_image.png',
                    width: errorImageSize,
                    height: errorImageSize,
                    fit: errorFit,
                    alignment: errorAlignment!=null?errorAlignment!:Alignment.center,

                  );
                }

                return CustomAssetImageWidget(
                  path: errorImage??'assets/image/error_image.png',
                  width: errorImageSize,
                  height: errorImageSize,
                  boxFit: errorFit,
                  alignment: errorAlignment!=null?errorAlignment!:Alignment.center,
                );
              }
          ),
        ),
      ),
    );
  }
}
