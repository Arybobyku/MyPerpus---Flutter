class UserModel {
  String? id;
  String? role;
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
  });
}
