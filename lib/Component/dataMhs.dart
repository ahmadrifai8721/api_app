import 'package:http/http.dart' as http;
import 'dart:convert';

class dataMhs {
  final String id;
  final String nama;
  final String npm;
  final String alamat;

  dataMhs({
    required this.id,
    required this.nama,
    required this.npm,
    required this.alamat,
  });

  factory dataMhs.fromJson(Map<String, dynamic> json) {
    return dataMhs(
      id: json['id'],
      nama: json['nama'],
      npm: json['npm'],
      alamat: json['alamat'],
    );
  }
}

Future<List<dataMhs>> fetchDataMhs() async {
  final response = await http.get(Uri.parse('http://127.0.0.1/index.php'));

  if (response.statusCode == 200) {
    // print(response.body);
    // print(jsonDecode(response.body)["result"]);
    List jsonResponse = json.decode(response.body)["result"];
    return jsonResponse.map((data) => dataMhs.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
