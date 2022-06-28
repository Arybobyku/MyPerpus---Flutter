import 'package:flutter/material.dart';
import 'package:my_perpus/ui/widget/button_rounded.dart';

class UserDetailBukuPage extends StatelessWidget {
  const UserDetailBukuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://edit.org/images/cat/book-covers-big-2019101610.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ini Merupakan judul buku fdsaf a fdasf da fs sa",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text("Pengarang",style: TextStyle(fontSize: 16),),
                                SizedBox(height: 10),
                                Text("Penerbit",style: TextStyle(fontSize: 16),),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Tahun Terbit",style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              ButtonRounded(text: "Tambah Buku")
            ],
          ),
        ),
      ),
    );
  }
}
