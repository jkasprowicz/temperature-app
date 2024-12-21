// main.dart
import 'package:flutter/material.dart';
import 'models/temperature_record.dart';
import 'add_item.dart';
import 'enter_temperature.dart';
import 'view_temperatures.dart';

void main() {
  runApp(TemperatureApp());
}

class TemperatureApp extends StatelessWidget {
  final List<TemperatureRecord> items = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(items: items),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<TemperatureRecord> items;

  HomePage({required this.items});

  void addItem(TemperatureRecord item) {
    items.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TemperaturasApp")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SquareButton(
              icon: Icons.add_location,
              label: 'Adicionar locais',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemPage(onAddItem: addItem),
                  ),
                );
              },
            ),
            SquareButton(
              icon: Icons.thermostat,
              label: 'Registrar Temperaturas',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnterTemperaturePage(items: items),
                  ),
                );
              },
            ),
            SquareButton(
              icon: Icons.view_list,
              label: 'Verificar Temperaturas',
              onTap: () {
                // Before passing items to ViewTemperaturesPage, group them by code and name
                Map<String, TemperatureList> groupedItems = {};

                // Group records by code and name
                for (var record in items) {
                  String key = '${record.code}_${record.name}';
                  if (!groupedItems.containsKey(key)) {
                    groupedItems[key] = TemperatureList(
                      code: record.code,
                      name: record.name,
                      temperatureRecords: [],
                    );
                  }
                  groupedItems[key]!.temperatureRecords.add(record);
                }

                // Convert the map values to a list
                List<TemperatureList> groupedList = groupedItems.values.toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewTemperaturesPage(items: groupedList),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  SquareButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
