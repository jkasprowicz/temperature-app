import 'package:flutter/material.dart';
import 'models/temperature_record.dart';
import 'package:intl/intl.dart';

class ViewTemperaturesPage extends StatefulWidget {
  final List<TemperatureRecord> items;

  ViewTemperaturesPage({required this.items});

  @override
  _ViewTemperaturesPageState createState() => _ViewTemperaturesPageState();
}

class _ViewTemperaturesPageState extends State<ViewTemperaturesPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  TemperatureRecord? _selectedItem;
  List<TemperatureRecord> _filteredItems = [];

  // Function to filter the items based on user input
  void _applyFilters() {
    setState(() {
      _filteredItems = widget.items.where((item) {
        // Filter by selected item
        if (_selectedItem != null && _selectedItem != item) return false;

        // Filter temperature records by date range
        final filteredRecords = item.temperatureRecords.where((record) {
          final recordDate = record.date;
          if (_startDate != null && recordDate.isBefore(_startDate!)) return false;
          if (_endDate != null && recordDate.isAfter(_endDate!)) return false;
          return true;
        }).toList();

        // Update the temperature records of the item
        item.temperatureRecords = filteredRecords;

        // Include the item only if it has temperature records in the selected range
        return filteredRecords.isNotEmpty;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Relatório Temperaturas")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date pickers for filtering
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) setState(() => _startDate = pickedDate);
                        },
                        child: Text(_startDate == null
                            ? "Data Inicial"
                            : "Start: ${DateFormat('yyyy-MM-dd').format(_startDate!)}"),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) setState(() => _endDate = pickedDate);
                        },
                        child: Text(_endDate == null
                            ? "Data Final"
                            : "End: ${DateFormat('yyyy-MM-dd').format(_endDate!)}"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16), // Add spacing
                // Centered dropdown and button
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<TemperatureRecord>(
                        hint: Text("Selecionar"),
                        value: _selectedItem,
                        onChanged: (TemperatureRecord? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                      items: widget.items.map((TemperatureRecord item) {
                        return DropdownMenuItem<TemperatureRecord>(
                          value: item,
                          child: Text('${item.name} - Code: ${item.code}'),
                        );
                      }).toList(),
                      ),
                      SizedBox(height: 16), // Spacing between dropdown and button
                      ElevatedButton(
                        onPressed: _applyFilters, // Apply the filters
                        child: Text("Aplicar filtro"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Display filtered items
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(child: Text("Sem Resultados"))
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ExpansionTile(
                        title: Text(item.name),
                        subtitle: Text("Code: ${item.code}"),
                        children: item.temperatureRecords.map((record) {
                          return ListTile(
                            title: Text("Temperature: ${record.temperature}°C"),
                            subtitle: Text("Date: ${DateFormat('yyyy-MM-dd').format(record.date)}"),
                          );
                        }).toList(),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
