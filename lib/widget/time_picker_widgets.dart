import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerWidget extends StatefulWidget {
  final String text;
  final TextEditingController txtController;
  FormFieldValidator<String> validator;

  TimePickerWidget(
      {Key? key,
      required this.text,
      required this.txtController,
      required this.validator})
      : super(key: key);

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  String? start;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(text: widget.text, size: 14, color: AppColors.txtgreyColor),
        const SizedBox(height: 10),
        TextField(
          controller: widget.txtController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: "HH : MM : SS",
            hintStyle: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(Icons.access_time_filled,color: AppColors.greyColor,), //icon of text field
          ),
          readOnly: true,
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child ?? Container());
              },
              context: context,
            );
            if (pickedTime != null) {
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              print(parsedTime);
              String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
              print(formattedTime);
              setState(() {
                widget.txtController.text =
                    formattedTime;
              });
            } else {
              print("Time is not selected");
            }
          },
        )
      ],
    );
  }
}
