import 'package:my_perpus/model/buku_model.dart';
import 'package:my_perpus/model/user_model.dart';

class PeminjamanModel {
  String? id;
  String idUser;
  BukuModel bukuModel;
  UserModel userModel;
  int status;
  DateTime? tanggalPeminjaman;
  DateTime? tanggalPengembalian;

  PeminjamanModel({
    this.id,
    required this.idUser,
    required this.bukuModel,
    required this.userModel,
    required this.status,
    this.tanggalPeminjaman,
    this.tanggalPengembalian,
  });

  factory PeminjamanModel.fromjson(Map<String, dynamic> json, String id) {
    var jsonTglPeminjaman = json['tanggalPeminjaman'];
    var jsonTglPengembalian = json['tanggalPengembalian'];
    return PeminjamanModel(
      id: id,
      bukuModel: BukuModel.fromjsonWithId(json['bukuModel']),
      userModel: UserModel.fromjsonWithId(json['userModel']),
      idUser: json['idUser'],
      status: json['status'],
      tanggalPeminjaman: jsonTglPeminjaman.toDate(),
      tanggalPengembalian: jsonTglPengembalian.toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'idUser': idUser,
    'bukuModel': bukuModel,
    'userModel': userModel,
    'status': status,
    'tanggalPeminjaman': tanggalPeminjaman,
    'tanggalPengembalian': tanggalPengembalian,
  };

}
