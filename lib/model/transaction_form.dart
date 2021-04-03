part of "model.dart";

class TransactionForm{

  String name;
  String email;
  String telepon;
  String alamat;
  String produk;
  String jumlah;

  TransactionForm({
    required this.name,
    required this.email,
    required this.telepon,
    required this.alamat,
    required this.produk,
    required this.jumlah
  });
  
  factory TransactionForm.fromJson(dynamic json) {
    return TransactionForm(
      telepon: "${json['telepon']}",
      name: "${json['name']}",
      email: "${json['email']}",
      jumlah: "${json['jumlah']}",
      produk: "${json['produk']}",
      alamat: "${json['alamat']}"
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "name": name,
      "telepon": telepon,
      "alamat": alamat,
      "produk": produk,
      "jumlah": jumlah
    };
  }

  String toParams() => "?name=$name&email=$email&alamat=$alamat&telepon=$telepon&produk=$produk&jumlah=$jumlah";
}