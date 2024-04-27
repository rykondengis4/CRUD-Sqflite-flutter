import 'package:crud_sqflite/database_instance.dart';
import 'package:flutter/material.dart';

class CreatedDb extends StatefulWidget {
  const CreatedDb({super.key});

  @override
  State<CreatedDb> createState() => _CreatedDbState();
}

class _CreatedDbState extends State<CreatedDb> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Halaman Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Text('Nama Produk'),
          TextField(
            controller: nameController,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Kategori'),
          TextField(
            controller: categoryController,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await databaseInstance.insert({
                  'name': nameController.text,
                  'category': categoryController.text,
                  'created_at': DateTime.now().toString(),
                  'updated_at': DateTime.now().toString()
                });
                Navigator.pop(context, true);
                setState(() {});
              },
              child: Text('SUBMIT'))
        ]),
      ),
    );
  }
}
