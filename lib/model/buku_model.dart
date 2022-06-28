class BukuModel{
  String? id;
  String? gambar;
  String judul;
  String pengarang;
  String penerbit;
  int stok;
  BukuModel({
    this.id,
    this.gambar,
    required this.judul,
    required this.penerbit,
    required this.pengarang,
    required this.stok
});
}