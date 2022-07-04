import 'dart:convert';

class UserModel {
  String? id;
  int? role;
  late String password;
  late String email;
  late String jenisIdentitas;
  late String nomorIdentitas;
  late DateTime tanggalLahir;
  late String namaLengkap;
  late String tempatLahir;
  late String alamat;
  late String provinsi;
  late String kota;
  late bool isOrder;

  UserModel({
    this.id,
    this.role,
    required this.kota,
    required this.provinsi,
    required this.alamat,
    required this.tempatLahir,
    required this.namaLengkap,
    required this.tanggalLahir,
    required this.nomorIdentitas,
    required this.password,
    required this.email,
    required this.jenisIdentitas,
    required this.isOrder
  });

  factory UserModel.fromjson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      role: json['role'],
      kota: json['kota'],
      provinsi: json['provinsi'],
      alamat: json['alamat'],
      tempatLahir: json['tempatLahir'],
      namaLengkap: json['namaLengkap'],
      tanggalLahir: DateTime.parse(json['tanggalLahir']),
      nomorIdentitas: json['nomorIdentitas'],
      password: '',
      email: json['email'],
      jenisIdentitas: json['jenisIdentitas'],
      isOrder: json['isOrder'],
    );
  }

  factory UserModel.fromjsonWithId(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: json['role'],
      kota: json['kota'],
      provinsi: json['provinsi'],
      alamat: json['alamat'],
      tempatLahir: json['tempatLahir'],
      namaLengkap: json['namaLengkap'],
      tanggalLahir: DateTime.parse(json['tanggalLahir']),
      nomorIdentitas: json['nomorIdentitas'],
      password: '',
      email: json['email'],
      jenisIdentitas: json['jenisIdentitas'],
      isOrder: json['isOrder'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'kota': kota,
    'provinsi': provinsi,
    'alamat': alamat,
    'tempatLahir': tempatLahir,
    'namaLengkap': namaLengkap,
    'tanggalLahir': tanggalLahir.toIso8601String(),
    'nomorIdentitas': nomorIdentitas,
    'email': email,
    'jenisIdentitas': jenisIdentitas,
    'isOrder': isOrder,
  };

}
