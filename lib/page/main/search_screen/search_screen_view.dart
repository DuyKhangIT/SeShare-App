import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/search_screen/action_search/action_search_view.dart';
import 'package:instagram_app/page/main/search_screen/search_controller.dart';

import '../../../assets/icons_assets.dart';
import '../../../util/global.dart';
import '../../../util/module.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return GetBuilder<SearchController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white,
                body: Padding(
                  padding: const EdgeInsets.only(bottom: 75),
                  child: Column(
                    children: [
                      _searchBox(context),
                      
                      Expanded(
                        child: StaggeredGridView.countBuilder(
                          staggeredTileBuilder: (index) => index % 7 == 0
                              ? const StaggeredTile.count(2, 2)
                              : const StaggeredTile.count(1, 1),
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          crossAxisCount: 3,
                          itemCount: Global.listPostInfo.length,
                          itemBuilder: (context, index) => contentGridView(context,index),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  /// search box
  Widget _searchBox(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => const ActionSearchScreen());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        margin: const EdgeInsets.fromLTRB(10,30,10,20),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.blueGrey.withOpacity(0.15),
        ),
        child: Row(
          children: const [
            Icon(Icons.search),
            SizedBox(width: 10),
            Text("Tìm kiếm...",style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans'))
          ],
        ),
      ),
    );
  }

  Widget contentGridView(context,index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ClipRect(
        child: getNetworkImage(
          Global.listPostInfo[index].photoPath![0],
        ),
      ),
    );
  }
}
