import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAssetImageWidget extends StatelessWidget {
  final String path;
  final Color? color;
  final double? size;
  final double?height;
  final double?width;
  final VoidCallback? onTap;
  final BoxFit? boxFit;
  final Alignment? alignment;
  const CustomAssetImageWidget({super.key,this.boxFit,this.alignment,this.height,this.width,this.color,required this.path,this.size,this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Builder(
        builder: (context) {
          if(path.split(".").last.isNotEmpty){
            if(path.split(".").last=="svg"){
              return SvgPicture.asset(
                path,
                height:height??size??0 ,
                width: width??size??0,
                fit: boxFit??BoxFit.contain,
                alignment: alignment??Alignment.center,
                colorFilter:color==null?null:ColorFilter.mode(color!, BlendMode.srcIn,),
              );
            }
            return Image.asset(
              path,
              height:height??size??0 ,
              width: width??size??0,
              color:color,
              fit: boxFit??BoxFit.contain,
              alignment: alignment??Alignment.center,
            );

          }
          return const SizedBox.shrink();

        }
      ),
    );
  }
}
