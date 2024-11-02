class Offers {
  int? id;
  String? itemname;
  String? itemimage;
  String? offerdetails;

  Offers({this.id, this.itemname, this.itemimage, this.offerdetails});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemname = json['itemname'];
    itemimage = json['itemimage'];
    offerdetails = json['offerdetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemname'] = this.itemname;
    data['itemimage'] = this.itemimage;
    data['offerdetails'] = this.offerdetails;
    return data;
  }
}
