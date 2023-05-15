import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/home_screen/create_story/creat_story_controller.dart';

import '../../../../util/global.dart';
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
                leading: GestureDetector(
                  onTap: () {
                    createStoryController.avatar = null;
                    createStoryController.textStory = "";
                    createStoryController.inputTextStoryController.text = "";
                    createStoryController.addText = false;
                    createStoryController.addColor = false;
                    createStoryController.isScale = false;
                    createStoryController.colorValue = "0xffffffff";
                    createStoryController.update();
                    Get.to(() => NavigationBarView(
                          currentIndex: 0,
                        ));
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
                actions: [
                  GestureDetector(
                    onTap: () {
                      if (Global.isAvailableToClick()) {}
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                ],
                elevation: 0,
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    /// list photo of user post
                    (createStoryController.avatar != null)
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image.file(
                              createStoryController.avatar!,
                              fit: BoxFit.cover,
                            ))
                        : const SizedBox(),

                    /// scale text
                    createStoryController.isScale == true
                        ? Positioned(
                            top: 60,
                            left: 90,
                            child: Slider(
                              inactiveColor: Colors.white,
                              activeColor: Colors.black,
                              thumbColor: Colors.black,
                              value: createStoryController.scaleValue,
                              min: 0.5,
                              max: 10.0,
                              onChanged: (value) {
                                createStoryController.scaleValue = value;
                                createStoryController.update();
                              },
                            ),
                          )
                        : Container(),

                    /// text
                    createStoryController.avatar != null &&
                            createStoryController.addText == true
                        ? Positioned(
                            left: createStoryController.xPosition,
                            top: createStoryController.yPosition,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                createStoryController.xPosition +=
                                    details.delta.dx;
                                createStoryController.yPosition +=
                                    details.delta.dy;
                                createStoryController.update();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(top: 200),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        14 * createStoryController.scaleValue,
                                    color: Color(int.parse(
                                        createStoryController.colorValue)),
                                  ),
                                  autofocus: true,
                                  maxLines: null,
                                  controller: createStoryController
                                      .inputTextStoryController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    counterText: '',
                                  ),
                                  onChanged: (value) {
                                    createStoryController.textStory = value;
                                    createStoryController.update();
                                  },
                                ),
                              ),
                            ),
                          )
                        : Container(),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// add image
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
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(11),
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Image.asset(IconsAssets.icAddImage,
                                    fit: BoxFit.cover, color: Colors.white),
                              )),

                          /// add text
                          GestureDetector(
                              onTap: () {
                                if (createStoryController.avatar != null) {
                                  createStoryController.addText =
                                      !createStoryController.addText;
                                  if (createStoryController.addText == false) {
                                    createStoryController.textStory = "";
                                    createStoryController
                                        .inputTextStoryController.text = "";
                                    createStoryController.scaleValue = 2.0;
                                    createStoryController.isScale = false;
                                    createStoryController.colorValue =
                                        "0xffffffff";
                                    createStoryController.update();
                                  }
                                  createStoryController.update();
                                }else{
                                  debugPrint("Bạn chưa thêm ảnh");
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(right: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Image.asset(
                                    (createStoryController.addText == true)
                                        ? IconsAssets.icBanText
                                        : IconsAssets.icAddText,
                                    color: Colors.white),
                              )),

                          /// scale text
                          GestureDetector(
                              onTap: () {
                                if (createStoryController
                                    .inputTextStoryController.text.isNotEmpty) {
                                  createStoryController.isScale =
                                      !createStoryController.isScale;
                                  createStoryController.update();
                                }else{
                                  debugPrint("Bạn chưa nhập chữ");
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(right: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12)),
                                child:
                                createStoryController.isScale == true
                                ?Image.asset(IconsAssets.icScaleText,
                                    color: Colors.blue)
                                :Image.asset(IconsAssets.icScaleText,
                                    color: Colors.white),
                              )),

                          /// add color text
                          GestureDetector(
                              onTap: () {
                                if(createStoryController.inputTextStoryController.text.isNotEmpty){
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return detailBottomSheetAddColor(
                                            createStoryController);
                                      });
                                }else{
                                  debugPrint("Bạn chưa nhập chữ");
                                }

                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(right: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Image.asset(IconsAssets.icFullColor),
                              )),
                        ],
                      ),
                    ),
                  ],
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
              GestureDetector(
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
              GestureDetector(
                  onTap: () {
                    createStoryController.getImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chọn ảnh từ thư viện".toUpperCase(),
                          style: const TextStyle(
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
            padding: const EdgeInsets.only(bottom: 34, left: 34, right: 34),
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
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: const TextStyle(
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

  Widget detailBottomSheetAddColor(
      CreateStoryController createStoryController) {
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    createStoryController.colorValue = "0xffffffff";
                    debugPrint(createStoryController.colorValue);
                    createStoryController.update();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.white,
                  )),
              GestureDetector(
                  onTap: () {
                    createStoryController.colorValue = "0xffffeb3b";
                    debugPrint(createStoryController.colorValue);
                    createStoryController.update();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.yellow,
                  )),
              GestureDetector(
                  onTap: () {
                    createStoryController.colorValue = "0xff69f0ae";
                    debugPrint(createStoryController.colorValue);
                    createStoryController.update();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.greenAccent,
                  )),
              GestureDetector(
                  onTap: () {
                    createStoryController.colorValue = "0xff000000";
                    debugPrint(createStoryController.colorValue);
                    createStoryController.update();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.black,
                  )),
            ],
          ),
        ),

        /// BUTTON CANCEL
        Padding(
            padding: const EdgeInsets.only(bottom: 34, left: 34, right: 34),
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
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: const TextStyle(
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
}
