import 'package:festum_evento/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaWidget extends StatelessWidget {
  final String? perifixicon;
  TextEditingController txtController;
  TextInputAction textInputAction;
  TextInputType textInputType;
  FormFieldValidator<String> validator;
  ValueChanged<String>? onChanged;
  final int line;

  SocialMediaWidget(
      {Key? key,
      required this.validator,
      this.onChanged,
      this.perifixicon,
      required this.txtController,
      required this.textInputAction,
      required this.textInputType,
      required this.line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      maxLines: line,
      controller: txtController,
      keyboardType: textInputType,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(5.0),
        ),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: AppColors.redColor),
        prefixIcon: perifixicon != null
            ? IconButton(
                onPressed: () {},
                hoverColor: null,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Image.asset(perifixicon!,fit: BoxFit.cover,))
            : const Visibility(visible: false, child: Text("data")),
      ),
    ));
  }
}
