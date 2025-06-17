import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final bool enable;
  final bool loading;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final String title;
  
  const MainButton({
    required this.title,
    super.key,
    this.onPressed,
    this.height,
    this.width,
    this.textStyle,
    this.enable=true,
    this.loading=false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:loading?(){}:enable&&!loading? onPressed:null,
      child: loading
          ? SizedBox(
        height: height??20,
        width: height??20,
        child: CircularProgressIndicator(
          color: Theme.of(context).indicatorColor,
          strokeWidth: 2,
        ),
      ) : Text(
        title,
        style: textStyle,
      ),
    );
  }
}
