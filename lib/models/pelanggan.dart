class Pelanggan {
  final int id;
  final String nama, alamat, kota, provinsi, kodepos, telp, email, foto;

  Pelanggan(
      {this.id,
      this.nama,
      this.alamat,
      this.kota,
      this.provinsi,
      this.kodepos,
      this.telp,
      this.email,
      this.foto});
  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: json['id'] as int,
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
      kota: json['kota'] as String,
      provinsi: json['provinsi'] as String,
      kodepos: json['kodepos'] as String,
      telp: json['telp'] as String,
      email: json['email'] as String,
      foto: json['foto'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = id;
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['kota'] = kota;
    map['provinsi'] = provinsi;
    map['kodepos'] = kodepos;
    map['telp'] = telp;
    map['email'] = email;
    map['foto'] = foto;
    return map;
  }
}
