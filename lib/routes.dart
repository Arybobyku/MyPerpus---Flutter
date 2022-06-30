import 'package:get/get.dart';
import 'package:my_perpus/ui/admin/detail/admin_detail_page.dart';
import 'package:my_perpus/ui/admin/home/admin_home_page.dart';
import 'package:my_perpus/ui/admin/tambahBuku/admin_tambah_buku_page.dart';
import 'package:my_perpus/ui/auth/login_page.dart';
import 'package:my_perpus/ui/auth/register_page.dart';
import 'package:my_perpus/ui/navigator_page.dart';
import 'package:my_perpus/ui/user/detailRiwayat/user_detail_riwayat.dart';
import 'package:my_perpus/ui/user/detailbuku/user_detail_buku.dart';
import 'package:my_perpus/ui/user/keranjang/user_keranjang_page.dart';
import 'package:my_perpus/ui/user/main_menu_page.dart';

import 'ui/user/search/user_search_page.dart';

class Routes {
  Routes._();

  static const String navigator = "/navigator";
  static const String login = "/login";
  static const String register = "/register";
  static const String mainMenu = "/mainMenu";
  static const String adminHome = "/adminHome";
  static const String search = "/search";
  static const String detailBuku = "/detailBuku";
  static const String detailRiwayat = "/detailRiwayat";
  static const String adminDetail = "/adminDetail";
  static const String adminTambahBuku = "/adminTambahBuku";
  static const String userKeranjang = "/userKeranjang";

  static final newRoutes = <GetPage>[
    GetPage(name: navigator, page:()=>NavigatorPage()),
    GetPage(name: login, page:()=>LoginPage()),
    GetPage(name: register, page:()=>RegisterPage()),
    GetPage(name: mainMenu, page:()=>MainMenuPage()),
    GetPage(name: adminHome, page:()=>AdminHomePage()),
    GetPage(name: search, page:()=>UserSearchPage()),
    GetPage(name: detailBuku, page:()=>UserDetailBukuPage()),
    GetPage(name: detailRiwayat, page:()=>UserDetailRiwayat()),
    GetPage(name: adminDetail, page:()=>AdminDetailPage()),
    GetPage(name: adminTambahBuku, page:()=>AdminTambahBukuPage()),
    GetPage(name: userKeranjang, page:()=>UserKeranjangPage()),
  ];
}