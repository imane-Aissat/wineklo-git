class Menu {
   int? menuID;
   int restaurateurID;
   String? name;
   int? price;
   String? details;
   String?category;
   String? picture;

  Menu({
     this.menuID,
     required this.restaurateurID,
     this.name,
     this.price,
     this.details,
     this.category,
     this.picture,
  });

  // Convert JSON to Model
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

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'RestaurateurID': restaurateurID,
      'Name': name,
      'Price': price,
      'Details': details,
      'Category': category,
      'Picture': picture,
    };
  }
}
