import 'package:festum_evento/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const GeneralExceptionWidget({Key? key,required this.onPress}) : super(key: key);

  @override
  State<GeneralExceptionWidget> createState() =>
      _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: height * .10),
          Icon(
            Icons.cloud_off,
            color: AppColors.redColor,
            size: 50,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(child: Text('general_exception'.tr,textAlign: TextAlign.center,))),
          SizedBox(height: height * .10),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              width: 160,
              height: 44,
              decoration: BoxDecoration(color: AppColors.appColor,borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                    "Retry",
                    style: Theme.of(
                        context).textTheme.titleLarge!.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
