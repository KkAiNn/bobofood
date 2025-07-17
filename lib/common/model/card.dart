class CardModel {
  String? id;
  String? name;
  String? number;
  String? date;
  String? cvv;
  String? bank;
  bool? isDefault;

  CardModel({
    this.id,
    this.name,
    this.number,
    this.date,
    this.cvv,
    this.bank,
    this.isDefault,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      date: json['date'],
      cvv: json['cvv'],
      bank: json['bank'],
      isDefault: json['isDefault'],
    );
  }

  CardModel copyWith({
    String? id,
    String? name,
    String? number,
    String? date,
    String? cvv,
    String? bank,
    bool? isDefault,
  }) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      date: date ?? this.date,
      cvv: cvv ?? this.cvv,
      bank: bank ?? this.bank,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
