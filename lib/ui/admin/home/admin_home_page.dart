import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';
import 'package:my_perpus/provider/admin.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';
import 'package:my_perpus/ui/widget/search_bar.dart';
import 'package:my_perpus/ui/widget/status_peminjaman.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../widget/small_button.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool getData = true;
  int selectedIndex = 0;

  @override
  void initState() {
    if (getData) {
      // EasyLoading.show(status: "Loading");
      Provider.of<AdminProvider>(context, listen: false).getAllPeminjaman();
      getData = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _refreshController = RefreshController();
    return SafeArea(
      child: Consumer<AdminProvider>(builder: (context, valueAdmin, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorPalette.generalBackgroundColor,
            title: Text(
              "Admin",
              style: TextStyle(color: ColorPalette.generalPrimaryColor),
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  Get.toNamed(Routes.adminCheckUser);
                },
                child: Icon(
                  Icons.person,
                  color: ColorPalette.generalPrimaryColor,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () => doSignOut(context),
                child: Icon(
                  Icons.logout,
                  color: ColorPalette.generalPrimaryColor,
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          backgroundColor: ColorPalette.generalBackgroundColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorPalette.generalPrimaryColor,
            child: Icon(
              Icons.book,
              color: Colors.white,
            ),
            onPressed: () => Get.toNamed(Routes.adminTambahBuku),
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: ()async{
              await  Provider.of<AdminProvider>(context,listen:false).getAllPeminjaman();
              _refreshController.refreshCompleted();
              _refreshController.loadComplete();
            },
            onLoading: ()async{
              await Provider.of<AdminProvider>(context,listen:false).getAllPeminjaman();
              _refreshController.refreshCompleted();
              _refreshController.loadComplete();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  SearchBar(
                    title: "Cari nomor peminjaman",
                    onTapSearch: () => Get.toNamed(Routes.adminSearch),
                    enable: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                            child: SmallButton(
                          text: "Booking",
                          onPressed: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          invert: selectedIndex == 0,
                        )),
                        SizedBox(width: 5),
                        Expanded(
                            child: SmallButton(
                          text: "Konfirmasi",
                          onPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          invert: selectedIndex == 1,
                        )),
                        SizedBox(width: 5),
                        Expanded(
                            child: SmallButton(
                          text: "Peminjaman",
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 2;
                                });
                              },
                              invert: selectedIndex == 2,
                        )),
                        SizedBox(width: 5),
                        Expanded(
                            child: SmallButton(
                          text: "Selesai",
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 3;
                                });
                              },
                              invert: selectedIndex == 3,
                        )),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: valueAdmin.listPeminjaman.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {

                      return valueAdmin.listPeminjaman[index].status==selectedIndex ||
                          (selectedIndex==3 && valueAdmin.listPeminjaman[index].status==4)
                      ? GestureDetector(
                        onTap: () {
                          Provider.of<AdminProvider>(context, listen: false)
                              .onClickDetailPeminjaman(
                                  valueAdmin.listPeminjaman[index]);
                          Get.toNamed(Routes.adminDetail);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          child: StatusPeminjaman(
                            peminjamanModel: valueAdmin.listPeminjaman[index],
                          ),
                        ),
                      ):SizedBox();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  doSignOut(BuildContext context) async {
    EasyLoading.show(status: "Loading...");
    var result =
        await Provider.of<AuthProvider>(context, listen: false).doSignOut();
    result.fold((l) {
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        desc: l,
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: ColorPalette.generalPrimaryColor,
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
    }, (r) {
      EasyLoading.dismiss();
      Get.offAllNamed(Routes.login);
    });
  }
}
