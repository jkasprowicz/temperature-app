import 'package:flutter/material.dart';
import 'models.dart';

class EnterTemperaturePage extends StatefulWidget {
  final List<Item> items;

  EnterTemperaturePage({required this.items});

  @override
  _EnterTemperaturePageState createState() => _EnterTemperaturePageState();
}

class _EnterTemperaturePageState extends State<EnterTemperaturePage> {
  List<Map<String, dynamic>> temperatureEntries = [];

  void addTemperatureEntry() {
    setState(() {
      // Initialize a new entry with nulls for Item and empty text controllers
      temperatureEntries.add({
        'item': null,
        'temperatureController': TextEditingController(),
        'minController': TextEditingController(),
        'maxController': TextEditingController(),
      });
    });
  }

  void submitAllTemperatures() {
    bool valid = true;

    // Collect all entries and validate
    for (var entry in temperatureEntries) {
      if (entry['item'] == null ||
          entry['temperatureController'].text.isEmpty ||
          entry['minController'].text.isEmpty ||
          entry['maxController'].text.isEmpty) {
        valid = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Por favor preencher todos os  campos!."),
        ));
        break;
      }
    }

    if (valid) {
      setState(() {
        for (var entry in temperatureEntries) {
          final selectedItem = entry['item'] as Item;
          final temperature = double.tryParse(entry['temperatureController'].text);
          final minTemp = double.tryParse(entry['minController'].text);
          final maxTemp = double.tryParse(entry['maxController'].text);

          if (temperature != null && minTemp != null && maxTemp != null) {
            selectedItem.addTemperature(temperature); // Register temperature in model
            // Add additional logic for min/max storage if needed
          }
        }
        temperatureEntries.clear(); // Clear entries after submission
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Temperaturas enviadas com sucesso!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: temperatureEntries.length,
              itemBuilder: (context, index) {
                final entry = temperatureEntries[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        DropdownButton<Item>(
                          hint: Text("Selecionar"),
                          value: entry['item'],
                          onChanged: (Item? newItem) {
                            setState(() {
                              entry['item'] = newItem;
                            });
                          },
                          items: widget.items.map((Item item) {
                            return DropdownMenuItem<Item>(
                              value: item,
                              child: Text('${item.name} - Code: ${item.code}'),
                            );
                          }).toList(),
                        ),
                        TextField(
                          controller: entry['temperatureController'],
                          decoration: InputDecoration(labelText: "Temperatura Atual"),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: entry['maxController'],
                          decoration: InputDecoration(labelText: "Temperatura Max"),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: entry['minController'],
                          decoration: InputDecoration(labelText: "Temperatura Min"),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addTemperatureEntry,
                  child: Text("Adicionar Campo"),
                ),
                ElevatedButton(
                  onPressed: submitAllTemperatures,
                  child: Text("Enviar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
