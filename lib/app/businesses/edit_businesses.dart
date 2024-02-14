import 'package:benji_vendor/app/businesses/add_business.dart';
import 'package:benji_vendor/src/components/appbar/my_appbar.dart';
import 'package:benji_vendor/src/components/card/empty.dart';
import 'package:benji_vendor/src/components/container/business_container.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/my_liquid_refresh.dart';
import 'package:benji_vendor/src/controller/business_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/model/business_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/skeletons/businesses_skeletons.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../../theme/colors.dart';
import 'edit_business.dart';

class EditBusinessesPage extends StatefulWidget {
  const EditBusinessesPage({super.key});

  @override
  State<EditBusinessesPage> createState() => _EditBusinessesPageState();
}

class _EditBusinessesPageState extends State<EditBusinessesPage> {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
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
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void scrollListener() async {
    //========= Show action button ========//
    if (scrollController.position.pixels >= 100) {
      setState(() => isScrollToTopBtnVisible = true);
    }
    //========= Hide action button ========//
    else if (scrollController.position.pixels < 100) {
      setState(() => isScrollToTopBtnVisible = false);
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      refreshing = true;
    });
    await BusinessController.instance.getVendorBusinesses();
    setState(() {
      refreshing = false;
    });
  }

  addVendorBusiness() {
    Get.to(
      () => const AddBusiness(),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "AddBusiness",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }

  editBusiness(BusinessModel business) {
    Get.to(
      () => EditBusiness(business: business),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "EditBusiness",
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
              title: "Select a Business to edit",
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
                : const SizedBox(),
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
                        return refreshing
                            ? const BusinessListSkeleton()
                            : controller.isLoad.value &&
                                    controller.businesses.isEmpty
                                ? const BusinessListSkeleton()
                                : controller.businesses.isEmpty
                                    ? EmptyCard(
                                        emptyCardMessage:
                                            "You don't have any businesses yet",
                                        showButton: true,
                                        buttonTitle: "Add product",
                                        onPressed: addVendorBusiness,
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        reverse: true,
                                        itemCount: controller.businesses.length,
                                        physics: const BouncingScrollPhysics(),
                                        addSemanticIndexes: true,
                                        dragStartBehavior:
                                            DragStartBehavior.start,
                                        separatorBuilder: (context, index) =>
                                            kHalfSizedBox,
                                        addAutomaticKeepAlives: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // int reversedIndex =
                                          // controller.products.length -
                                          //     1 -
                                          //     index;
                                          return BusinessContainer(
                                            onTap: () => editBusiness(
                                              controller.businesses[index],
                                            ),
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
