import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:mac_store_web/global_variables.dart';
import 'package:mac_store_web/models/category.dart';
import 'package:mac_store_web/models/subcategory.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_web/services/manage_http_response.dart';

class SubcategoryController {
  uploadSubcategory({required String categoryId, required String categoryName,required dynamic pickedImage, required String subCategoryName,required context })async{
    try{
      final cloudinary = CloudinaryPublic("dmrnwy6te", "xs4u9qyv");
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'categoryImages'),
      );
      String image = imageResponse.secureUrl;
      Subcategory subcategory = Subcategory(id: '', categoryId: categoryId, categoryName: categoryName, image: image, subCategoryName: subCategoryName);

       http.Response response= await http.post(
        Uri.parse("$uri/api/subcategories"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: subcategory.toJson(),
      );

       manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Uploaded subCategory');
      });
    }catch(e){
      print("$e");
    }
  }

    Future<List<Subcategory>> loadSubcategories() async{
    try{
        http.Response response = await http.get(Uri.parse('$uri/api/subcategories'),
         headers: {
          'Content-Type': 'application/json',
        },
        );
        print(response.body);
        if(response.statusCode==200){
          final List<dynamic> data = jsonDecode(response.body);
          List<Subcategory> subcategories = data.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
        return subcategories;
        }else{
          throw Exception('Failed to load subcategories');
        }
        
    }catch(e){
      throw Exception("Error loading categories: $e");
    }
  }
}
