import 'package:benji_vendor/app/profile/business_info.dart';
import 'package:benji_vendor/src/components/appbar/my_appbar.dart';
import 'package:benji_vendor/src/components/card/empty.dart';
import 'package:benji_vendor/src/components/container/vendor_business_container.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/my_liquid_refresh.dart';
import 'package:benji_vendor/src/controller/business_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/model/vendor_business.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../../theme/colors.dart';

class VendorBusiness extends StatefulWidget {
  const VendorBusiness({super.key});

  @override
  State<VendorBusiness> createState() => _VendorBusinessState();
}

class _VendorBusinessState extends State<VendorBusiness> {
  @override
  void dispose() {
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

  //============================= ALL BOOL VALUES =====================================\\
  bool refreshing = false;
  bool isScrollToTopBtnVisible = false;

  //===================== TEXTEDITING CONTROLLER =======================\\
  TextEditingController searchController = TextEditingController();

  //===================== Fucntions =======================\\

  //===================== Scroll to Top ==========================\\
  Future<void> scrollToTop() async {
    await scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      isScrollToTopBtnVisible = false;
    });
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels >= 100 &&
        isScrollToTopBtnVisible != true) {
      setState(() {
        isScrollToTopBtnVisible = true;
      });
    }
    if (scrollController.position.pixels < 100 &&
        isScrollToTopBtnVisible == true) {
      setState(() {
        isScrollToTopBtnVisible = false;
      });
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      refreshing = true;
    });
    await Future.delayed(const Duration(milliseconds: 500),
        () => ProductController.instance.refreshData());
    setState(() {
      refreshing = false;
    });
  }

  addVendorBusiness() {
    Get.to(
      () => const BusinessInfo(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "BusinessInfo",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }

  editBusiness(BusinessModel business) {
    Get.to(
      () => BusinessInfo(business: business),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "BusinessInfo",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return MyResponsivePadding(
      child: GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: MyLiquidRefresh(
          onRefresh: handleRefresh,
          child: Scaffold(
            appBar: MyAppBar(
              title: "Your Businesses",
              elevation: 0,
              actions: const [],
              backgroundColor: kPrimaryColor,
            ),
            floatingActionButton: isScrollToTopBtnVisible
                ? FloatingActionButton(
                    onPressed: scrollToTop,
                    mini: deviceType(media.width) > 2 ? false : true,
                    backgroundColor: kAccentColor,
                    foregroundColor: kPrimaryColor,
                    enableFeedback: true,
                    mouseCursor: SystemMouseCursors.click,
                    tooltip: "Scroll to top",
                    hoverColor: kAccentColor,
                    hoverElevation: 50.0,
                    child: const FaIcon(FontAwesomeIcons.chevronUp, size: 18),
                  )
                : FloatingActionButton(
                    onPressed: addVendorBusiness,
                    elevation: 20.0,
                    backgroundColor: kAccentColor,
                    foregroundColor: kPrimaryColor,
                    tooltip: "Add a business",
                    child: const FaIcon(FontAwesomeIcons.plus),
                  ),
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Scrollbar(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    GetBuilder<BusinessController>(
                      initState: (state) async {
                        await BusinessController.instance.getVendorBusinesses();
                      },
                      builder: (controller) {
                        return controller.isLoad.value &&
                                controller.businesses.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : controller.businesses.isEmpty
                                ? EmptyCard(
                                    emptyCardMessage:
                                        "You don't have any businesses yet",
                                    showButton: true,
                                    buttonTitle: "Add product",
                                    onPressed: addVendorBusiness,
                                  )
                                : refreshing
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: kAccentColor,
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        reverse: true,
                                        itemCount: controller.businesses.length,
                                        physics: const BouncingScrollPhysics(),
                                        addSemanticIndexes: true,
                                        dragStartBehavior:
                                            DragStartBehavior.start,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // int reversedIndex =
                                          // controller.products.length -
                                          //     1 -
                                          //     index;
                                          return VendorBusinessContainer(
                                            onTap: () => editBusiness(
                                                controller.businesses[index]),
                                            business:
                                                controller.businesses[index],
                                          );
                                        },
                                      );
                      },
                    ),
                    GetBuilder<ProductController>(
                      builder: (controller) => Column(
                        children: [
                          controller.isLoadMore.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: kAccentColor,
                                  ),
                                )
                              : const SizedBox(),
                          controller.loadedAll.value &&
                                  controller.products.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  height: 10,
                                  width: 10,
                                  decoration: ShapeDecoration(
                                      shape: const CircleBorder(),
                                      color: kPageSkeletonColor),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
