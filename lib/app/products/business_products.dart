import 'package:benji_vendor/src/components/card/empty.dart';
import 'package:benji_vendor/src/components/container/business_product_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/controller/product_controller.dart';
import '../../src/model/business_model.dart';
import '../../src/model/product_model.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'view_product.dart';

class BusinessProducts extends StatefulWidget {
  final BusinessModel business;

  const BusinessProducts({
    super.key,
    required this.business,
  });

  @override
  State<BusinessProducts> createState() => _BusinessProductsState();
}

class _BusinessProductsState extends State<BusinessProducts> {
  @override
  void initState() {
    super.initState();
  }

  late Future<Map<String, List<ProductModel>>> productAndSubCategoryName;

//=================================== Navigation =====================================\\
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
//=================================== END =====================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<ProductController>(
              initState: (state) => ProductController.instance
                  .getBusinessProducts(widget.business.id, true),
              builder: (controller) {
                if (controller.isLoad.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                    ),
                  );
                }
                if (controller.products.isEmpty) {
                  return const EmptyCard(
                    emptyCardMessage: "You don't have any products",
                  );
                }
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => BusinessProductContainer(
                          onTap: () => viewProduct(controller.products[index]),
                          product: controller.products[index],
                        ),
                    separatorBuilder: (context, index) => kSizedBox,
                    itemCount: controller.products.length);
              }),
          kSizedBox,
        ],
      ),
    );
  }
}
