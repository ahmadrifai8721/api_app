import 'package:api_app/Component/dataMhs.dart';
import 'package:api_app/Component/list_content.dart';
import 'package:api_app/addMhs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Manajemen Mahasiswa',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Manajemen Mahasiswa Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dataMhs>> futuredataMhs;

  @override
  void initState() {
    super.initState();
    futuredataMhs = fetchDataMhs();
  }

  Future<void> _refreshData() async {
    setState(() {
      futuredataMhs = fetchDataMhs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 26, 155),
        title: Center(
          child: Text(
            widget.title,
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<dataMhs>>(
          future: futuredataMhs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return list_content(index, data);
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addMhs()),
          );
          if (result == true) {
            _refreshData();
          }
        },
        tooltip: 'Tambah Data',
        backgroundColor: const Color.fromARGB(255, 0, 26, 115),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
