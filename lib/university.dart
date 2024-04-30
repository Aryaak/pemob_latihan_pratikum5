// Mengimpor pustaka yang diperlukan
import 'package:flutter/material.dart'; // Pustaka untuk antarmuka pengguna Flutter
import 'dart:async'; // Untuk menangani operasi asinkron
import 'dart:convert'; // Untuk mengkodekan dan mendekodekan data JSON
import 'package:http/http.dart' as http; // Untuk membuat permintaan HTTP

// Fungsi utama untuk menjalankan aplikasi Flutter
void main() => runApp(MyApp());

// Kelas StatelessWidget untuk root dari aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indonesian Universities', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema warna utama
      ),
      home: UniversityList(), // Widget root dari aplikasi
    );
  }
}

// Kelas StatefulWidget untuk menyimpan status daftar universitas
class UniversityList extends StatefulWidget {
  @override
  _UniversityListState createState() => _UniversityListState();
}

// Kelas status untuk widget UniversityList
class _UniversityListState extends State<UniversityList> {
  List<dynamic> universities = []; // List untuk menyimpan data universitas

  // Fungsi untuk mengambil data dari API
  Future<void> fetchData() async {
    var result = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=Indonesia'));
    setState(() {
      universities = json.decode(result.body); // Mendekodekan respons JSON
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Mengambil data saat widget diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indonesian Universities'), // Judul bilah aplikasi
      ),
      body: ListView.builder(
        itemCount: universities.length, // Jumlah item dalam daftar
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            // ListTile untuk setiap universitas
            title: Text(universities[index]['name']), // Nama universitas
            subtitle: Text(
                'Website: ${universities[index]['web_pages'][0]}'), // Situs web universitas
          );
        },
      ),
    );
  }
}
