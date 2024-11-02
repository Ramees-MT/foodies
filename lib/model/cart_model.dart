class Cart {
  int? id;
  String? itemname;
  String? itemid;
  String? userid;
  int? quantity;
  int? cartStatus;
  String? itemprice;
  String? itemimage;

  Cart({
    this.id,
    this.itemname,
    this.itemid,
    this.userid,
    this.quantity,
    this.cartStatus,
    this.itemprice,
    this.itemimage,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemname = json['itemname'];
    itemid = json['itemid'];
    userid = json['userid'];
    // Ensure quantity is parsed as int
    quantity = json['quantity'] is int ? json['quantity'] : int.tryParse(json['quantity'].toString()) ?? 0;
    cartStatus = json['cart_status'];
    itemprice = json['itemprice'];
    itemimage = json['itemimage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemname': itemname,
      'itemid': itemid,
      'userid': userid,
      'quantity': quantity,
      'cart_status': cartStatus,
      'itemprice': itemprice,
      'itemimage': itemimage,
    };
  }
}
