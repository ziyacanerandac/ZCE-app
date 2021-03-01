import 'package:zce/models/categori_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category=new List<CategoryModel>();
  //1
  CategoryModel categoryModel=new CategoryModel();
  categoryModel.categorname="Busniess";
  categoryModel.imageUrl="images/busniess.jpg";
  category.add(categoryModel);

  //2
  categoryModel=new CategoryModel();
  categoryModel.categorname = "Entertainment";
  categoryModel.imageUrl = "images/entertainment.jpg";
  category.add(categoryModel);

  //3
  categoryModel = new CategoryModel();
  categoryModel.categorname = "General";
  categoryModel.imageUrl = "images/general.jpg";
  category.add(categoryModel);

  //4
  categoryModel = new CategoryModel();
  categoryModel.categorname = "Health";
  categoryModel.imageUrl = "images/health.jpg";
  category.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categorname = "Science";
  categoryModel.imageUrl = "images/science.jpg";
  category.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categorname = "Sports";
  categoryModel.imageUrl = "images/sports.jpg";
  category.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categorname = "Technology";
  categoryModel.imageUrl = "images/technology.jpg";
  category.add(categoryModel);

  return category;
}