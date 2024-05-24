import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:what_to_eat/services/restaurant_service.dart';

import '../models/restaurant.dart';
import '../models/tag.dart';
import '../services/tag_service.dart';

class RestaurantController extends GetxController {
  static const _pageSize = 10;
  final RestaurantService _restaurantService = RestaurantService();
  final TagService _tagService = TagService();
  final PagingController<int, Restaurant> pagingController =
      PagingController(firstPageKey: 1);
  RxBool isSearch = false.obs;
  RxString searchText = "".obs;
  RxString place = "전체".obs;
  RxList tags = [].obs;
  RxList selectedTags = [].obs;

  void updateSearchText(String str) {
    searchText.value = str;
  }

  void setPlace(String place) {
    this.place.value = place;
    isSearch.value = false;
    pagingController.refresh();
  }

  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void refreshTags() {
    print("object");
    selectedTags.clear();
  }

  void searchRestaurantByKeyword() {
    isSearch.value = true;
    pagingController.refresh();
  }

  void searchRestaurantByTag() {
    isSearch.value = false;
    pagingController.refresh();
  }

  @override
  Future<void> onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      _fetchRestaurant(pageKey);
    });
    Future.sync(() => pagingController.refresh());
    await _initTags();
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchRestaurant(int pageKey) async {
    try {
      List<Restaurant> restaurants;
      if (isSearch.value) {
        restaurants = await _restaurantService.getRestaurantListByKeyword(
            searchText.value, pageKey);
      } else {
        restaurants = await _restaurantService.getRestaurantListByTag(
            place.value, selectedTags.value, pageKey);
      }

      final isLastPage = restaurants.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(restaurants);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(restaurants, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  _initTags() async {
    List<Tag> tagList = await _tagService.getTagList();
    tags.value = tagList.map((toElement) => toElement.name).toList();
  }
}
