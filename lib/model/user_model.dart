import 'dart:convert';

class UserModel {
  String? id;
  String? uuid;
  int? role;
  String? photoProfile;
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
  String? kecamatan = null;
  String? kelurahan = null;
  String? rt = null;
  String? rw = null;
  late String statusPerkawinan;
  late String agama;

  UserModel({
    this.id,
    this.uuid,
    this.role,
    this.photoProfile,
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
    required this.isOrder,
    this.kecamatan,
    this.kelurahan,
    this.rt,
    this.rw,
    required this.statusPerkawinan,
    required this.agama,
  });

  factory UserModel.fromjson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      uuid: json['uuid'],
      role: json['role'],
      photoProfile: json['photoProfile'],
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
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      rt: json['rt'],
      rw: json['rw'],
      statusPerkawinan: json['statusPerkawinan'],
      agama: json['agama'],
    );
  }

  factory UserModel.fromjsonWithId(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      uuid: json['uuid'],
      role: json['role'],
      kota: json['kota'],
      photoProfile: json['photoProfile'],
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
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      rt: json['rt'],
      rw: json['rw'],
      statusPerkawinan: json['statusPerkawinan'],
      agama: json['agama'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'photoProfile': photoProfile,
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
    'kecamatan': kecamatan,
    'kelurahan': kelurahan,
    'rt': rt,
    'rw': rw,
    'statusPerkawinan': statusPerkawinan,
    'agama': agama,
  };

}
