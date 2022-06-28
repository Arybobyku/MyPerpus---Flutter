import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';

class ButtonPicker extends StatelessWidget {
  const ButtonPicker({Key? key,this.onTap}) : super(key: key);
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onTap,
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.image,
              color: ColorPalette.generalPrimaryColor,
              size: 35,
            ),
            Text(
              "Cover",
              style: TextStyle(
                  color: ColorPalette.generalPrimaryColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
