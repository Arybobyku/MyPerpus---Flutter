import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/ui/widget/input_field_rounded.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, this.onTapSearch,this.enable = true}) : super(key: key);
  final Function()? onTapSearch;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTapSearch,
      child: Container(
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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search,color: ColorPalette.generalPrimaryColor,),
            SizedBox(width: 10,),
            Expanded(
              child: TextField(
                maxLines: 1,
                minLines: 1,
                enabled: enable,
                decoration: InputDecoration(
                    filled: false,
                    isDense: true,
                    hoverColor: ColorPalette.generalPrimaryColor,
                    hintText: "Cari Buku",
                    hintStyle: TextStyle(
                        color: ColorPalette.generalPrimaryColor
                    ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  counterText: null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
