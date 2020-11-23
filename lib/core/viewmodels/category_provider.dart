import 'package:uplanit_supplier/core/models/category.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_category.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class CategoryProvider extends BaseModel {
  OnboardService onboardService = OnboardService();
  AuthenticationService auth = locator<AuthenticationService>();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();
  List<Category> _categoryList = [];
  List<Category> _selectedCategoryList = [];

  bool isCategoryLoading = false;

  List<Category> get categoryList => _categoryList;
  List<Category> get selectedCategoryList => _selectedCategoryList;

  void setCategoryList(List<Category> categories) {
    _categoryList = categories;

    notifyListeners();
  }

  void loadCategory() async {
    isCategoryLoading = true;
    _selectedCategoryList.clear();
    _categoryList.clear();
    List<Category> categories =
        await onboardService.getCategories(user: auth.user);

    isCategoryLoading = false;
    setCategoryList(categories);
  }

  void userSelectedCategories(List<Category> categories) async {}

  Future<List<Category>> createCategory() async {
    String token = await auth.user.getIdToken();
    PostCategory postCategory = PostCategory(
        categories:
            List<String>.from(selectedCategoryList.map<String>((e) => e.id))
                .toList());
    return onboardService.createCategory(
      postCategories: postCategory,
      token: token,
    );
  }

  Future<List<Category>> updateCategory() async {
    String token = await auth.user.getIdToken();
    PostCategory postCategory = PostCategory(
        categories:
            List<String>.from(selectedCategoryList.map<String>((e) => e.id))
                .toList());
    return _businessProfileService.updateSupplierCategory(
      postCategories: postCategory,
      token: token,
    );
  }

  void addSelected(int index, {bool toggle = true}) {
    Category category = _categoryList[index];
    if (toggle) {
      category.selected = !category.selected;
    }
    List<Category> list = _selectedCategoryList
        .where((element) => element.categoryId == category.categoryId)
        .toList();
    print('addSelected');
    if (category.selected && list.length <= 0) {
      _selectedCategoryList.add(category);
      print('add');
    } else {
      _selectedCategoryList.remove(category);
      print('remove');
    }
    notifyListeners();
  }

  // updateUserSelectedList(List<BaseCategory> list) {
  //   for (BaseCategory baseCategory in list) {
  //     print('base Category adding: ${baseCategory.id}');
  //     _selectedCategoryList.add(
  //       Category(
  //         id: baseCategory.id,
  //         name: baseCategory.name,
  //         categoryId: baseCategory.categoryId,
  //       ),
  //     );
  //   }
  // }
}
