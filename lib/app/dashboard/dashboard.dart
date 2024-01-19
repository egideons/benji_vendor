// ignore_for_file: avoid_unnecessary_containers

import 'package:benji_vendor/app/profile/personal_info.dart';
import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/my_liquid_refresh.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/card/empty.dart';
import '../../src/components/section/welcome_greeting.dart';
import '../../src/components/skeletons/businesses_skeletons.dart';
import '../../src/controller/business_controller.dart';
import '../../src/controller/notification_controller.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../../theme/colors.dart';
import '../businesses/business_info.dart';
import '../others/notifications.dart';

class Dashboard extends StatefulWidget {
  final VoidCallback showNavigation;
  final VoidCallback hideNavigation;
  const Dashboard(
      {Key? key, required this.showNavigation, required this.hideNavigation})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

typedef ModalContentBuilder = Widget Function(BuildContext);

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // AuthController.instance.checkIfAuthorized();
    userCode = UserController.instance.user.value.username;
    BusinessController.instance.getVendorBusinesses();

    numberOfNotifications = NotificationController.instance.notification.length;
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    scrollController.addListener(_scrollListener);
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward ||
          scrollController.position.pixels < 100) {
        widget.showNavigation();
      } else {
        widget.hideNavigation();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    scrollController.dispose();
    handleRefresh().ignore();
    scrollController.removeListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        widget.showNavigation();
      } else {
        widget.hideNavigation();
      }
    });
  }

//=================================== ALL VARIABLES =====================================\\
  String? userCode;
  int? numberOfNotifications;
  bool refreshing = false;
  bool _isScrollToTopBtnVisible = false;
  bool showBusinesses = true;

  //============================================== CONTROLLERS =================================================\\
  final scrollController = ScrollController();
  late AnimationController _animationController;

//=================================== ALL FUNCTIONS =====================================\\

  //===================== COPY TO CLIPBOARD =======================\\
  copyToClipboard(BuildContext context, String userCode) {
    Clipboard.setData(
      ClipboardData(text: userCode),
    );
    ApiProcessorController.successSnack("ID copied to clipboard");
  }

  Future<void> handleRefresh() async {
    setState(() {
      refreshing = true;
    });

    UserController.instance.setUserSync();
    await BusinessController.instance.getVendorBusinesses();

    setState(() {
      refreshing = false;
    });
  }

  //============================= Scroll to Top ======================================//
  void scrollToTop() {
    _animationController.reverse();
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void _scrollListener() {
    //========= Show action button ========//
    if (scrollController.position.pixels >= 100) {
      _animationController.forward();
      setState(() => _isScrollToTopBtnVisible = true);
    }
    //========= Hide action button ========//
    else if (scrollController.position.pixels < 100) {
      _animationController.reverse();
      setState(() => _isScrollToTopBtnVisible = false);
    }
  }

//==================== NAVIGATION ==================\\

  // addProduct() {
  //   Get.to(
  //     () => const AddProduct(),
  //     routeName: 'AddProduct',
  //     duration: const Duration(milliseconds: 300),
  //     fullscreenDialog: true,
  //     curve: Curves.easeIn,
  //     preventDuplicates: true,
  //     popGesture: true,
  //     transition: Transition.downToUp,
  //   );
  // }

  // reviewsPage() {
  //   Get.to(
  //     () => const ReviewsPage(),
  //     routeName: 'ReviewsPage',
  //     duration: const Duration(milliseconds: 300),
  //     fullscreenDialog: true,
  //     curve: Curves.easeIn,
  //     preventDuplicates: true,
  //     popGesture: true,
  //     transition: Transition.rightToLeft,
  //   );
  // }

  // productDetail(ProductModel product) {
  //   Get.to(
  //     () => ViewProduct(product: product),
  //     routeName: 'ViewProduct',
  //     duration: const Duration(milliseconds: 300),
  //     fullscreenDialog: true,
  //     curve: Curves.easeIn,
  //     preventDuplicates: true,
  //     popGesture: true,
  //     transition: Transition.rightToLeft,
  //   );
  // }

  editProfile() {
    Get.to(
      () => const EditProfile(),
      routeName: 'EditProfile',
      duration: const Duration(milliseconds: 0),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
    );
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

  // productsPage() {
  //   Get.to(
  //     () => const OverView(currentIndex: 2),
  //     routeName: 'OverView',
  //     duration: const Duration(milliseconds: 0),
  //     fullscreenDialog: true,
  //     curve: Curves.easeIn,
  //     preventDuplicates: false,
  //     popGesture: true,
  //   );
  // }

  // ordersPage(StatusType status) {
  //   OrderController.instance.setStatus(status);
  //   Get.to(
  //     () => const OverView(currentIndex: 1),
  //     routeName: 'OverView',
  //     duration: const Duration(milliseconds: 0),
  //     fullscreenDialog: true,
  //     curve: Curves.easeIn,
  //     preventDuplicates: false,
  //     popGesture: true,
  //   );
  // }

  void toNotificationsPage() => Get.to(
        () => const Notifications(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Notifications",
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.downToUp,
      );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MyResponsivePadding(
      child: MyLiquidRefresh(
        onRefresh: handleRefresh,
        child: GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              titleSpacing: kDefaultPadding / 2,
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    "BEN",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "JI",
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  kHalfWidthSizedBox,
                  Text(
                    "VENDOR",
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      iconSize: 20,
                      onPressed: toNotificationsPage,
                      tooltip: "Notifications",
                      icon: FaIcon(
                        FontAwesomeIcons.bell,
                        color: kAccentColor,
                        size: 24,
                      ),
                    ),

                    // Positioned(
                    //   top: 10,
                    //   right: 5,
                    //   child: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: ShapeDecoration(
                    //       color: kAccentColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(100),
                    //       ),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         formatNumber(numberOfNotifications!),
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(
                    //           fontSize: 9,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                kWidthSizedBox,
              ],
            ),
            floatingActionButton: _isScrollToTopBtnVisible
                ? FloatingActionButton(
                    onPressed: scrollToTop,
                    mini: deviceType(media.width) > 2 ? false : true,
                    backgroundColor: kAccentColor,
                    enableFeedback: true,
                    mouseCursor: SystemMouseCursors.click,
                    tooltip: "Scroll to top",
                    hoverColor: kAccentColor,
                    hoverElevation: 50.0,
                    child: FaIcon(
                      FontAwesomeIcons.chevronUp,
                      size: 18,
                      color: kPrimaryColor,
                    ),
                  )
                : const SizedBox(),
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Scrollbar(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  children: [
                    GetBuilder<UserController>(builder: (controller) {
                      return Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        width: media.width,
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 24,
                              offset: Offset(0, 4),
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: editProfile,
                              child: CircleAvatar(
                                maxRadius:
                                    deviceType(media.width) >= 2 ? 90 : 50,
                                minRadius:
                                    deviceType(media.width) >= 2 ? 90 : 50,
                                // backgroundColor: kLightGreyColor,
                                child: ClipOval(
                                  child: MyImage(
                                    url: controller.user.value.profileLogo,
                                  ),
                                ),
                              ),
                            ),
                            deviceType(media.width) >= 2
                                ? kWidthSizedBox
                                : kHalfWidthSizedBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WelcomeGreeting(
                                  vendorName:
                                      "${controller.user.value.firstName} ${controller.user.value.lastName}",
                                ),
                                kHalfSizedBox,
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.solidEnvelope,
                                          color: kAccentColor,
                                          size: deviceType(media.width) >= 2
                                              ? 20
                                              : 15,
                                        ),
                                        kHalfSizedBox,
                                        FaIcon(
                                          FontAwesomeIcons.mapLocationDot,
                                          color: kAccentColor,
                                          size: deviceType(media.width) >= 2
                                              ? 20
                                              : 15,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: deviceType(media.width) >= 2
                                              ? media.width - 460
                                              : media.width - 250,
                                          child: Text(
                                            controller.user.value.email,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize:
                                                  deviceType(media.width) >= 2
                                                      ? 16
                                                      : 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        kHalfSizedBox,
                                        SizedBox(
                                          width: deviceType(media.width) >= 2
                                              ? media.width - 460
                                              : media.width - 250,
                                          child: Text(
                                            controller.user.value.address,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: kTextGreyColor,
                                              fontSize:
                                                  deviceType(media.width) >= 2
                                                      ? 16
                                                      : 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    kSizedBox,
                    GetBuilder<BusinessController>(
                        init: BusinessController(),
                        builder: (controller) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                showBusinesses = !showBusinesses;
                              });
                            },
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                            child: Container(
                              padding: const EdgeInsets.all(kDefaultPadding),
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.store,
                                    color: kAccentColor,
                                    size: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        showBusinesses
                                            ? "Hide Businesses"
                                            : "Show Businesses",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: kTextBlackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      kHalfWidthSizedBox,
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "(",
                                              style: TextStyle(
                                                color: kTextGreyColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: refreshing
                                                  ? "..."
                                                  : "${controller.businesses.length}",
                                              style: TextStyle(
                                                color: kAccentColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ")",
                                              style: TextStyle(
                                                color: kTextGreyColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FaIcon(
                                    showBusinesses
                                        ? FontAwesomeIcons.caretDown
                                        : FontAwesomeIcons.caretUp,
                                    color: kAccentColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    kSizedBox,
                    GetBuilder<BusinessController>(
                      init: BusinessController(),
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
                                        buttonTitle: "Add a business",
                                        onPressed: addVendorBusiness,
                                      )
                                    : showBusinesses
                                        ? ListView.separated(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    kHalfSizedBox,
                                            shrinkWrap: true,
                                            addAutomaticKeepAlives: true,
                                            itemCount:
                                                controller.businesses.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {},
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  decoration: ShapeDecoration(
                                                    color: kPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color: kBlackColor
                                                            .withOpacity(0.1),
                                                        blurRadius: 5,
                                                        spreadRadius: 2,
                                                        blurStyle:
                                                            BlurStyle.normal,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 120,
                                                        width: 120,
                                                        decoration: ShapeDecoration(
                                                            color:
                                                                kLightGreyColor,
                                                            shape:
                                                                const CircleBorder()),
                                                        child: MyImage(
                                                          url: controller
                                                              .businesses[index]
                                                              .shopImage,
                                                        ),
                                                      ),
                                                      kHalfWidthSizedBox,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: deviceType(media
                                                                        .width) >=
                                                                    2
                                                                ? media.width -
                                                                    400
                                                                : deviceType(media.width) >
                                                                            1 &&
                                                                        deviceType(media.width) <
                                                                            2
                                                                    ? media.width -
                                                                        250
                                                                    : media.width -
                                                                        220,
                                                            child: Text(
                                                              controller
                                                                  .businesses[
                                                                      index]
                                                                  .shopName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    kTextBlackColor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          SizedBox(
                                                            width: deviceType(media
                                                                        .width) >=
                                                                    2
                                                                ? media.width -
                                                                    400
                                                                : deviceType(media.width) >
                                                                            1 &&
                                                                        deviceType(media.width) <
                                                                            2
                                                                    ? media.width -
                                                                        250
                                                                    : media.width -
                                                                        220,
                                                            child: Text(
                                                              controller
                                                                  .businesses[
                                                                      index]
                                                                  .address,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color:
                                                                    kAccentColor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ),
                                                          kSizedBox,
                                                          SizedBox(
                                                            width: deviceType(media
                                                                        .width) >=
                                                                    2
                                                                ? media.width -
                                                                    400
                                                                : deviceType(media.width) >
                                                                            1 &&
                                                                        deviceType(media.width) <
                                                                            2
                                                                    ? media.width -
                                                                        250
                                                                    : media.width -
                                                                        220,
                                                            child: Row(
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .solidIdCard,
                                                                  color:
                                                                      kAccentColor,
                                                                  size: 16,
                                                                ),
                                                                kHalfWidthSizedBox,
                                                                SizedBox(
                                                                  width: deviceType(media
                                                                              .width) >=
                                                                          2
                                                                      ? media.width -
                                                                          430
                                                                      : deviceType(media.width) > 1 &&
                                                                              deviceType(media.width) <
                                                                                  2
                                                                          ? media.width -
                                                                              250
                                                                          : media.width -
                                                                              220,
                                                                  child:
                                                                      Text.rich(
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text:
                                                                              "TIN: ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                kTextBlackColor,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text: controller
                                                                              .businesses[index]
                                                                              .businessId,
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                kTextBlackColor,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : const SizedBox();
                      },
                    ),

                    kSizedBox,
                    // GetBuilder<UserController>(
                    //   builder: (controller) {
                    //     return Container(
                    //       width: media.width,
                    //       padding: const EdgeInsets.all(kDefaultPadding),
                    //       decoration: ShapeDecoration(
                    //         color: kPrimaryColor,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //         ),
                    //         shadows: const [
                    //           BoxShadow(
                    //             color: Color(0x0F000000),
                    //             blurRadius: 24,
                    //             offset: Offset(0, 4),
                    //             spreadRadius: 0,
                    //           ),
                    //         ],
                    //       ),
                    //       child: Column(
                    //         mainAxisAlignment:
                    //             MainAxisAlignment.spaceAround,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "Username: ${controller.user.value.username}",
                    //             softWrap: true,
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //             textAlign: TextAlign.start,
                    //             style: const TextStyle(
                    //               color: kTextBlackColor,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //           Text(
                    //             "Business Email: ${controller.user.value.email}",
                    //             softWrap: true,
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 1,
                    //             textAlign: TextAlign.center,
                    //             style: const TextStyle(
                    //               color: kTextBlackColor,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w400,
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               Text(
                    //                 "$userCode",
                    //                 softWrap: true,
                    //                 style: const TextStyle(
                    //                   color: kTextBlackColor,
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w400,
                    //                 ),
                    //               ),
                    //               IconButton(
                    //                 onPressed: () {
                    //                   copyToClipboard(context, userCode!);
                    //                 },
                    //                 tooltip: "Copy ID",
                    //                 mouseCursor: SystemMouseCursors.click,
                    //                 icon: FaIcon(
                    //                   FontAwesomeIcons.solidCopy,
                    //                   size: 14,
                    //                   color: kAccentColor,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    // kSizedBox,
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment:
                    //           MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           'Reviews',
                    //           style: TextStyle(
                    //             color: kTextGreyColor,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w400,
                    //           ),
                    //         ),
                    //         TextButton(
                    //           onPressed: reviewsPage,
                    //           child: Text(
                    //             'See All Reviews',
                    //             style: TextStyle(
                    //               color: kAccentColor,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w400,
                    //               decoration: TextDecoration.underline,
                    //               decorationColor: kAccentColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     kHalfSizedBox,
                    //     GetBuilder<ReviewsController>(
                    //       initState: (state) {
                    //         ReviewsController.instance.getAvgRating();
                    //         ReviewsController.instance.getReviews();
                    //       },
                    //       builder: (controller) => Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           FaIcon(
                    //             FontAwesomeIcons.solidStar,
                    //             color: kStarColor,
                    //             size: 20,
                    //           ),
                    //           kHalfWidthSizedBox,
                    //           Text(
                    //             "${controller.avgRating.value.toPrecision(1)}",
                    //             style: TextStyle(
                    //               color: kStarColor,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //           kWidthSizedBox,
                    //           Text(
                    //             'You have ${formatNumber(controller.total.value)} Reviews',
                    //             style: const TextStyle(
                    //               color: Color(0xFF32343E),
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w400,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     kSizedBox,
                    //     Row(
                    //       mainAxisAlignment:
                    //           MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           'Latest Products',
                    //           style: TextStyle(
                    //             color: kTextGreyColor,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w400,
                    //           ),
                    //         ),
                    //         TextButton(
                    //           onPressed: productsPage,
                    //           child: Text(
                    //             'See All',
                    //             style: TextStyle(
                    //               color: kAccentColor,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w400,
                    //               decoration: TextDecoration.underline,
                    //               decorationColor: kAccentColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     kHalfSizedBox,
                    //   ],
                    // ),

                    // ProductController.instance.products.isEmpty
                    //     ? const EmptyCard(
                    //         emptyCardMessage:
                    //             "You don't have any products yet.",
                    //       )
                    //     :
                    // SizedBox(
                    //   height: deviceType(media.width) >= 2 ? 300 : 260,
                    //   child: GetBuilder<ProductController>(
                    //     initState: (state) async =>
                    //         await ProductController.instance
                    //             .getProducts(),
                    //     builder: (controller) {
                    //       return controller.isLoad.value
                    //           ? Center(
                    //               child: CircularProgressIndicator(
                    //                 color: kAccentColor,
                    //               ),
                    //             )
                    //           : controller.products.isEmpty
                    //               ? const EmptyCard(
                    //                   emptyCardMessage:
                    //                       "You don't have any products yet.",
                    //                 )
                    //               : ListView.separated(
                    //                   physics:
                    //                       const BouncingScrollPhysics(),
                    //                   separatorBuilder:
                    //                       (context, index) =>
                    //                           kWidthSizedBox,
                    //                   scrollDirection: Axis.horizontal,
                    //                   reverse: true,
                    //                   shrinkWrap: true,
                    //                   itemCount: min(
                    //                       controller.products.length, 10),
                    //                   itemBuilder: (BuildContext context,
                    //                       int index) {
                    //                     return DashboardProductContainer(
                    //                       productName: controller
                    //                           .products[index].name,
                    //                       child: InkWell(
                    //                         onTap: () => productDetail(
                    //                             controller
                    //                                 .products[index]),
                    //                         child: MyImage(
                    //                           url: controller
                    //                               .products[index]
                    //                               .productImage,
                    //                           imageHeight: 150,
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                 );
                    //     },
                    //   ),
                    // ),
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
