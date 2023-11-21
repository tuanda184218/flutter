import 'package:wallpaper_app/model/categories_model.dart';

String apiKEY = "AiwFva1BmQjCRDjxy67jXstxKKNXzLYXEi1WUVkBrU2BDfCpB9IG5vlC";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];

  CategoriesModel categorieModel = CategoriesModel(
    categoriesName: "Street Art",
    imgUrl:
        "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  );
  categories.add(categorieModel);

  categorieModel = CategoriesModel(
    categoriesName: "Wild Life",
    imgUrl:
        "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  );
  categories.add(categorieModel);

  categorieModel = CategoriesModel(
    categoriesName: "Nature",
    imgUrl:
        "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  );
  categories.add(categorieModel);

  categorieModel = CategoriesModel(
    categoriesName: "City",
    imgUrl:
        "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  );
  categories.add(categorieModel);

  categorieModel = CategoriesModel(
    categoriesName: "Motivation",
    imgUrl:
        "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
  );
  categories.add(categorieModel);

  categorieModel = CategoriesModel(
    categoriesName: "Bikes",
    imgUrl:
        "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  );
  categories.add(categorieModel);

  categorieModel = CategoriesModel(
    categoriesName: "Cars",
    imgUrl:
        "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
  );
  categories.add(categorieModel);

  return categories;
}
