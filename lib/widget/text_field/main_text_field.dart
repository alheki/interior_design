import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';


class MainTextField extends StatefulWidget {
  TextEditingController? controller;
  final TextInputType inputType;
  String ? hintText;
  String ? topHelperText;
  TextStyle ? topHelperStyle;
  Widget ? suffixIcon;
  String? suffixText;
  double? suffixSizeText;
  Widget? prefixIcon;
  Function()? onTapSuffix;
  Function()? onEditingComplete;
  bool? obscureText;
  FocusNode? focusNode;
  int? mixLine;
  int? maxLength;
  int? minLine;
  Color ? backgroundColor;
  FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  TextInputAction? textInputAction;
  bool? enabled;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  bool ? userFocusedBorder;
  bool ? autoFocus;
  String ? prefixText;
  String ? labelText;
  TextAlign ? textAlign;
  VoidCallback ? prefixOnTap;
  List<TextInputFormatter>? inputFormatters;
  Color? borderColor;

  MainTextField({
    super.key,
    this.controller,
    required this.inputType,
    this.enabled,
    this.focusNode,
    this.hintText,
    this.topHelperText,
    this.topHelperStyle,
    this.hintStyle,
    this.maxLength,
    this.mixLine,
    this.obscureText,
    this.onChanged,
    this.onEditingComplete,
    this.onTapSuffix,
    this.prefixIcon,
    this.backgroundColor,
    this.textStyle,
    this.suffixIcon,
    this.minLine,
    this.autoFocus,
    this.suffixSizeText,
    this.suffixText,
    this.textInputAction,
    this.validator,
    this.userFocusedBorder,
    this.prefixText,
    this.labelText,
    this.textAlign,
    this.inputFormatters,
    this.prefixOnTap,
    this.borderColor,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFormField(
          onEditingComplete: widget.onEditingComplete,
          onTap: (){
            if(widget.controller?.selection == TextSelection.fromPosition(TextPosition(offset: (widget.controller?.text.length??0) -1))){
              widget.controller?.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller?.text.length??0));
            }
          },
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus??false,
          onChanged: widget.onChanged,
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          textInputAction: widget.textInputAction??TextInputAction.next,
          keyboardType:widget.inputType ,
          controller: widget.controller,
          enabled: widget.enabled,
          textAlign: widget.textAlign??TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          keyboardAppearance:Theme.of(context).brightness == Brightness.dark? Brightness.dark:Brightness.light,
          maxLines: widget.mixLine??1,
          minLines: widget.minLine,
          maxLength:widget.maxLength ,
          inputFormatters:widget.inputFormatters,
          obscureText: widget.obscureText??false,
          style: widget.textStyle??Theme.of(context).textTheme.titleMedium!.copyWith(
          ),
          cursorColor: Theme.of(context).colorScheme.primary,
          cursorHeight: 20,
          showCursor: widget.userFocusedBorder??true,
          decoration: InputDecoration(
            counter: const Offstage(),
            hintText: widget.hintText,
            labelText: widget.labelText,
            prefix: GestureDetector(
              onTap: widget.prefixOnTap,
              child: Text(
                widget.prefixText??'',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            prefixStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.primary,
            ),
            helperStyle: TextStyle(
              color: Colors.transparent,
              fontSize: 0,
            ),
            counterStyle:TextStyle(
              color: Colors.transparent,
              fontSize: 0,
            ),
            // labelStyle: widget.hintStyle??Theme.of(context).textTheme.titleMedium!.copyWith(
            //   fontWeight: FontWeight.normal,
            //   // color: Theme.of(context).colorScheme.disabledColor!,
            // ),

            hintStyle: widget.hintStyle??Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).disabledColor.withValues(alpha: 0.5),
            ),
            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.normal,
            ),

            prefixIcon:widget.prefixIcon ,
            suffixText:widget.suffixText ,
            suffixStyle: Theme.of(context).textTheme.titleMedium!,
            suffixIcon: widget.suffixIcon!=null?
            IconButton(
                onPressed: widget.onTapSuffix,
                icon: widget.suffixIcon!):null,
            filled: true,
            fillColor: widget.backgroundColor??Theme.of(context).cardTheme.color,
            contentPadding:EdgeInsets.only(
              left: 10,
              right: 10,
              top: 15,
              bottom: 154,
            ),
            enabledBorder: widget.borderColor!=null?OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:BorderSide(width:1,color:widget.borderColor??Theme.of(context).disabledColor),
            ):null,
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(SizeConfig.getHeight(10)),
            //   borderSide:BorderSide(width:1,color:widget.colorBorder??Theme.of(context).cardTheme.color!),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(SizeConfig.getHeight(10)),
            //   borderSide: BorderSide(width:1,color: Theme.of(context).colorScheme.error),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width:1,color: (widget.userFocusedBorder??true) ? Theme.of(context).colorScheme.primary : Theme.of(context).cardTheme.color!),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width:1,color: (widget.userFocusedBorder??true) ? Theme.of(context).colorScheme.primary : Theme.of(context).cardTheme.color!),
            ),
          ),
          validator: widget.validator??(String? val){
            if(val!.isEmpty){
              return "thisFieldRequired".tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}
