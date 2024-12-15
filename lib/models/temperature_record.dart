// lib/models/temperature_record.dart

class TemperatureRecord {
  final int? id;
  final String code;
  final String name;
  final DateTime date;
  final double temperature;

  TemperatureRecord({
    this.id,
    required this.code,
    required this.name,
    required this.date,
    required this.temperature,
  });

  // Convert a TemperatureRecord into a map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'date': date.toIso8601String(),
      'temperature': temperature,
    };
  }

  // Convert a Map into a TemperatureRecord
  factory TemperatureRecord.fromMap(Map<String, dynamic> map) {
    return TemperatureRecord(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      temperature: map['temperature'],
    );
  }
}
