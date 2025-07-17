class AddressModel {
  final String id;
  final String addressLabel;
  final String deliveryInstructions;
  final String name;
  final String phoneCode;
  final String phone;
  final String street;
  final String zipCode;
  final String city;
  final String state;
  final String country;
  bool isDefault;

  AddressModel({
    required this.id,
    required this.addressLabel,
    required this.deliveryInstructions,
    required this.name,
    required this.phoneCode,
    required this.phone,
    required this.street,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.country,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      addressLabel: json['addressLabel'],
      deliveryInstructions: json['deliveryInstructions'],
      name: json['name'],
      phoneCode: json['phoneCode'],
      phone: json['phone'],
      street: json['street'],
      zipCode: json['zipCode'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      isDefault: json['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addressLabel': addressLabel,
      'deliveryInstructions': deliveryInstructions,
      'name': name,
      'phoneCode': phoneCode,
      'phone': phone,
      'street': street,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'country': country,
      'isDefault': isDefault,
    };
  }

  @override
  String toString() {
    return 'Address(addressLabel: $addressLabel, deliveryInstructions: $deliveryInstructions, name: $name, phoneCode: $phoneCode, phone: $phone, street: $street, zipCode: $zipCode, city: $city, state: $state, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddressModel &&
        other.addressLabel == addressLabel &&
        other.deliveryInstructions == deliveryInstructions &&
        other.name == name &&
        other.phoneCode == phoneCode &&
        other.phone == phone &&
        other.street == street &&
        other.zipCode == zipCode &&
        other.city == city &&
        other.state == state &&
        other.country == country;
  }

  @override
  int get hashCode {
    return addressLabel.hashCode ^
        deliveryInstructions.hashCode ^
        name.hashCode ^
        phoneCode.hashCode ^
        phone.hashCode ^
        street.hashCode ^
        zipCode.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode;
  }

  AddressModel copyWith({
    String? id,
    String? addressLabel,
    String? deliveryInstructions,
    String? name,
    String? phoneCode,
    String? phone,
    String? street,
    String? zipCode,
    String? city,
    String? state,
    String? country,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      addressLabel: addressLabel ?? this.addressLabel,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      name: name ?? this.name,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
