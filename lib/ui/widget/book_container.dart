import 'package:flutter/material.dart';

class BookContainer extends StatelessWidget {
  const BookContainer({Key? key, this.imageHeight = 200,this.onTapBook}) : super(key: key);
  final double imageHeight;
  final Function()? onTapBook;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBook,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: imageHeight,
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
            SizedBox(height: 10),
            Text(
              "Judul Buku",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              "Pengarang",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
