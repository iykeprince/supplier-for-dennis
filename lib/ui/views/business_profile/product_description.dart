import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/enums/event_type.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/dialogs/event_type_dialog.dart';
import 'package:uplanit_supplier/ui/views/business_profile/widgets/round_edit_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

import 'dialogs/supplier_category_dialog.dart';
import 'viewmodels/product_description_model.dart';

class ProductDescriptionView extends StatelessWidget {
  ProductDescriptionView({
    Key key,
  }) : super(key: key);

  final TextEditingController _businessNameController = TextEditingController();
  final GlobalKey<HtmlEditorState> keyEditor = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // _baseProfile = context.select<BusinessProfileModel, BaseProfile>(
    //     (value) => value.baseProfile);

    return Consumer<ProductDescriptionModel>(
        builder: (context, model, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 8,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  model.isEditMode
                      ? Row(children: [
                          RaisedButton(
                            color: CustomColor.primaryColor,
                            onPressed: model.loading
                                ? null
                                : () async {
                                    String name =
                                        _businessNameController.text.trim();
                                    String description =
                                        await keyEditor.currentState.getText();
                                    if (name.isEmpty && description.isEmpty) {
                                      model.setLoading(false);
                                      return;
                                    }
                                    model.setLoading(true);
                                    BaseUserProfile userProfile =
                                        await model.updateProfile(
                                      name: name,
                                      description: description,
                                    );
                                    print(
                                        'base user profile updated: $userProfile');
                                    model.setBaseUserProfile(userProfile);
                                    model.setLoading(false);
                                    model.toggleMode();
                                  },
                            child: Row(
                              children: [
                                model.loading
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Update',
                                        style: GoogleFonts.workSans(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            onPressed: model.toggleMode,
                            child: Container(
                              color: Colors.grey.shade300,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Back',
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ])
                      : RoundEditButton(
                          onTap: model.toggleMode,
                        ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 8,
                bottom: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Name',
                              style: GoogleFonts.workSans(
                                fontSize: 16.0,
                                color: CustomColor.uplanitBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            !model.isEditMode
                                ? Text(
                                    '${model.baseUserProfile != null ? model.baseUserProfile.name : ''}',
                                    style: GoogleFonts.workSans(
                                      fontSize: 14.0,
                                      color: Color(0xFF757575),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    child: CustomTextField(
                                      value: model.baseUserProfile != null
                                          ? model.baseUserProfile.name
                                          : '',
                                      controller: _businessNameController,
                                      color: Colors.black,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category',
                              style: GoogleFonts.workSans(
                                fontSize: 16.0,
                                color: CustomColor.uplanitBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            !model.isEditMode
                                ? Container(
                                    child: Text(
                                      '${model.baseCategories != null && model.baseCategories.length > 0 ? model.baseCategories.join(',') : 'Update category'}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.workSans(
                                        fontSize: 14.0,
                                        color: Color(0xFF757575),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                : FlatButton(
                                    color: CustomColor.uplanitBlue,
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          SupplierCategoryDialog(
                                          ),
                                    ),
                                    child: Text(
                                      'Edit categories',
                                      style: GoogleFonts.workSans(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !model.isEditMode
                            ? Text(
                                'Event Types',
                                style: GoogleFonts.workSans(
                                  fontSize: 16.0,
                                  color: CustomColor.uplanitBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : FlatButton(
                                color: CustomColor.primaryColor,
                                child: Text(
                                  'Edit Event Types',
                                  style: GoogleFonts.workSans(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => EventTypeDialog(
                                    eventTypeEnum:
                                        EventTypeEnum.UPDATE_EVENT_TYPE,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 8,
                        ),
                        model.isEditMode
                            ? Container()
                            : Wrap(
                                spacing: 4,
                                runSpacing: 2,
                                children: model.baseEventTypes == null
                                    ? []
                                    : model.baseEventTypes
                                        .map(
                                          (e) => Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                            ),
                                            child: Text(
                                              '${e.name}',
                                              style: GoogleFonts.workSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: CustomColor.uplanitBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  !model.isEditMode
                      ? Text(
                          '${model.baseUserProfile == null ? '' : model.baseUserProfile.description}',
                          style: GoogleFonts.workSans(
                            fontSize: 14.0,
                            color: Color(0xFF757575),
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : HtmlEditor(
                          value:
                              '${model.baseUserProfile != null ? model.baseUserProfile.description : ''}',
                          showBottomToolbar: false,
                          useBottomSheet: false,
                          key: keyEditor,
                          height: 200,
                        ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
