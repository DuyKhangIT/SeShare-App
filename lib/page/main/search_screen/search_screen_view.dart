import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/search_screen/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return GetBuilder<SearchController>(
        builder: (controller) => Center(
              child: Text('Search Screen'),
            ));
  }
}
