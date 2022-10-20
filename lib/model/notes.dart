class Notes {
  int? id;
  String? judul;
  String? subjudul;
  String? tanggal;
  String? isi;

  Notes({this.id, this.judul, this.subjudul, this.tanggal, this.isi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['judul'] = judul;
    map['subjudul'] = subjudul;
    map['tanggal'] = tanggal;
    map['isi'] = isi;
    return map;
  }

  Notes.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.judul = map['judul'];
    this.subjudul = map['subjudul'];
    this.tanggal = map['tanggal'];
    this.isi = map['isi'];
  }
}
