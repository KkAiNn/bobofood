import 'package:bobofood/common/model/address.dart';

class UserModel {
  final String name;
  final String email;
  final String avatarUrl;
  final String phoneCode;
  final String phone;
  final String birthDate;
  final String password;
  final String? token;
  final AddressModel? address;

  UserModel(
      {required this.name,
      required this.email,
      required this.avatarUrl,
      required this.phoneCode,
      required this.phone,
      required this.birthDate,
      required this.password,
      this.token,
      this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      phoneCode: json['phoneCode'],
      phone: json['phone'],
      birthDate: json['birthDate'],
      token: json['token'],
      password: json['password'],
      address: json['address'] != null
          ? AddressModel.fromJson(Map<String, dynamic>.from(json['address']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'phoneCode': phoneCode,
      'phone': phone,
      'birthDate': birthDate,
      'token': token,
      'password': password,
      'address': address?.toJson(),
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? phoneCode,
    String? phone,
    String? birthDate,
    String? password,
    AddressModel? address,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      password: password ?? this.password,
      address: address ?? this.address,
    );
  }
}
