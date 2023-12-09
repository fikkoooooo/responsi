class Kategori {
  List<Categories>? categories;

  Kategori({
    required this.categories,
  });

  factory Kategori.fromJson(Map<String, dynamic> json){
    return Kategori(
        categories:
        (json['categories'] as List).map(( e) => Categories.fromJson(e)).toList(),
    );
  }
}

class Categories {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Categories({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Categories.fromJson(Map<String, dynamic> json){
    return Categories(
        idCategory : json['idCategory'],
        strCategory : json['strCategory'],
        strCategoryThumb : json['strCategoryThumb'],
        strCategoryDescription : json['strCategoryDescription'],
    );
  }

}