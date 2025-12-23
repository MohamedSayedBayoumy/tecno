import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../common/custom_asset_image.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final String? initialValue;
  final bool? obscure;
  final bool? enabled;
  final bool? required;
  final Function(String) action;
  final Widget? prefix, suffix;
  final String? hint, label;
  final TextInputType? type;
  final TextEditingController? controller;
  final void Function()? onTap;
  final Iterable<String>? autofill;
  final bool? isEmail;
  final Function? onConfirm;
  final bool? extraValidation;
  final String? extraValidationMessage;
  final TextAlignVertical? textAlignVertical;
  final int? maxLines, minLines;
  final double? height;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? title;
  final Color? titleColor;
  final String? titleIcon;
  final bool? disableText;
  final Widget? subtitle;
  final int? maxLength;

  const CustomTextFormFieldWidget({
    super.key,
    this.initialValue,
    required this.action,
    this.obscure,
    this.prefix,
    this.hint,
    this.label,
    this.autofill,
    this.suffix,
    this.type,
    this.isEmail,
    this.enabled,
    this.onConfirm,
    this.textAlignVertical,
    this.extraValidationMessage,
    this.extraValidation,
    this.onTap,
    this.height,
    this.maxLines,
    this.minLines,
    this.required,
    this.focusNode,
    this.controller,
    this.validator,
    this.title,
    this.titleIcon,
    this.titleColor,
    this.disableText = false,
    this.subtitle,
    this.maxLength,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.titleIcon != null) ...[
              CustomAssetsImage(
                imagePath: widget.titleIcon!,
                imageColor: widget.titleColor ?? Colors.black,
                width: 15,
                height: 15,
              ),
              const SizedBox(width: 3),
            ],
            if (widget.title != null) ...[
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title!.tr,
                        maxLines: 2,
                        style: Styles.styleBold15
                            .copyWith(color: widget.titleColor ?? Colors.black),
                      ),
                      widget.subtitle ?? const SizedBox(),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: widget.focusNode,
          textAlignVertical: widget.textAlignVertical,
          onFieldSubmitted: (v) {
            if (widget.onConfirm != null) {
              widget.onConfirm!();
            }
          },
          validator: widget.validator ??
              (value) {
                if (value!.isEmpty) {
                  return "validation_filed".tr;
                }
                return null;
              },
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          enabled: widget.enabled ?? true,
          controller: widget.controller,
          autofillHints: widget.autofill,
          keyboardType:
              widget.disableText == true ? TextInputType.number : widget.type,
          initialValue: widget.initialValue,
          obscureText: widget.obscure ?? false,
          onChanged: widget.action,
          style: Styles.styleMedium15,
          maxLength: widget.maxLength,
          inputFormatters: widget.disableText == true
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ]
              : [],
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: widget.label,
            hintStyle: Styles.styleMedium13,
            labelStyle: Styles.styleMedium13,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorMaxLines: 2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            filled: true,
            fillColor: const Color(0xfffafafa),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: textFieldBackGround,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textFieldBackGround,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: mainColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
