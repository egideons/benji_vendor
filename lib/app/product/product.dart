import 'package:benji_vendor/src/common_widgets/container/vendors_product_container.dart';
import 'package:benji_vendor/src/common_widgets/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/common_widgets/button/my outlined elevatedButton.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'add new product.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    super.initState();
    scrollController.addListener(
        () => ProductController.instance.scrollListener(scrollController));
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  //========= variables ==========//
  final ScrollController scrollController = ScrollController();

  //============================= ALL VARIABLES =====================================\\

  //===================== TEXTEDITING CONTROLLER =======================\\
  TextEditingController searchController = TextEditingController();

  //===================== Fucntions =======================\\
  _addProduct() {
    Get.to(
      () => const AddProduct(),
      routeName: 'AddProduct',
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
    return MyResponsivePadding(
      child: GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        child: Scaffold(
          body: SafeArea(
            maintainBottomViewPadding: true,
            child: Container(
              color: kPrimaryColor,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(
                kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Product',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        MyOutlinedElevatedButton(
                          elevation: 5.0,
                          onPressed: _addProduct,
                          circularBorderRadius: 10,
                          minimumSizeWidth: 65,
                          minimumSizeHeight: 35,
                          maximumSizeWidth: 65,
                          maximumSizeHeight: 35,
                          title: "+ Add",
                          titleFontSize: 12,
                        )
                      ],
                    ),
                  ),
                  kSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GetBuilder<ProductController>(
                        initState: (state) async {
                          await ProductController.instance.getProducts();
                        },
                        init: ProductController(),
                        builder: (controller) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return VendorsProductContainer(
                                onTap: () {},
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
                            controller.loadedAll.value
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
