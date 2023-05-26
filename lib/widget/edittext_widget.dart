import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditTextWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int line;
  final Color bgColor;
  final String text;
  bool obscureText;
  bool enable;
  int? textLength;
  bool suffixicon;
  bool isFocus;
  String? perifixicon;
  FormFieldValidator<String> validator;
  ValueChanged<String>? onChanged;
  bool isCompulsoryText = false;

  EditTextWidget({Key? key,
    required this.line,
    required this.text,
    required this.textEditingController,
    this.obscureText = false,
    this.enable = true,
    this.suffixicon = false,
    this.isFocus = false,
    this.perifixicon,
    this.textLength,
    required this.textInputAction,
    required this.textInputType,
    required this.isCompulsoryText,
    required this.validator,
    required this.bgColor,
    this.onChanged})
      : super(key: key);

  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isCompulsoryText
                ? Row(
              children: [
                SmallText(
                    text: widget.text, color: AppColors.greyColor, size: 14),
                SizedBox(width: 5),
                Text(
                  "*",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.redColor),
                )
              ],
            )
                : SmallText(
                text: widget.text, color: AppColors.greyColor, size: 14),
            const SizedBox(height: 10),
            TextFormField(
              autofocus: widget.isFocus,
              onChanged: widget.onChanged,
              maxLines: widget.line,
              enabled: widget.enable,
              maxLength: widget.textLength,
              controller: widget.textEditingController,
              obscureText: widget.obscureText,
              keyboardType: widget.textInputType,
              cursorColor: AppColors.appColor,
              textInputAction: widget.textInputAction,
              validator: widget.validator,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                fillColor: widget.bgColor,
                filled: true,
                errorStyle: TextStyle(color: AppColors.redColor),
                prefixIcon: widget.perifixicon != null
                    ? IconButton(
                    onPressed: () {},
                    hoverColor: null,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: SvgPicture.asset(widget.perifixicon!,
                        fit: BoxFit.cover))
                    : null,
                suffixIcon: widget.suffixicon
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.greyColor,
                  ),
                )
                    : null,
              ),
            )
          ],
        ));
  }
}
