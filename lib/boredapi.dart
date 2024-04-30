// Import package flutter untuk pengembangan aplikasi mobile
import 'package:flutter/material.dart';
// Import package http untuk melakukan permintaan HTTP
import 'package:http/http.dart' as http;
// Import package dart:convert untuk mengonversi respons HTTP ke JSON
import 'dart:convert';

// Fungsi utama yang dijalankan ketika aplikasi dimulai
void main() {
  runApp(MyApp());
}

// Kelas MyApp, sebuah widget StatelessWidget yang merupakan akar dari aplikasi Flutter
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bored App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoredPage(),
    );
  }
}

// Kelas BoredPage, sebuah widget StatefulWidget yang menampilkan halaman utama aplikasi
class BoredPage extends StatefulWidget {
  @override
  _BoredPageState createState() => _BoredPageState();
}

// Kelas _BoredPageState, state dari BoredPage yang berisi logika aplikasi
class _BoredPageState extends State<BoredPage> {
  String activity = "";

  Future<void> fetchActivity() async {
    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity'));
    if (response.statusCode == 200) {
      setState(() {
        activity = jsonDecode(response.body)['activity'];
      });
    } else {
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bored App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Klik tombol untuk rekomendasi aktivitas:',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: fetchActivity,
              child: Text(
                'Rekomendasi',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              activity,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
