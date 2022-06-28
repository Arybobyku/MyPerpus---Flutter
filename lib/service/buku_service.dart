import 'package:cloud_firestore/cloud_firestore.dart';

class BukuService{
  final CollectionReference _bukuReference =
  FirebaseFirestore.instance.collection('Buku');


}