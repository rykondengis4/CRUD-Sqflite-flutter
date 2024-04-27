import 'package:crud_sqflite/create.dart';
import 'package:crud_sqflite/database_instance.dart';
import 'package:crud_sqflite/product_model.dart';
import 'package:crud_sqflite/update.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'CRUD APP SQFLite'),
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
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future delete(id) async {
    await databaseInstance!.delete(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  _refresh();
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return CreatedDb();
                  })).then((value) {
                    if (value == true) {
                      _refresh();
                    }
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: databaseInstance != null
              ? FutureBuilder<List<ProductModel>>(
                  future: databaseInstance!.all(),
                  builder: (context, snapshot) {
                    if (snapshot.data!.length == 0) {
                      return Center(
                        child: Text(
                          'Data Masih Kosong',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name ?? ''),
                            subtitle:
                                Text(snapshot.data![index].category ?? ''),
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (builder) {
                                    return UpdateDb(
                                      productModel: snapshot.data![index],
                                    );
                                  }));
                                },
                                icon: Icon(Icons.edit)),
                            trailing: IconButton(
                                onPressed: () =>
                                    delete(snapshot.data![index].id!),
                                icon: Icon(Icons.delete)),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }
                  },
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
        ));
  }
}
