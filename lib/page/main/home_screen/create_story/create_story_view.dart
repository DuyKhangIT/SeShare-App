import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/home_screen/create_story/creat_story_controller.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../navigation_bar/navigation_bar_view.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({Key? key}) : super(key: key);

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  @override
  Widget build(BuildContext context) {
    CreateStoryController createStoryController =
        Get.put(CreateStoryController());
    return GetBuilder<CreateStoryController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                centerTitle: true,
                leading:
                GestureDetector(
                  onTap: (){
                    Get.to(() =>  NavigationBarView(currentIndex: 0,));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                title: Text(
                  "Tạo tin",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                elevation: 0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (createStoryController.avatar != null)
                          ? Image.file(createStoryController.avatar!)
                          : Container(),
                      // GridView.builder(
                      //     physics: const BouncingScrollPhysics(),
                      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 2
                      // ), itemBuilder: (context,index){
                      //
                      // }
                      // ),
                      listAlbumFromDevice(),
                      /// add image and changed address
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return detailBottomSheetAddImage(
                                            createStoryController);
                                      });
                                },
                                child: Image.asset(IconsAssets.icAddImage,
                                    color: Colors.blue, width: 30, height: 30)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget detailBottomSheetAddImage(createStoryController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 31, right: 31, bottom: 26),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    createStoryController.getImageFromCamera();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chụp ảnh".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),
              InkWell(
                  onTap: () {
                    createStoryController.getImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chọn ảnh từ thư viện".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
            ],
          ),
        ),

        /// BUTTON CANCEL
        Padding(
            padding: EdgeInsets.only(bottom: 34, left: 34, right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side: BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
            ))
      ],
    );
  }

  Widget listAlbumFromDevice(){
    CreateStoryController createStoryController = Get.put(CreateStoryController());

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: createStoryController.assetList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3
          ), itemBuilder: (context,index){
             AssetEntity assetEntity = createStoryController.assetList[index];
             return Padding(padding: EdgeInsets.all(2),
               child: assetWidget(assetEntity,createStoryController),

             );
          }),
          // Row(
          //   children: [
          //     DropdownButton<AssetPathEntity>(
          //       value: createStoryController.selectedAlbum,
          //       onChanged: (AssetPathEntity? value){
          //         createStoryController.selectedAlbum = value;
          //         createStoryController.update();
          //         createStoryController.loadAssets(createStoryController.selectedAlbum!).then((value) => {
          //           createStoryController.assetList = value,
          //           createStoryController.update()
          //         });
          //       },
          //       items: createStoryController.albumList.map<DropdownMenuItem<AssetPathEntity>>(
          //           (AssetPathEntity album){
          //             return DropdownMenuItem<AssetPathEntity>(
          //               value: album,
          //               child: Text(
          //                 "${album.name} (${album.assetCount})"),
          //             );
          //           }).toList(),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget assetWidget(AssetEntity assetEntity,CreateStoryController createStoryController){
    return Stack(
      children: [
        Positioned.fill(child: Padding(
          padding: EdgeInsets.all(
              createStoryController.selectedAssetList.contains(assetEntity) == true?15:0
          ),
          child: AssetEntityImage(
            assetEntity,
            isOriginal: false,
            thumbnailSize: const ThumbnailSize.square(250),
            fit: BoxFit.cover,
            errorBuilder: (context,errpr,stackTrace){
              return Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
          ),
        ))
      ],
    );
  }
}
