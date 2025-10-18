class AddressModel {
  final String id;
  final String street;
  final String city;
  final String phoneNumber;
  final String country;

  AddressModel({
    required this.id,
    required this.street,
    required this.city,
    required this.phoneNumber,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'phone_number': phoneNumber,
      'country': country,
    };
  }

  AddressModel copyWith({
    String? id,
    String? street,
    String? city,
    String? phoneNumber,
    String? country,
  }) {
    return AddressModel(
      id: id ?? this.id,
      street: street ?? this.street,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
    );
  }
}
