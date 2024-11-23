// models.dart
class TemperatureRecord {
  final DateTime date;
  final double temperature;

  TemperatureRecord({required this.date, required this.temperature});
}

class Item {
  final String code;
  final String name;
  List<TemperatureRecord> temperatureRecords;

  Item({required this.code, required this.name}) : temperatureRecords = [];
  
  // Method to add a temperature record to the item
  void addTemperature(double temperature) {
    temperatureRecords.add(TemperatureRecord(date: DateTime.now(), temperature: temperature));
  }
}
