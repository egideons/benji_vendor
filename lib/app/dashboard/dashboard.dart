// ignore_for_file: avoid_unnecessary_containers

import 'package:benji_vendor/app/businesses/edit_business.dart';
import 'package:benji_vendor/app/packages/send_package.dart';
import 'package:benji_vendor/app/profile/edit_profile.dart';
import 'package:benji_vendor/src/components/appbar/dashboard_app_bar.dart';
import 'package:benji_vendor/src/components/card/dashboard_user_card.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/my_liquid_refresh.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/providers/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/card/empty.dart';
import '../../src/components/container/business_container.dart';
import '../../src/components/section/dashboard_businesses_display_controller.dart';
import '../../src/components/skeletons/businesses_skeletons.dart';
import '../../src/controller/business_controller.dart';
import '../../src/controller/notification_controller.dart';
import '../../src/model/business_model.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../../theme/colors.dart';
import '../businesses/add_business.dart';
import '../businesses/business_detail_screen.dart';
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
    UserController.instance.getUser();
    UserController.instance.setUserSync();
    userCode = UserController.instance.user.value.username;
    BusinessController.instance.getVendorBusinesses();

    numberOfNotifications = NotificationController.instance.notification.length;
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    scrollController.addListener(_scrollListener);
    scrollController.addListener(() {
      BusinessController.instance.scrollListener(scrollController);
    });
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

    UserController.instance.getUser();
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

  editProfile() {
    Get.to(
      () => const EditProfile(),
      routeName: 'EditProfile',
      duration: const Duration(milliseconds: 0),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: false,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  toBusinessDetailScreen(BusinessModel business) {
    Get.to(
      () => BusinessDetailScreen(business: business),
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      routeName: "BusinessDetailScreen",
      preventDuplicates: true,
      popGesture: false,
      transition: Transition.rightToLeft,
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

  toSendPackage() {
    Get.to(
      () => const SendPackage(),
      routeName: 'SendPackage',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

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
            appBar: DashboardAppBar(
              numberOfNotifications:
                  NotificationController.instance.notification.length,
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
                    DashboardUserCard(
                      user: UserController.instance.user.value,
                      onTap: editProfile,
                    ),
                    // kIsWeb ? kSizedBox : const SizedBox(),
                    // kIsWeb ? Container(
                    //   alignment: Alignment.center,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 25, horizontal: 40),
                    //         backgroundColor: kAccentColor),
                    //     onPressed: launchDownloadLinkAndroid,
                    //     child: const Text(
                    //       'Download APK',
                    //       style: TextStyle(
                    //         color: kTextWhiteColor,
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //   ),
                    // ): const SizedBox(),
                    kSizedBox,
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 24,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: toSendPackage,
                        leading: FaIcon(
                          FontAwesomeIcons.bicycle,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'Send a Package',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                      ),
                    ),
                    kSizedBox,
                    GetBuilder<BusinessController>(
                      init: BusinessController(),
                      builder: (controller) {
                        return DashboardDisplayBusinessesController(
                          refreshing: refreshing,
                          showBusinesses: showBusinesses,
                          onTap: () {
                            setState(() {
                              showBusinesses = !showBusinesses;
                            });
                          },
                          numberOfBusinesses:
                              controller.businesses.length.toString(),
                        );
                      },
                    ),
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
                                    ? const EmptyCard(
                                        emptyCardMessage:
                                            "You don't have any businesses yet",
                                      )
                                    : showBusinesses
                                        ? ListView.separated(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    kHalfSizedBox,
                                            shrinkWrap: true,
                                            reverse: true,
                                            addAutomaticKeepAlives: true,
                                            itemCount:
                                                controller.businesses.length,
                                            itemBuilder: (context, index) {
                                              return BusinessContainer(
                                                onTap: () {
                                                  Get.to(
                                                    () => BusinessDetailScreen(
                                                      business: controller
                                                          .businesses[index],
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    fullscreenDialog: true,
                                                    curve: Curves.easeIn,
                                                    routeName:
                                                        "BusinessDetailScreen",
                                                    preventDuplicates: true,
                                                    popGesture: false,
                                                    transition:
                                                        Transition.rightToLeft,
                                                  );
                                                },
                                                // onTap: toBusinessDetailScreen(
                                                //   controller.businesses[index],
                                                // ),
                                                business: controller
                                                    .businesses[index],
                                              );
                                            },
                                          )
                                        : const SizedBox();
                      },
                    ),
                    kSizedBox,
                    GetBuilder<BusinessController>(
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
                                  controller.businesses.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  height: 10,
                                  width: 10,
                                  decoration: ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: kPageSkeletonColor,
                                  ),
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
