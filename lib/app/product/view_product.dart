// ignore_for_file: file_names

import 'package:benji_vendor/app/overview/overview.dart';
import 'package:benji_vendor/app/product/edit_product.dart';
import 'package:benji_vendor/src/components/button/my%20elevatedButton.dart';
import 'package:benji_vendor/src/components/image/my_image.dart';
import 'package:benji_vendor/src/components/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/form_controller.dart';
import 'package:benji_vendor/src/controller/product_controller.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/components/section/showModalBottomSheet.dart';
import '../../src/components/section/showModalBottomSheetTitleWithIcon.dart';
import '../../src/model/product_model.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class ViewProduct extends StatefulWidget {
  final ProductModel product;
  const ViewProduct({super.key, required this.product});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool deleteProductLoad = false;

  void _deleteModal() => Get.defaultDialog(
        title: "You are about to delete: ${widget.product.name}",
        titleStyle: const TextStyle(
          fontSize: 20,
          color: kTextBlackColor,
          fontWeight: FontWeight.w700,
        ),
        content: const SizedBox(height: 0),
        confirm: Container(
          padding: const EdgeInsets.all(10),
          child: GetBuilder<FormController>(
            id: 'deleteProduct',
            builder: (controller) => MyElevatedButton(
              title: 'Delete',
              onPressed: _deleteProduct,
              isLoading: controller.isLoad.value,
            ),
          ),
        ),
      );

  _deleteProduct() async {
    setState(() {
      deleteProductLoad = true;
    });
    await FormController.instance.deleteAuth(
        Api.baseUrl + Api.deleteProduct + widget.product.id,
        'deleteProduct',
        'Error occured',
        'Deleted successfully');
    // final response = await http.delete(
    //   Uri.parse(Api.baseUrl + Api.deleteProduct + widget.product.id),
    //   headers: authHeader(),
    // );

    final status = FormController.instance.status;
    setState(() {
      deleteProductLoad = false;
    });
    print('${status.value} ooo');
    if (status.value != 200) {
      return;
    }
    ProductController.instance.reset();
    Get.offAll(
      () => const OverView(currentIndex: 2),
      routeName: 'OverView',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  _editProduct() {
    Get.to(
      () => EditProduct(product: widget.product),
      routeName: 'EditProduct',
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
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white.withOpacity(
            0.6,
          ),
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 320,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                ),
                child: MyImage(url: widget.product.productImage),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              19,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ShowModalBottomSheet(
                          context,
                          20.0,
                          MediaQuery.of(context).size.height * 0.7,
                          MediaQuery.of(context).size.height * 0.5,
                          MyResponsivePadding(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(
                                left: kDefaultPadding,
                                top: kDefaultPadding / 2,
                                right: kDefaultPadding,
                                bottom: kDefaultPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ShowModalBottomSheetTitleWithIcon(
                                    title: "Option",
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding * 3,
                                  ),
                                  ListTile(
                                    onTap: _editProduct,
                                    leading: Icon(
                                      Icons.edit,
                                      color: kAccentColor,
                                      size: 14,
                                    ),
                                    title: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Color(0xFF696969),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.32,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: _deleteModal,
                                    leading: Icon(
                                      Icons.delete,
                                      color: kAccentColor,
                                      size: 14,
                                    ),
                                    title: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Color(0xFF696969),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              19,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.more_horiz_rounded,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 380,
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: Container(
                height: MediaQuery.of(context).size.height - 400,
                width: MediaQuery.of(context).size.width,
                // color: kAccentColor,
                padding: const EdgeInsets.all(
                  5.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(
                                0xFF302F3C,
                              ),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "₦${widget.product.price}",
                            style: const TextStyle(
                              color: Color(
                                0xFF333333,
                              ),
                              fontSize: 22,
                              fontFamily: 'sen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      Text(
                        widget.product.description,
                        style: const TextStyle(
                          color: Color(
                            0xFF676565,
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kSizedBox,
                      SizedBox(
                        width: media.width,
                        child: Text(
                          'Qty: ${widget.product.quantityAvailable}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(
                              0xFF828282,
                            ),
                            fontSize: 13.60,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kSizedBox,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
