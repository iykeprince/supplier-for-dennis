import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/category.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/core/viewmodels/category_provider.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/business_profile/viewmodels/product_description_model.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';


class SupplierCategoryDialog extends StatelessWidget {
  BusinessProfileModel _businessProfileModel;
  CategoryProvider _categoryModel;
  SupplierCategoryDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _businessProfileModel = Provider.of<BusinessProfileModel>(context);
    _categoryModel = Provider.of<CategoryProvider>(context);
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 540,
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: SupplierCategoryView(),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: _categoryModel.state == ViewState.Busy
                        ? CustomProgressWidget()
                        : Text(
                            'UPDATE'),
                    onPressed: _categoryModel.selectedCategoryList.length <= 0
                        ? null
                        : () async {
                            _categoryModel.setState(ViewState.Busy);
                            List<Category> eventTypes =
                                await _categoryModel.updateCategory();
                            _categoryModel.setState(ViewState.Idle);
                            if (eventTypes.length > 0) {
                              List<BaseCategory> baseCategories = [];
                              for (int i = 0; i < eventTypes.length; i++) {
                                baseCategories.add(
                                  BaseCategory(
                                    name: eventTypes[i].name,
                                    categoryId: eventTypes[i].categoryId,
                                    id: eventTypes[i].id,
                                  ),
                                );
                              }
                              _businessProfileModel.updateBaseCategories(
                                  baseCategories,
                                  listen: true);
                              Navigator.pop(context);
                            } else {
                              print('An error has occurred');
                            }
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupplierCategoryView extends StatefulWidget {
  @override
  _SupplierCategoryViewState createState() => _SupplierCategoryViewState();
}

class _SupplierCategoryViewState extends State<SupplierCategoryView> {
  CategoryProvider _categoryModel;

  @override
  void initState() {
    context.read<CategoryProvider>().loadCategory();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    _categoryModel = Provider.of<CategoryProvider>(context);
    List<Category> list = _categoryModel.categoryList;
    bool isCategoryLoading = _categoryModel.isCategoryLoading;

    

    return isCategoryLoading
        ? CustomProgressWidget()
        : GridView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) => _buildItem(
              context,
              index,
              list,
            ),
          );
  }

  _buildItem(
    BuildContext context,
    int index,
    List<Category> supplierCategories,
  ) {
    Category category = supplierCategories[index];

    return InkWell(
      onTap: () {
        _categoryModel.addSelected(index);
      },
      child: Opacity(
        opacity: category.selected ? 1 : .4,
        child: Container(
          width: 106,
          height: 108,
          decoration: BoxDecoration(
            color: CustomColor.uplanitBlue,
          ),
          child: Center(
            child: Text(
              category.name,
              style: GoogleFonts.workSans(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
