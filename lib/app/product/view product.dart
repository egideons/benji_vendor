// ignore_for_file: file_names

import 'package:benji_vendor/app/product/edit_product.dart';
import 'package:benji_vendor/src/common_widgets/image/my_image.dart';
import 'package:benji_vendor/src/common_widgets/responsive_widgets/padding.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/src/providers/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../src/common_widgets/section/showModalBottomSheet.dart';
import '../../src/common_widgets/section/showModalBottomSheetTitleWithIcon.dart';
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
  void _deleteModal() => Get.defaultDialog(
        title: "What do you want to do?",
        titleStyle: const TextStyle(
          fontSize: 20,
          color: kTextBlackColor,
          fontWeight: FontWeight.w700,
        ),
        content: const SizedBox(height: 0),
        cancel: ElevatedButton(
          onPressed: () => _deleteProduct(widget.product.id),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: kAccentColor),
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: kBlackColor.withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.solidTrashCan, color: kAccentColor),
              kHalfWidthSizedBox,
              Text(
                "Delete",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );

  _deleteProduct(String id) async {
    final response = await http.delete(
      Uri.parse(Api.baseUrl + Api.deleteProduct + id),
      headers: authHeader(),
    );
    if (response.statusCode != 200) {
      ApiProcessorController.errorSnack('Error occured');
      return;
    }

    ApiProcessorController.successSnack('Deleted successfully');
    Get.back();
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
                                    onTap: () {},
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
