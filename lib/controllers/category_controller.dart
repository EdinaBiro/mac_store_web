import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:mac_store_web/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_web/global_variables.dart';
import 'package:mac_store_web/services/manage_http_response.dart';

class CategoryController {
  uploadCategory({required dynamic pickedImage, required dynamic pickedBanner, required String name, required context}) async {
    try{
      final cloudinary = CloudinaryPublic("dmrnwy6te", "xs4u9qyv");
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'categoryImages')
      );
      String image = imageResponse.secureUrl;
      
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner, identifier: 'pickedBanner', folder: 'categoryImages')
      );
      String banner = bannerResponse.secureUrl;
      
      Category category = Category(id: "", name: name, image: image, banner: banner);
      
      http.Response response= await http.post(
        Uri.parse("$uri/api/categories"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: category.toJson(),
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Uploaded category');
      });
    } catch(e) {
      print('Error uploading to cloudinary: $e');
    }
  }
  Future<List<Category>> _loadCategories() async{
    try{
        http.Response response = await http.get(Uri.parse('$uri/api/caregories'),
         headers: {
          'Content-Type': 'application/json',
        },
        );
        print(response.body);
        if(response.statusCode==200){
          final List<dynamic> data = jsonDecode(response.body);
          List<Category> categories = data.map((category) => Category.fromJson(category)).toList();
        return categories;
        }else{
          throw Exception('Failed to load categories');
        }
        
    }catch(e){
      throw Exception("Error loading categories: $e");
    }
  }
}