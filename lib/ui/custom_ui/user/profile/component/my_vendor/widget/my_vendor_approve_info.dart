import 'package:flutter/material.dart';
import 'package:sooq/core/vendor/viewobject/vendor_user.dart';
import 'package:sooq/ui/vendor_ui/user/profile/component/my_vendor/widget/my_vendor_approve_info.dart';


class CustomMyVendorApproveInfoWidget extends StatelessWidget {
  const CustomMyVendorApproveInfoWidget({
    Key? key,
    required this.vendorUser,
  }) : super(key: key);

  final VendorUser vendorUser; 

  @override
  Widget build(BuildContext context) {


    return MyVendorApproveInfoWidget(
      vendorUser: vendorUser,
    );
  }
}
