import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }
  Future<Map<String, dynamic>> loadMeals() {
    return BaseNetwork.get("filter.php?c=Seafood");
  }
  Future<Map<String, dynamic>> loadMakan() {
    return BaseNetwork.get("lookup.php?i=52772");
  }

  Future<Map<String, dynamic>> loadDetailCategories(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("categories.php/$id");
  }
  Future<Map<String, dynamic>> loadDetailMeals(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("filter.php?c=Seafood/$id");
  }
  Future<Map<String, dynamic>> loadDetailMakan(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("lookup.php?i=52772/$id");
  }
}