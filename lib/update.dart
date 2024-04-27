import 'package:crud_sqflite/database_instance.dart';
import 'package:crud_sqflite/product_model.dart';
import 'package:flutter/material.dart';

class UpdateDb extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateDb({super.key, this.productModel});

  @override
  State<UpdateDb> createState() => _UpdateDbState();
}

class _UpdateDbState extends State<UpdateDb> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    nameController.text = widget.productModel!.name ?? '';
    categoryController.text = widget.productModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Halaman Update'),
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
                await databaseInstance.update(widget.productModel!.id!, {
                  'name': nameController.text,
                  'category': categoryController.text,
                  'updated_at': DateTime.now().toString()
                });
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('SUBMIT'))
        ]),
      ),
    );
  }
}
