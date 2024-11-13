class Address {
  int? id;
  String name;
  String street;
  String city;
  String state;
  String country;
  String postalCode;
  int? userid;

  Address({
    this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    this.userid,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postal_code'],
      userid: json['userid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'userid': userid,
    };
  }
}
