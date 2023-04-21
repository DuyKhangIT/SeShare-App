import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/search_screen/search_controller.dart';

import '../../../assets/icons_assets.dart';

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
                      _searchBox(searchController, context),
                      
                      Expanded(
                        child: StaggeredGridView.countBuilder(
                          staggeredTileBuilder: (index) => index % 7 == 0
                              ? const StaggeredTile.count(2, 2)
                              : const StaggeredTile.count(1, 1),
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          crossAxisCount: 3,
                          itemCount: 9,
                          itemBuilder: (context, index) => contentGridView(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  /// search box
  Widget _searchBox(SearchController controller, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      margin: const EdgeInsets.fromLTRB(10,30,10,10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.blueGrey.withOpacity(0.2),
      ),
      child: TextField(
        controller: controller.searchController,
        cursorColor: Colors.black,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w400,
            fontSize: 14),
        onChanged: (value) {
          controller.inputSearch = value;
          controller.update();

          //controller.updateSearch(value);
        },
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: (controller.searchController.text.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      child: Image.asset(
                        IconsAssets.icClearText,
                        width: 10,
                        height: 10,
                      ),
                      onTap: () {
                        controller.clearTextSearch();
                        //_controller.updateSearch("");
                      },
                    ),
                  )
                : null,
            hintText: 'Tìm kiếm...',
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.2),
                fontFamily: 'NunitoSans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            border: InputBorder.none),
      ),
    );
  }

  Widget contentGridView(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ClipRect(
        child: Image.asset(ImageAssets.imgTest, fit: BoxFit.cover),
      ),
    );
  }
}
