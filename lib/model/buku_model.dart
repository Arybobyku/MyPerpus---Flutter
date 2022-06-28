class BukuModel {
  String? id;
  String? gambar;
  String judul;
  String penerbit;
  String pengarang;
  String tahun;
  String jenis;

  BukuModel({
    this.id,
    this.gambar,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.jenis,
    required this.tahun,
  });
}
