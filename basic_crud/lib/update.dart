import 'package:basic_crud/database_instance.dart';
import 'package:basic_crud/product_model.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateScreen({Key? key, this.productModel}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    nameController.text = widget.productModel!.name ?? '';
    categoryController.text = widget.productModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
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
                  await databaseInstance.update(
                    widget.productModel!.id!,
                    {
                      'name': nameController.text,
                      'category': categoryController.text,
                      'updated_at': DateTime.now().toString()
                    },
                  );
                  Navigator.pop(context);
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
