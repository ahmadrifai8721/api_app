import 'package:api_app/Component/dataMhs.dart';
import 'package:api_app/updateMhs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class list_content extends StatelessWidget {
  final dataMhs data;
  const list_content(int index, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => updateMhs(data: data),
          ),
        );
      },
      child: Expanded(
          child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.person,
                    size: 50, color: Color.fromARGB(255, 0, 26, 115))),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data.npm,
                  ),
                  Text(
                    data.alamat,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    // Add edit function here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => updateMhs(data: data),
                      ),
                    );
                  },
                  child: const Icon(Icons.edit, color: Colors.blue),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Confirmation'),
                          content: const Text(
                              'Are you sure you want to delete this data?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Add delete function here
                                var url =
                                    Uri.parse('http://127.0.0.1/index.php');
                                var response = await http.post(
                                  url,
                                  body: {
                                    'id': data.id.toString(),
                                    '_METHOD': "DELETE",
                                  },
                                );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.delete, color: Colors.red),
                )),
          ],
        ),
      )),
    );
  }
}
