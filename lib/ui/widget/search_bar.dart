import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: kRoundedContainer.copyWith(
        border: Border.all(
            width: 0, color: ColorPalette.generalPrimaryColor),
        borderRadius: BorderRadius.circular(30),
        color: ColorPalette.generalBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: ColorPalette.generalPrimaryColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.search,color: ColorPalette.generalPrimaryColor,),
          SizedBox(width: 10,),
          Text(
            "Cari buku",
            style: TextStyle(color: ColorPalette.generalPrimaryColor),
          ),
        ],
      ),
    );
  }
}
