// class ProductCategoryModel {
//   String? name;
//   bool? isSelected = false;
//
//   ProductCategoryModel({this.name, this.isSelected});
// }

class ProductCategoryModel {
  final String name;
  bool? isSelected = false;

  ProductCategoryModel({required this.name, this.isSelected});

  factory ProductCategoryModel.fromJson(json, bool bool) {
    return ProductCategoryModel(name: json, isSelected: bool);
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['name'] = name;
  //   data['isSelected'] = isSelected;
  //   return data;
  // }
}
