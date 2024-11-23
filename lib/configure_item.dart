import 'package:flutter/material.dart';

class ConfigureItemPage extends StatefulWidget {
  @override
  _ConfigureItemPageState createState() => _ConfigureItemPageState();
}

class _ConfigureItemPageState extends State<ConfigureItemPage> {
  final _itemController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item Name (e.g., Freezer)'),
            ),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Code Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the item and code, and maybe navigate to the next page
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
