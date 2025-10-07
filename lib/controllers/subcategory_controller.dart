import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:mac_store_web/global_variables.dart';
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
        Uri.parse("$uri/api/categories"),
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
}
