import 'dart:convert';

enum TransactionType {
  revenue,
  expense,
}

class TransactionModel {
  final String name;
  final TransactionType type;
  final double value;
  final DateTime? createdAt;

  TransactionModel({
    required this.name,
    required this.type,
    required this.value,
    this.createdAt,
  });

  TransactionModel copyWith({
    String? name,
    TransactionType? type,
    double? value,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.index,
      'value': value,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.initInstance() {
    return TransactionModel(
      name: '',
      type: TransactionType.revenue,
      value: 0.00,
      createdAt: DateTime.now(),
    );
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      name: map['name'] ?? '',
      type: TransactionType.values.elementAt(map['type'] ?? 0),
      value: map['value']?.toDouble() ?? 0.0,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) {
    return TransactionModel.fromMap(
      json.decode(source),
    );
  }

  @override
  String toString() {
    return 'TransactionModel{name: $name, type: ${type.index}, value: $value, createdAt: ${createdAt.toString()}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.name == name &&
        other.type == type &&
        other.value == value &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^ type.hashCode ^ value.hashCode ^ createdAt.hashCode;
  }
}
