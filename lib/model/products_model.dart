class Product {
  int? id; // This could represent a unique identifier for the product.
  String? itemId; // New field for itemId
  String? itemname;
  String? itemprice; // Changed to double for numerical value
  String? itemdescription;
  String? itemimage;
  int? itemcategory;

  Product({
    this.id,
    this.itemId, // Include itemId in the constructor
    this.itemname,
    this.itemprice,
    this.itemdescription,
    this.itemimage,
    this.itemcategory,
  });

  // JSON deserialization
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId']; // Deserialize itemId
    itemname = json['itemname'];
    itemprice = json['itemprice']; // Ensure conversion to double
    itemdescription = json['itemdescription'];
    itemimage = json['itemimage'];
    itemcategory = json['itemcategory'];
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemId'] = this.itemId; // Serialize itemId
    data['itemname'] = this.itemname;
    data['itemprice'] = this.itemprice;
    data['itemdescription'] = this.itemdescription;
    data['itemimage'] = this.itemimage;
    data['itemcategory'] = this.itemcategory;
    return data;
  }

  @override
  String toString() {
    return 'Product{id: $id, itemId: $itemId, name: $itemname, price: $itemprice, description: $itemdescription, image: $itemimage, category: $itemcategory}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
