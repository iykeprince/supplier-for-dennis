import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/ui/views/base_view.dart';

import 'address_information.dart';
import 'product_description.dart';
import 'profile_image.dart';
import 'contact_information.dart';
import 'work_hours.dart';

class BusinessProfile extends StatelessWidget {
  static const String ROUTE = '/business_profile/business_profile';

  @override
  Widget build(BuildContext context) {
    return BaseView<BusinessProfileModel>(

      builder: (context, model, child) => ListView(
        children: [
          Column(
            children: [
              ProfileImageView(),
              ProductDescriptionView(),
              AddressInformationView(),
              ContactView(),
              WorkHoursView(),
            ],
          ),
        ],
      ),
    );
  }
}
