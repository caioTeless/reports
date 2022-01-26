class ObservationsModel {
  String? description;
  double? value;

  ObservationsModel({
    this.description,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'value': value,
    };
  }

  ObservationsModel getData(Map<String, dynamic> map) {
    final data = ObservationsModel(
      description: map['description'] ?? '',
      value: map['value'] ?? 0.0,
    );
    return data;
  }
}
