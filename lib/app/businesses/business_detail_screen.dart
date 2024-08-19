import 'dart:math';

import 'package:benji_vendor/app/orders/orders.dart';
import 'package:benji_vendor/src/components/appbar/my_appbar.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/image/my_image.dart';
import '../../src/components/section/my_liquid_refresh.dart';
import '../../src/controller/business_controller.dart';
import '../../src/controller/error_controller.dart';
import '../../src/controller/order_controller.dart';
import '../../src/controller/reviews_controller.dart';
import '../../src/model/business_model.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../products/add_new_product.dart';
import '../products/business_products.dart';
import 'about_business.dart';

class BusinessDetailScreen extends StatefulWidget {
  final BusinessModel business;
  const BusinessDetailScreen({
    super.key,
    required this.business,
  });

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen>
    with SingleTickerProviderStateMixin {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\

  @override
  void initState() {
    super.initState();
    loadPage();
    scrollController.addListener(scrollListener);
    _tabBarController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabBarController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  //========================= VARIABLES =========================\\
  bool refreshing = false;

  Future<void> loadPage() async {
    setState(() {
      refreshing = true;
    });
    await ProductController.instance.getBusinessProducts(widget.business.id);
    await OrderController.instance.getOrdersByStatus(widget.business.id);
    await ReviewsController.instance.getReviews(widget.business.id);
    await BusinessController.instance.setBusiness(widget.business.id);

    setState(() {
      refreshing = false;
    });
  }

  _toBusinessLocation() {
    double latitude;
    double longitude;
    if (kIsWeb) {
      ApiProcessorController.errorSnack("Not supported on the web");
      return;
    }
    try {
      latitude = double.parse(widget.business.latitude);
      longitude = double.parse(widget.business.longitude);
      if (latitude >= -90 &&
          latitude <= 90 &&
          longitude >= -180 &&
          longitude <= 180) {
      } else {
        ApiProcessorController.errorSnack(
            "An error occured, fetching the address failed. Please try again later.");
        return;
      }
    } catch (e) {
      ApiProcessorController.errorSnack(
        "An error occured, fetching the address failed. Please try again later.\nERROR: $e. Please try again later",
      );
      return;
    }
  }

//==========================================================================================\\

  //=================================== ALL VARIABLES ====================================\\
  int selectedRating = 0;

  //=================================== CONTROLLERS ====================================\\
  late TabController _tabBarController;
  final ScrollController scrollController = ScrollController();

//===================== KEYS =======================\\
  // final _formKey = GlobalKey<FormState>();

//===================== FOCUS NODES =======================\\
  FocusNode rateVendorFN = FocusNode();

//===================== BOOL VALUES =======================\\
  bool isScrollToTopBtnVisible = false;

//================================================= FUNCTIONS ===================================================\\

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
    if (scrollController.position.pixels >= 200 &&
        isScrollToTopBtnVisible != true) {
      setState(() {
        isScrollToTopBtnVisible = true;
      });
    }
    if (scrollController.position.pixels < 200 &&
        isScrollToTopBtnVisible == true) {
      setState(() {
        isScrollToTopBtnVisible = false;
      });
    }
  }

  int selectedtabbar = 0;

  void _clickOnTabBarOption(value) async {
    setState(() {
      selectedtabbar = value;
    });
  }

//=================================== Navigation =====================================\\

  addProduct() => Get.to(
        () => AddProduct(business: widget.business),
        routeName: 'AddProduct',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.downToUp,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return MyLiquidRefresh(
      onRefresh: loadPage,
      child: Scaffold(
        appBar: MyAppBar(
          title: isScrollToTopBtnVisible
              ? widget.business.shopName
              : "Business Details",
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        floatingActionButton: isScrollToTopBtnVisible
            ? FloatingActionButton(
                onPressed: scrollToTop,
                mini: true,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: const FaIcon(FontAwesomeIcons.chevronUp,
                    size: 18, color: kPrimaryColor),
              )
            : FloatingActionButton(
                onPressed: addProduct,
                elevation: 20.0,
                backgroundColor: kAccentColor,
                foregroundColor: kPrimaryColor,
                tooltip: "Add a business",
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                child: const FaIcon(FontAwesomeIcons.plus),
              ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            child: ListView(
              controller: scrollController,
              physics: const ScrollPhysics(),
              children: [
                SizedBox(
                  height: max(400, media.height / 2.5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: max(400, media.height / 2.5) * 0.6,
                          decoration: BoxDecoration(color: kLightGreyColor),
                          child: Center(
                            child: MyImage(
                              height: double.infinity,
                              width: media.width,
                              fit: BoxFit.cover,
                              url: widget.business.coverImage,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: max(400, media.height / 2.5) * 0.3,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: ShapeDecoration(
                            shadows: [
                              BoxShadow(
                                color: kBlackColor.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                            color: const Color(0xFFFEF8F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0.50,
                                color: Color(0xFFFDEDED),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: kDefaultPadding * 2.6),
                            child: SizedBox(
                              width: media.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          widget.business.shopName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: kTextBlackColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  kHalfSizedBox,
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.locationDot,
                                          color: kAccentColor,
                                          size: 15,
                                        ),
                                        kHalfWidthSizedBox,
                                        Flexible(
                                          child: Text(
                                            widget.business.address,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  InkWell(
                                    onTap: widget.business.address.isEmpty
                                        ? null
                                        : _toBusinessLocation,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: kAccentColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        widget.business.address.isEmpty
                                            ? "Not Available"
                                            : "Show on map",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: media.width * 0.23,
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: ShapeDecoration(
                                          color: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(19),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const FaIcon(
                                              FontAwesomeIcons.solidStar,
                                              color: kStarColor,
                                              size: 17,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              doubleFormattedText(
                                                (widget.business.averageRating),
                                              ),
                                              style: const TextStyle(
                                                color: kBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GetBuilder<BusinessController>(
                                        builder: (controller) {
                                          return Container(
                                            // width: media.width * 0.32,
                                            // height: 57,
                                            padding: const EdgeInsets.all(10),
                                            decoration: ShapeDecoration(
                                              color: kPrimaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(19),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Switch(
                                                  value: controller
                                                      .isBusinessOpen.value,
                                                  mouseCursor:
                                                      SystemMouseCursors.click,
                                                  activeColor: kSuccessColor,
                                                  onChanged: controller
                                                          .isLoadBusinessStatus
                                                          .value
                                                      ? null
                                                      : (value) {
                                                          controller
                                                              .setBusinessOnlineStatus(
                                                            widget.business.id,
                                                            !controller
                                                                .isBusinessOpen
                                                                .value,
                                                          );
                                                        },
                                                ),
                                                Text(
                                                  controller
                                                          .isBusinessOpen.value
                                                      ? "Open".toUpperCase()
                                                      : 'Closed'.toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: controller
                                                            .isBusinessOpen
                                                            .value
                                                        ? kSuccessColor
                                                        : kAccentColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: -0.36,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                // FaIcon(
                                                //   Icons.info,
                                                //   color: kAccentColor,
                                                // ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: max(400, media.height / 2.5) *
                            (deviceType(media.width) > 2 ? 0.14 : 0.17),
                        left: deviceType(media.width) > 2
                            ? (media.width / 2) - (126 / 2)
                            : (media.width / 2) - (100 / 2),
                        child: SizedBox(
                          child: CircleAvatar(
                            radius: deviceType(media.width) > 2 ? 63 : 50,
                            child: ClipOval(
                              child: Center(
                                child: MyImage(
                                  height:
                                      deviceType(media.width) > 2 ? 126 : 100,
                                  width:
                                      deviceType(media.width) > 2 ? 126 : 100,
                                  url: widget.business.shopImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                deviceType(media.width) > 2 ? kSizedBox : kHalfSizedBox,
                Padding(
                  padding: deviceType(media.width) > 2
                      ? const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 6)
                      : const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5),
                  child: Container(
                    width: media.width,
                    decoration: BoxDecoration(
                      color: kDefaultCategoryBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: kLightGreyColor,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TabBar(
                            controller: _tabBarController,
                            onTap: (value) => _clickOnTabBarOption(value),
                            splashBorderRadius: BorderRadius.circular(50),
                            enableFeedback: true,
                            mouseCursor: SystemMouseCursors.click,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: kTransparentColor,
                            automaticIndicatorColorAdjustment: true,
                            labelColor: kPrimaryColor,
                            unselectedLabelColor: kTextGreyColor,
                            indicator: BoxDecoration(
                              color: kAccentColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            tabs: const [
                              Tab(text: "Products"),
                              Tab(text: "Orders"),
                              Tab(text: "About"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kSizedBox,
                refreshing
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: kAccentColor,
                      ))
                    : Container(
                        padding: deviceType(media.width) > 2
                            ? const EdgeInsets.symmetric(horizontal: 20)
                            : const EdgeInsets.symmetric(horizontal: 10),
                        child: selectedtabbar == 0
                            ? BusinessProducts(
                                business: widget.business,
                              )
                            : selectedtabbar == 1
                                ? Orders(business: widget.business)
                                : AboutBusiness(
                                    business: widget.business,
                                  ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
