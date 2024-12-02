import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/profile_screen/qr_code_screen/qr_code_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../util/global.dart';

class QRCodeScreen extends StatefulWidget {
 const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    QRCodeController qrCodeController = Get.put(QRCodeController());
    return GetBuilder<QRCodeController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close,
                      color: Theme.of(context).textTheme.headlineMedium?.color),
                ),
                title: Text(
                  "Mã QR của bạn",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito Sans',
                        color: Theme.of(context).textTheme.headlineMedium?.color)
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.imgBgQRScreen),
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// QR
                  Screenshot(
                    controller: qrCodeController.screenShotController,
                    child: Container(
                      width: 300,
                      height: 300,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.fromLTRB(35,35,35,0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black,offset: Offset.zero)
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            alignment: Alignment.center,
                            child: QrImage(
                              size: 200,
                              data: Global.userProfileResponse!.id,
                              version: QrVersions.auto,
                              foregroundColor: Colors.blue.withOpacity(0.6),
                            ),
                          ),
                          Container(
                            width: 300,
                            alignment: Alignment.center,
                            child: Text("#${Global.userProfileResponse!.fullName}",style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 26,
                                fontFamily: 'Nunito Sans',
                                color: Colors.blue.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic
                            )),
                          ),
                          Container(
                            width: 300,
                            alignment: Alignment.bottomRight,
                            child: const Text("seShare",style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 11,
                                fontFamily: 'Nunito Sans',
                                color: Colors.black,
                                fontStyle: FontStyle.italic
                            )),
                          )
                        ],
                      ),
                    ),
                  ),

                    /// share and copy link profile
                    Container(
                      width: 300,
                      padding: const EdgeInsets.fromLTRB(10,20,10,0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black,offset: Offset.zero)
                          ]
                      ),
                      child: GestureDetector(
                        onTap: (){
                          if(Global.isAvailableToClick()){
                            qrCodeController.screenShotController.capture().then((Uint8List? image) async {

                              //Capture Done
                              qrCodeController.imageFile = image;

                              Directory tempDir = await getTemporaryDirectory();

                              File tempFile = await File('${tempDir.path}/QR.png').create();

                              await tempFile.writeAsBytes(qrCodeController.imageFile!);

                              qrCodeController.qrFilePath = tempFile.path;

                              debugPrint(qrCodeController.qrFilePath);

                            }).catchError((onError) {
                              debugPrint(onError);
                            });
                          }
                          if(qrCodeController.qrFilePath.isNotEmpty){
                            Share.shareFiles([(qrCodeController.qrFilePath)]);
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black.withOpacity(0.2))
                              ),
                              child: Image.asset(IconsAssets.icShare),
                            ),
                            const SizedBox(
                              width: 200,
                              height: 50,
                              child: Text("Chia sẻ trang cá nhân",style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],),
              )),
            ));
  }
}
