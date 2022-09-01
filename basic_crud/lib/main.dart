import 'package:basic_crud/create.dart';
import 'package:basic_crud/product_model.dart';
import 'package:basic_crud/update.dart';
import 'package:flutter/material.dart';

import 'database_instance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
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

  Future delete(int id) async {
    await databaseInstance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Simple App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return const CreateScreen();
                })).then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null
            ? FutureBuilder<List<ProductModel>>(
                future: databaseInstance!.all(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Null Data"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name ?? ''),
                            subtitle:
                                Text(snapshot.data![index].category ?? ''),
                            leading: IconButton(
                              onPressed: () {
                                delete(snapshot.data![index].id!);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return UpdateScreen(
                                    productModel: snapshot.data![index],
                                  );
                                })).then((value) {
                                  setState(() {});
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          );
                        });
                  } else {
                    print(snapshot.error);
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),
      ),
    );
  }
}
