import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_perpus/model/buku_model.dart';

class BukuService {
  final CollectionReference _bukuReference =
      FirebaseFirestore.instance.collection('Buku');
  Reference ref = FirebaseStorage.instance.ref();

  Future<BukuModel> simpanGambar(BukuModel buku, File coverFile) async {
    try {

      final metadata = SettableMetadata(
        customMetadata: {'picked-file-path': coverFile.path},
      );

      String fileName =
          "${DateTime.now().millisecond}-${DateTime.now().minute}-${DateTime.now().hour}-${DateTime.now().day}-${DateTime.now().month}-buku";
      fileName = coverFile.path.split('/').last;
      var result = await ref.child(fileName).putFile(coverFile, metadata);
      result.ref.getDownloadURL();

      String path = await result.ref.getDownloadURL();
      print("MyPath"+path);
      buku.gambar = path;
      return buku;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setBuku(BukuModel bukuModel)async{
      try{
       await  _bukuReference.doc().set({
          'judul': bukuModel.judul,
          'penerbit': bukuModel.penerbit,
          'pengarang': bukuModel.pengarang,
          'tahun': bukuModel.tahun,
          'jenis': bukuModel.jenis,
          'gambar': bukuModel.gambar,
        });
      }catch(e){
        rethrow;
      }
  }
}
