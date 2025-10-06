import 'package:cloudinary_public/cloudinary_public.dart';

class CategoryController {
  uploadCategory({required dynamic pickedImage, required dynamic pickedBanner}) async {
    try{
      final cloudinary = CloudinaryPublic("dmrnwy6te", "xs4u9qyv");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage',folder: 'categoryImages')
      );

      print(imageResponse);

      CloudinaryResponse bennerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner, identifier: 'pickedBanner',folder: 'categoryImages')
      );

      print(bennerResponse);
    }catch(e){
      print('Error uploading to cloudinary: $e');
    }
  }
}
