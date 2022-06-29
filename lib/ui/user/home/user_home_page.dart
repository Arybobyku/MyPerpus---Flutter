import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/provider/buku.dart';
import 'package:my_perpus/provider/peminjaman.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/book_container.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<BukuProvider, PeminjamanProvider>(
          builder: (context, valueBuku, valuePeminjaman, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      onTapSearch: () => Get.toNamed(Routes.search),
                      enable: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>Get.toNamed(Routes.userKeranjang),
                    child: Stack(
                      children: [
                        if (valuePeminjaman.keranjang.isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Text(
                              valuePeminjaman.keranjang.length.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, left: 5),
                          child: Icon(
                            Icons.card_travel,
                            color: ColorPalette.generalPrimaryColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
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
                  itemCount: valueBuku.listBuku.length,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20),
                      child: BookContainer(
                        bukuModel: valueBuku.listBuku[index],
                        onTapBook: () {
                          Provider.of<BukuProvider>(context, listen: false)
                              .clickBukuDetail(valueBuku.listBuku[index]);
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
                  "lebih banyak buku",
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
                      crossAxisSpacing: 20),
                  itemCount: valueBuku.listBuku.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BookContainer(
                      imageHeight: 180,
                      bukuModel: valueBuku.listBuku[index],
                      onTapBook: () {
                        Provider.of<BukuProvider>(context, listen: false)
                            .clickBukuDetail(valueBuku.listBuku[index]);
                        Get.toNamed(Routes.detailBuku);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
