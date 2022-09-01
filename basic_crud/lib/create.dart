import 'package:basic_crud/database_instance.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk'),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Kategori'),
            TextField(
              controller: categoryController,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.insert({
                    'name': nameController.text,
                    'category': categoryController.text,
                    'created_at': DateTime.now().toString(),
                    'updated_at': DateTime.now().toString()
                  });
                  Navigator.pop(context);
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
