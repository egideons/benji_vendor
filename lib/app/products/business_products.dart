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
    ProductController.instance.refreshData(widget.business.id);
    super.initState();
  }

  late Future<Map<String, List<ProductModel>>> productAndSubCategoryName;

  // _getData() async {
  //   Map<String, List<Product>> productAndSubCategoryName =
  //       await getVendorProductsAndSubCategoryName(widget.vendor.id);
  //   try {
  //     activeCategory = productAndSubCategoryName.keys.toList()[0];
  //     // ignore: empty_catches
  //   } catch (e) {}

  //   setState(() {
  //     snapshot.data = productAndSubCategoryName;
  //   });
  // }

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
                  .getBusinessProducts(widget.business.id),
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
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: (controller.products)
                        .map(
                          (item) => BusinessProductContainer(
                            onTap: () => viewProduct(item),
                            product: item,
                          ),
                        )
                        .toList(),
                  ),
                );
              }),
          kSizedBox,
        ],
      ),
    );
  }
}
