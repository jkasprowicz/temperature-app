import 'package:flutter/material.dart';
import 'models/temperature_record.dart';


class AddItemPage extends StatefulWidget {
  final Function(TemperatureRecord) onAddItem;

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
      widget.onAddItem(TemperatureRecord(
        code: code,
        name: name,
        date: DateTime.now(),
        temperature: 0.0,
      ));
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
