class Category {
  int? id;
  String? categoryname;
  String? categoryimage;

  Category({this.id, this.categoryname, this.categoryimage});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryname = json['categoryname'];
    categoryimage = json['categoryimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryname'] = this.categoryname;
    data['categoryimage'] = this.categoryimage;
    return data;
  }
}