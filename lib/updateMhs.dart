import 'package:api_app/Component/dataMhs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateMhs extends StatefulWidget {
  final dataMhs data;
  const updateMhs({super.key, required this.data});

  @override
  State<updateMhs> createState() => _updateMhsState(data);
}

class _updateMhsState extends State<updateMhs> {
  final dataMhs data;
  _updateMhsState(this.data);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = data.nama;
    _nimController.text = data.npm;
    _addressController.text = data.alamat;
  }

  Future<void> _submitData() async {
    String name = _nameController.text;
    String nim = _nimController.text;
    String address = _addressController.text;

    var url = Uri.parse('http://127.0.0.1/index.php');
    var response = await http.post(
      url,
      body: {
        'id': data.id.toString(),
        'nama': name,
        'npm': nim,
        'alamat': address,
        '_METHOD': "PUT",
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Data submitted successfully');
      Navigator.of(context).pop(true); // Return true to indicate success
    } else {
      // Handle error response
      print('Failed to submit data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 0, 70),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Return false to indicate cancellation
          },
        ),
        title: const Center(
          child: Text(
            'Tambah Mahasiswa',
          ),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nimController,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('Update Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
