class Menu {
  final int? menuID;
  final int? restaurateurID;
  final String? name;
  final int? price;
  final String? details;
  final String? category;
  final String? picture;

  Menu({
    this.menuID,
    this.restaurateurID,
    this.name,
    this.price,
    this.details,
    this.category,
    this.picture,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuID: json['MenuID'],
      restaurateurID: json['RestaurateurID'],
      name: json['Name'],
      price: json['Price'],
      details: json['Details'],
      category: json['Category'],
      picture: json['Picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MenuID': menuID,
      'RestaurateurID': restaurateurID,
      'Name': name,
      'Price': price,
      'Details': details,
      'Category': category,
      'Picture': picture,
    };
  }
}