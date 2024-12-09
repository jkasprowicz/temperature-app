import 'package:flutter/material.dart';
import 'temperature_record.dart';

class AddItemPage extends StatefulWidget {
  final Function(Item) onAddItem;

  AddItemPage({required this.onAddItem});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final codeController = TextEditingController();
  final nameController = TextEditingController();

  void addItem() {
    final code = codeController.text;
    final name = nameController.text;

    if (code.isNotEmpty && name.isNotEmpty) {
      widget.onAddItem(Item(code: code, name: name));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: "Código"),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nome do Item"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addItem,
              child: Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
