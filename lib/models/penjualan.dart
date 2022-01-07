class Penjualan {
  final int id;
  final String nota, tanggal, harga, userid, st;
  Penjualan(
      {this.nota, this.tanggal, this.harga, this.userid, this.st, this.id});
  factory Penjualan.fromJson(Map<String, dynamic> json) {
    return Penjualan(
      id: json['id'] as int,
      nota: json['nota'] as String,
      tanggal: json['tanggal'] as String,
      harga: json['harga'] as String,
      userid: json['nota'] as String,
      st: json['st'] as String,
    );
  }
}
