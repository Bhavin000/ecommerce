import 'package:ecommerce/src/data/models/item_model.dart';
import 'package:ecommerce/src/data/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late FirebaseRepo firebaseRepo;
  late GlobalKey<FormBuilderState> _formkey;
  late String? imageUrl;

  @override
  void initState() {
    firebaseRepo = FirebaseRepo();
    _formkey = GlobalKey<FormBuilderState>();
    imageUrl = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add item'),
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formkey,
          child: Column(
            children: [
              textField('title', 'text'),
              textField('description', 'text'),
              textField('price', 'number'),
              ElevatedButton(
                onPressed: () {
                  firebaseRepo.addImage().then((value) {
                    if (value != null) {
                      imageUrl = value;
                    }
                  });
                },
                child: const Text('Add image'),
              ),
              ElevatedButton(
                onPressed: () {
                  _formkey.currentState!.save();
                  var data = _formkey.currentState!.value;
                  var result = ItemModel(
                    title: data['title'],
                    price: data['price'],
                    description: data['description'],
                    imageUrl: imageUrl!,
                    createdBy: firebaseRepo.getCurrentUserId,
                  );
                  firebaseRepo.addItem(result);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String label, String type) {
    return FormBuilderTextField(
      name: label,
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: type == 'text' ? TextInputType.text : TextInputType.number,
    );
  }
}
