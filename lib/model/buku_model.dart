class BukuModel {
  String? id;
  String? gambar;
  bool? isAvailable;
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
    required this.isAvailable,
    required this.tahun,
  });

  factory BukuModel.fromjson(Map<String, dynamic> json, String id) {
    return BukuModel(
      id: id,
      gambar: json['gambar'],
      judul: json['judul'],
      penerbit: json['penerbit'],
      pengarang: json['pengarang'],
      isAvailable: json['isAvailable'],
      tahun: json['tahun'],
      jenis: json['jenis'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'gambar': gambar,
    'judul': judul,
    'penerbit': penerbit,
    'pengarang': pengarang,
    'tahun': tahun,
    'jenis': jenis,
    'isAvailable': isAvailable
  };

}
