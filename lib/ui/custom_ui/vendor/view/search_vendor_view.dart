import 'package:flutter/material.dart';
import 'package:sooq/ui/vendor_ui/vendor/view/search_vendor_view.dart';


class CustomSearchVendorView extends StatefulWidget {
  const CustomSearchVendorView();

  @override
  State<StatefulWidget> createState() => _SearchSearchViewState();
}

class _SearchSearchViewState extends State<CustomSearchVendorView> {

  @override
  Widget build(BuildContext context) {
    return const SearchVendorView();
  }
}
