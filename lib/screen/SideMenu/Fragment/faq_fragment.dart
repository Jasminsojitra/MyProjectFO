import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:flutter/material.dart';

class FaqFragment extends StatefulWidget {
  const FaqFragment({Key? key}) : super(key: key);

  @override
  State<FaqFragment> createState() => _FaqFragmentState();
}

class _FaqFragmentState extends State<FaqFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.edtBgColor,
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context,index){
            return ExpansionTile(
                title: SmallText(text: "LOGIN", size: 16, color: Colors.black),
                children: [
                  SmallText(text: "LOGIN", size: 16, color: Colors.black),
                  SmallText(text: "LOGIN", size: 16, color: Colors.black),
                ],
            );
          }),
    );
  }
}
