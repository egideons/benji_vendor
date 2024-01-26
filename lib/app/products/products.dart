import 'package:benji_vendor/app/products/view_product.dart';
import 'package:benji_vendor/src/components/card/empty.dart';
import 'package:benji_vendor/src/components/container/business_product_container.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/components/section/my_liquid_refresh.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/model/business_model.dart';
import 'package:benji_vendor/src/model/product_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/components/button/my outlined elevatedButton.dart';
import '../../src/providers/constants.dart';
import '../../src/providers/responsive_constants.dart';
import '../../theme/colors.dart';
import 'add_new_product.dart';

class Products extends StatefulWidget {
  const Products({super.key, required this.business});
  final BusinessModel business;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      ProductController.instance
          .scrollListener(scrollController, widget.business.id);
    });
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  //========= variables ==========//
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
        () => ProductController.instance.refreshData(widget.business.id));
    setState(() {
      refreshing = false;
    });
  }

  addProduct() {
    Get.to(
      () => AddProduct(business: widget.business),
      routeName: 'AddProduct',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  viewProduct(ProductModel product) {
    Get.to(
      () => ViewProduct(product: product),
      routeName: 'ViewProduct',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
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
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text(
                'Your Products',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                isScrollToTopBtnVisible
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: MyOutlinedElevatedButton(
                          elevation: 10,
                          onPressed: addProduct,
                          circularBorderRadius: 10,
                          minimumSizeWidth: 80,
                          minimumSizeHeight: 40,
                          maximumSizeWidth: 90,
                          maximumSizeHeight: 40,
                          title: "Add",
                          titleFontSize: 12,
                        ),
                      )
                    : const SizedBox(),
              ],
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
                    onPressed: addProduct,
                    elevation: 20.0,
                    backgroundColor: kAccentColor,
                    foregroundColor: kPrimaryColor,
                    tooltip: "Add a product",
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
                    GetBuilder<ProductController>(
                      // initState: (state) async {
                      //   await ProductController.instance.getProducts();
                      // },
                      builder: (controller) {
                        return controller.isLoad.value &&
                                controller.products.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kAccentColor,
                                ),
                              )
                            : controller.products.isEmpty
                                ? EmptyCard(
                                    emptyCardMessage:
                                        "You don't have any products yet",
                                    showButton: true,
                                    buttonTitle: "Add product",
                                    onPressed: addProduct,
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
                                        itemCount: controller.products.length,
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
                                          return BusinessProductContainer(
                                            onTap: () => viewProduct(
                                                controller.products[index]),
                                            product: controller.products[index],
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
