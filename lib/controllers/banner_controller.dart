import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_web/models/banner.dart';
import 'package:mac_store_web/services/manage_http_response.dart';

import '../global_variables.dart';

class BannerController {
  uploadBanner({required pickedImage, required context}) async {
    try{
      final cloudinary = CloudinaryPublic("dmrnwy6te", "xs4u9qyv");

      CloudinaryResponse imageResponse = await  cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'banners'),
      );

      String image = imageResponse.secureUrl;
      
      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(Uri.parse("$uri/api/banner"),
      body: bannerModel.toJson(),
      headers:  <String, String>{
          'Content-Type': 'application/json',
        },
      );
        manageHttpResponse(response: response, context: context, onSuccess: (){
          showSnackBar(context, 'Banner uploaded');
        });
      
    }catch(e){
      print(e);
    }
  }
    Future<List<BannerModel>> loadBanners() async{
      try{
        http.Response response = await http.get(Uri.parse("$uri/api/banners"), headers:<String, String>{
          'Content-Type': 'application/json',
        }, );
      print(response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners = data.map((banner) => BannerModel.fromJson(banner)).toList();return banners;
      }else{
        throw Exception('Failed to load banners');
      }
      }catch(e){
        throw Exception('Error loading banners $e');
      }
    }
}