import 'package:flutter/material.dart';
import 'package:online_gym_trainer/config/styles.dart';
import 'package:online_gym_trainer/widgets/neumorphicbox.dart';


class NeumorphicListTile extends StatelessWidget {
  final String text;
  final String count;
  final String imagePath;
  final VoidCallback ontap;

  const NeumorphicListTile({
    super.key,
    required this.text,
     this.count="",
    required this.imagePath,
     required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicBox(
      child: ListTile(
        onTap: ontap,
        leading: Image.asset(imagePath),
        title: Text(
          text,
          style: Styles.labelText(context),
        ),
        trailing: Text(
          count,
          style: Styles.labelText(context),
        ),
      ),
    );
  }
}
