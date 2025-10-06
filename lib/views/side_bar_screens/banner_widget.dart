import 'package:flutter/material.dart';
import 'package:mac_store_web/controllers/banner_controller.dart';
import 'package:mac_store_web/models/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;
  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futureBanners, builder: (context, snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return CircularProgressIndicator();
      }else if(snapshot.hasError){
        return Center(child: Text("Error: ${snapshot.error}"),);
      }else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(child: Text('No banners'),);
      }else{
        final banners = snapshot.data!; 
        return GridView.builder(
          shrinkWrap: true,
          itemCount: banners.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6,crossAxisSpacing: 8, mainAxisSpacing: 8), 
          itemBuilder: (context, index){
            final banner = banners[index];
            return Image.network(
              banner.image,
              height: 100,
              width: 100,
            );
          });
      }
    });
  }
}