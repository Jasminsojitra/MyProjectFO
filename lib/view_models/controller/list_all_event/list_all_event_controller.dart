import 'package:festum_evento/model/list_all_event/ListAllEventModel.dart';
import 'package:festum_evento/repository/list_all_event_repository/list_all_event_repository.dart';
import 'package:festum_evento/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListAllEventController extends GetxController{

  final _apis = ListAllEventRepository();

  final searchController = TextEditingController();

  List<Doc> allList = <Doc>[];
  int limit = 10;
  bool isLoadMore = false;
  var totalPages = 0;
  var pageNum = 0;

  PagingController<int, Doc> pagingController = PagingController(firstPageKey: 1);

  Future<void>? listAllEventApi(int pageKey) async{
    pageNum = pageKey;
    Map data = {
      "page" : pageKey,
      "limit" : limit,
      "search" : searchController.value.text.isEmpty ? "" : searchController.text
    };
    await _apis.listAllEventRepo(data).then((value){
        if(value == null){
          Utils.toastMessage("Data is Empty!!!");
        }else{
          allList = value.data.docs;
          totalPages = value.data.totalPages;

          final isLastPage = allList.length < limit;
          if (isLastPage) {
            pagingController.appendLastPage(allList);
          } else {
            var nextPageKey = pageKey + 1;
            pagingController.appendPage(allList, nextPageKey);
          }
           update();
          //return allList;
        }
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }
}