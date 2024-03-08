import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sooq/config/ps_colors.dart';
import 'package:sooq/config/ps_config.dart';
import 'package:sooq/config/route/route_paths.dart';
import 'package:sooq/core/vendor/constant/ps_dimens.dart';
import 'package:sooq/core/vendor/provider/language/app_localization_provider.dart';
import 'package:sooq/core/vendor/provider/vendor/search_vendor_provider.dart';
import 'package:sooq/core/vendor/repository/vendor_search_repository.dart';
import 'package:sooq/core/vendor/utils/utils.dart';
import 'package:sooq/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:sooq/core/vendor/viewobject/holder/request_path_holder.dart';
import 'package:sooq/core/vendor/viewobject/holder/vendor_search_parameter_holder.dart';
import 'package:sooq/ui/custom_ui/vendor/components/filter_vendor_list.dart';
import 'package:sooq/ui/custom_ui/vendor/components/filter_vendor_nav.dart';
import 'package:sooq/ui/vendor_ui/common/ps_ui_widget.dart';
import 'package:sooq/ui/vendor_ui/common/search_bar_view.dart';

class LatestVendorVerticalListView extends StatefulWidget {
  const LatestVendorVerticalListView();
  @override
  State<StatefulWidget> createState() {
    return _LatestVendorVerticalListView();
  }
}

class _LatestVendorVerticalListView extends State<LatestVendorVerticalListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  VendorSearchRepository? vendorSearchRepository;
  late PsValueHolder valueHolder;
  late AppLocalization langProvider;
  final ScrollController _controller = ScrollController();
  bool isGrid = true;
  late TextEditingController searchTextController = TextEditingController();
  late SearchBarView searchBar;
  VendorSearchProvider? vendorSearchProvider;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);

    searchBar = SearchBarView(
        inBar: true,
        controller: searchTextController,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print('cleared');
        },
        closeOnSubmit: false,
        onClosed: () {
          if (vendorSearchProvider != null) {
            vendorSearchProvider?.loadDataList(
                reset: true,
                requestBodyHolder:
                    vendorSearchProvider?.getAllVendorParameterHolder);
          }
        });
    super.initState();
  }

  void onSubmitted(String value) {
    // if (!_searchProductProvider.needReset) {
    //   _searchProductProvider.needReset = true;
    // }
    // widget.productParameterHolder.searchTerm = value;
    // _searchProductProvider.loadDataList(reset: true);
  }

  AppBar buildAppBar(BuildContext context) {
    searchTextController.clear();
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
      backgroundColor: Utils.isLightMode(context)
          ? PsColors.achromatic50
          : PsColors.achromatic800,
      iconTheme: Theme.of(context).iconTheme,
      title: Text('Latest Vendor'.tr,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)
              .copyWith(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50)),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, size: 24),
          onPressed: () async {
            final dynamic result =
                await Navigator.pushNamed(context, RoutePaths.searchVendor);
            if (result != null) {
              vendorSearchProvider?.vendorSearchParameterHolder =
                  result as VendorSearchParameterHolder;

              vendorSearchProvider!.loadDataList(
                  reset: true,
                  requestBodyHolder:
                      vendorSearchProvider?.vendorSearchParameterHolder,
                  requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode,
                  ));
            }
          },
        ),
        if (isGrid)
          IconButton(
            padding: const EdgeInsets.only(right: PsDimens.space16),
            icon: const Icon(Icons.grid_view, size: 20),
            onPressed: () async {
              setState(() {
                isGrid = false;
              });
            },
          )
        else
          IconButton(
            padding: const EdgeInsets.only(right: PsDimens.space16),
            icon: const Icon(Icons.list, size: 28),
            onPressed: () async {
              setState(() {
                isGrid = true;
              });
            },
          ),
      ],
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    vendorSearchRepository = Provider.of<VendorSearchRepository>(context);

    print('............................Build UI Again ............................');

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<VendorSearchProvider?>(
              lazy: false,
              create: (BuildContext context) {
                vendorSearchProvider = VendorSearchProvider(
                  repo: vendorSearchRepository,
                );
                final VendorSearchParameterHolder vendorSearchParameterHolder =
                    VendorSearchParameterHolder().getAllVendor();
                vendorSearchParameterHolder.ownerUserId =
                    Utils.checkUserLoginId(valueHolder);
                vendorSearchProvider!.loadDataList(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(valueHolder),
                        ownerUserId: Utils.checkUserLoginId(valueHolder)),
                    requestBodyHolder: vendorSearchParameterHolder);
                return vendorSearchProvider;
              }),
        ],
        child: Consumer<VendorSearchProvider>(builder: (BuildContext context,
            VendorSearchProvider vendorSearchProvider, Widget? child) {
          /**
          * UI SECTION
          */
          return Scaffold(
              appBar: searchBar.build(context),
              body: Column(
                children: <Widget>[
                  const CustomFilterVendorNav(),
                  Expanded(
                    child: CustomScrollView(
                        controller: _controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: false,
                        slivers: <Widget>[
                          CustomFilterVendorList(
                            animationController: animationController!,
                            controller: _controller,
                            isGrid: isGrid,
                          ),
                        ]),
                  ),
                  PSProgressIndicator(vendorSearchProvider.dataList.status),
                ],
              ));
        }));
  }
}
