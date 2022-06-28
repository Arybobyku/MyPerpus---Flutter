import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/book_container.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: SearchBar(
                    onTapSearch: ()=> Get.toNamed(Routes.search),
                    enable: false,
                  ),
                ),
                Icon(
                  Icons.card_travel,
                  color: ColorPalette.generalPrimaryColor,
                ),
                SizedBox(width: 15)
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Buku",
                style: TextStyle(
                  fontSize: 24,
                  color: ColorPalette.generalPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 20),
                    child: BookContainer(
                      onTapBook: (){
                        Get.toNamed(Routes.detailBuku);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "More",
                style: TextStyle(
                  fontSize: 24,
                  color: ColorPalette.generalPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.45,
                  crossAxisSpacing: 20
                ),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BookContainer(
                    imageHeight: 180,
                    onTapBook: (){
                      Get.toNamed(Routes.detailBuku);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
