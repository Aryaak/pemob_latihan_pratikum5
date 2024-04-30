// Import library untuk JSON encoding dan decoding
import 'dart:convert';

void main() {
  // Membuat JSON string untuk data transkrip mahasiswa
  String jsonString = jsonEncode({
    "nama": "John Doe",
    "NIM": "1234567890",
    "program_studi": "Teknik Informatika",
    "mata_kuliah": [
      {"kode": "INF101", "nama": "Pemrograman Dasar", "sks": 3, "nilai": "A"},
      {"kode": "INF102", "nama": "Struktur Data", "sks": 4, "nilai": "B+"},
      {
        "kode": "INF103",
        "nama": "Algoritma dan Pemrograman",
        "sks": 4,
        "nilai": "A-"
      },
      {"kode": "INF104", "nama": "Basis Data", "sks": 3, "nilai": "C+"}
    ]
  });

  // Parsing JSON menjadi objek Dart
  Map<String, dynamic> data = jsonDecode(jsonString);
  List<dynamic> mataKuliah = data['mata_kuliah'];

  // Menghitung total SKS dan nilai bobot
  num totalSKS = 0;
  double totalBobot = 0.0;

  // Iterasi untuk setiap mata kuliah
  for (var matkul in mataKuliah) {
    totalSKS += matkul['sks'];
    totalBobot += _getBobotNilai(matkul['nilai']) * matkul['sks'];
  }

  // Menghitung IPK
  double ipk = totalBobot / totalSKS;

// Menampilkan hasil IPK
  print('IPK ${data['nama']} adalah: ${ipk.toStringAsFixed(2)}');
}

// Fungsi untuk mendapatkan bobot nilai berdasarkan nilai huruf
double _getBobotNilai(String nilai) {
  switch (nilai) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    case 'B':
      return 3.0;
    case 'B-':
      return 2.7;
    case 'C+':
      return 2.3;
    case 'C':
      return 2.0;
    case 'C-':
      return 1.7;
    case 'D':
      return 1.0;
    default:
      return 0.0;
  }
}
