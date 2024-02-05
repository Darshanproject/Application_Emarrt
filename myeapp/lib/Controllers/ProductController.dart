import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myeapp/Model/Categoriey_model.dart';

class ProductController extends GetxController{

  var subcat=[];

  getSubCategories(title)async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/Services/Categorieyscreen.json");
    var decode = categoriesModelFromJson(data);
    var s= decode.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategories) {
      subcat.add(e);
    }
  }
}