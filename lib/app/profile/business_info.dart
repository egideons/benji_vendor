// ignore_for_file: unused_local_variable, use_build_context_synchronously, unused_field, invalid_use_of_protected_member

import 'dart:async';
import 'dart:io';

import 'package:benji_vendor/app/profile/my_blue_textformfield.dart';
import 'package:benji_vendor/src/components/appbar/my%20appbar.dart';
import 'package:benji_vendor/src/components/button/my%20elevatedButton.dart';
import 'package:benji_vendor/src/components/input/my_message_textformfield.dart';
import 'package:benji_vendor/src/controller/error_controller.dart';
import 'package:benji_vendor/src/controller/form_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../src/providers/constants.dart';
import '../../src/components/image/my_image.dart';
import '../../src/components/section/business_category_modal.dart';
import '../../src/controller/category_controller.dart';
import '../../src/providers/helper.dart';
import '../../src/providers/responsive_constants.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  //==========================================================================================\\
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CategoryController.instance.category;
      CategoryController.instance.getCategory();
    });
    scrollController.addListener(_scrollListener);
    shopImage = UserController.instance.user.value.shopImage;
    shopNameEC.text = UserController.instance.user.value.shopName;
    vendorMonToFriOpeningHoursEC.text =
        UserController.instance.user.value.weekOpeningHours;
    vendorMonToFriClosingHoursEC.text =
        UserController.instance.user.value.weekClosingHours;
    vendorSatOpeningHoursEC.text =
        UserController.instance.user.value.satClosingHours;
    vendorSatClosingHoursEC.text =
        UserController.instance.user.value.satClosingHours;
    vendorSunOpeningHoursEC.text =
        UserController.instance.user.value.sunWeekOpeningHours;
    vendorSunClosingHoursEC.text =
        UserController.instance.user.value.sunWeekClosingHours;
    businessBioEC.text = UserController.instance.user.value.businessBio;
    vendorBusinessTypeEC.text =
        UserController.instance.user.value.shopType.name;
    consoleLog("This is the shop image: $shopImage");
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

//==========================================================================================\\

  //===================== ALL VARIABLES =======================\\
  String? shopImage;
  String? shopType;
  String? shopTypeHint;

  //======================================== GLOBAL KEYS ==============================================\\
  final _formKey = GlobalKey<FormState>();

  //===================== BOOL VALUES =======================\\
  bool isScrollToTopBtnVisible = false;

  //============================================== CONTROLLERS =================================================\\
  final scrollController = ScrollController();
  final shopNameEC = TextEditingController();
  final vendorMonToFriOpeningHoursEC = TextEditingController();
  final vendorSatOpeningHoursEC = TextEditingController();
  final vendorSunOpeningHoursEC = TextEditingController();
  final vendorMonToFriClosingHoursEC = TextEditingController();
  final vendorSatClosingHoursEC = TextEditingController();
  final vendorSunClosingHoursEC = TextEditingController();
  final businessBioEC = TextEditingController();
  final vendorBusinessTypeEC = TextEditingController();

  //=================================== FOCUS NODES ====================================\\
  final shopNameFN = FocusNode();
  final vendorMonToFriOpeningHoursFN = FocusNode();
  final vendorSatOpeningHoursFN = FocusNode();
  final vendorSunOpeningHoursFN = FocusNode();
  final vendorMonToFriClosingHoursFN = FocusNode();
  final vendorSatClosingHoursFN = FocusNode();
  final vendorSunClosingHoursFN = FocusNode();
  final businessBioFN = FocusNode();
  final vendorBusinessTypeFN = FocusNode();

  //============================================= FUNCTIONS ===============================================\\

//=========================== IMAGE PICKER ====================================\\

  final ImagePicker _picker = ImagePicker();
  File? selectedCoverImage;
  // File? selectedLogoImage;
  //================================== function ====================================\\
  pickCoverImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
    if (image != null) {
      selectedCoverImage = File(image.path);
      Get.back();
      setState(() {});
    }
  }

  // pickLogoImage(ImageSource source) async {
  //   final XFile? image = await _picker.pickImage(
  //     source: source,
  //   );
  //   if (image != null) {
  //     selectedLogoImage = File(image.path);
  //     Get.back();
  //     setState(() {});
  //   }
  // }

  //========================== Save data ==================================\\
  Future<void> saveChanges() async {
    if (selectedCoverImage == null && shopImage!.isEmpty) {
      ApiProcessorController.errorSnack("Please select a shop image");
      return;
    }
    if (shopType == null &&
        vendorBusinessTypeEC.text.isEmpty &&
        shopType!.isEmpty) {
      ApiProcessorController.errorSnack("Please select a type of business");
      return;
    }
    Map data = {
      "shop_name": shopNameEC.text,
      "weekOpeningHours": vendorMonToFriOpeningHoursEC.text,
      "weekClosingHours": vendorMonToFriClosingHoursEC.text,
      "satOpeningHours": vendorSatOpeningHoursEC.text,
      "satClosingHours": vendorSatClosingHoursEC.text,
      "sunWeekOpeningHours": vendorSunOpeningHoursEC.text,
      "sunWeekClosingHours": vendorSunClosingHoursEC.text,
      "description": businessBioEC.text,
      "shop_type": shopType,
    };
    consoleLog("This is the data: $data");
    consoleLog(
        Api.baseUrl + Api.changeVendorBusinessProfile + vendorId.toString());
    consoleLog("shop_image: $selectedCoverImage");
    await FormController.instance.postAuthstream(
        Api.baseUrl + Api.changeVendorBusinessProfile + vendorId.toString(),
        data,
        {'shop_image': selectedCoverImage},
        'changeVendorBusinessProfile');
    if (FormController.instance.status.toString().startsWith('2')) {}
  }

  //=========================== WIDGETS ====================================\\
  Widget uploadCoverImage() => Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "Upload Cover Image",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            kSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        pickCoverImage(ImageSource.camera);
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                              width: 0.5,
                              color: kLightGreyColor,
                            ),
                          ),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.camera,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                    ),
                    kHalfSizedBox,
                    const Text("Camera"),
                  ],
                ),
                kWidthSizedBox,
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        pickCoverImage(ImageSource.gallery);
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                              width: 0.5,
                              color: kLightGreyColor,
                            ),
                          ),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.image,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                    ),
                    kHalfSizedBox,
                    const Text("Gallery"),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  // Widget uploadLogoImage() => Container(
  //       height: 140,
  //       width: MediaQuery.of(context).size.width,
  //       margin: const EdgeInsets.only(
  //         left: kDefaultPadding,
  //         right: kDefaultPadding,
  //         bottom: kDefaultPadding,
  //       ),
  //       child: Column(
  //         children: <Widget>[
  //           const Text(
  //             "Upload Logo Image",
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           kSizedBox,
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       pickLogoImage(ImageSource.camera);
  //                     },
  //                     borderRadius: BorderRadius.circular(100),
  //                     child: Container(
  //                       height: 60,
  //                       width: 60,
  //                       decoration: ShapeDecoration(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(100),
  //                           side: BorderSide(
  //                             width: 0.5,
  //                             color: kLightGreyColor,
  //                           ),
  //                         ),
  //                       ),
  //                       child: Center(
  //                         child: FaIcon(
  //                           FontAwesomeIcons.camera,
  //                           color: kAccentColor,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   kHalfSizedBox,
  //                   const Text("Camera"),
  //                 ],
  //               ),
  //               kWidthSizedBox,
  //               Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       pickLogoImage(ImageSource.gallery);
  //                     },
  //                     borderRadius: BorderRadius.circular(100),
  //                     child: Container(
  //                       height: 60,
  //                       width: 60,
  //                       decoration: ShapeDecoration(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(100),
  //                           side: BorderSide(
  //                             width: 0.5,
  //                             color: kLightGreyColor,
  //                           ),
  //                         ),
  //                       ),
  //                       child: Center(
  //                         child: FaIcon(
  //                           FontAwesomeIcons.image,
  //                           color: kAccentColor,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   kHalfSizedBox,
  //                   const Text("Gallery"),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );

  //===================== Scroll to Top ==========================\\
  Future<void> _scrollToTop() async {
    await scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      isScrollToTopBtnVisible = false;
    });
  }

  Future<void> _scrollListener() async {
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: MyAppBar(
          title: "Business Info",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        bottomNavigationBar: GetBuilder<FormController>(
            init: FormController(),
            builder: (saving) {
              return Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.all(kDefaultPadding),
                child: MyElevatedButton(
                  onPressed: (() async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      saveChanges();
                    }
                  }),
                  isLoading: saving.isLoad.value,
                  title: "Save",
                ),
              );
            }),
        floatingActionButton: isScrollToTopBtnVisible
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                mini: deviceType(media.width) > 2 ? false : true,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: const FaIcon(FontAwesomeIcons.chevronUp, size: 18),
              )
            : const SizedBox(),
        body: SafeArea(
            child: Scrollbar(
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(kDefaultPadding),
            children: [
              const Text(
                "Business content",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "This is visible to users",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kSizedBox,
              kSizedBox,
              DottedBorder(
                color: kLightGreyColor,
                borderPadding: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        selectedCoverImage == null
                            ? Container(
                                width: media.width,
                                height: 144,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 0.50,
                                      color: Color(0xFFE6E6E6),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: MyImage(url: shopImage!),
                                  //     CachedNetworkImage(
                                  //   imageUrl: shopImage!,
                                  //   fit: BoxFit.cover,
                                  //   progressIndicatorBuilder:
                                  //       (context, url, downloadProgress) =>
                                  //           Center(
                                  //               child: CupertinoActivityIndicator(
                                  //                   color: kAccentColor)),
                                  //   errorWidget: (context, url, error) =>
                                  //       Icon(Icons.error, color: kAccentColor),
                                  // )
                                ),
                              )
                            : Container(
                                width: media.width,
                                height: 144,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: FileImage(selectedCoverImage!),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 0.50,
                                      color: Color(0xFFE6E6E6),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              elevation: 20,
                              barrierColor: kBlackColor.withOpacity(0.8),
                              showDragHandle: true,
                              useSafeArea: true,
                              isDismissible: true,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(kDefaultPadding),
                                ),
                              ),
                              enableDrag: true,
                              builder: ((builder) => uploadCoverImage()),
                            );
                          },
                          splashColor: kAccentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Upload shop image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kAccentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     selectedLogoImage == null
                    //         ? Container(
                    //             width: media.width,
                    //             height: 144,
                    //             decoration: ShapeDecoration(
                    //               shape: RoundedRectangleBorder(
                    //                 side: const BorderSide(
                    //                   width: 0.50,
                    //                   color: Color(0xFFE6E6E6),
                    //                 ),
                    //                 borderRadius: BorderRadius.circular(20),
                    //               ),
                    //             ),
                    //             child: Center(
                    //               child: FaIcon(
                    //                 FontAwesomeIcons.solidCircleUser,
                    //                 color: kAccentColor,
                    //                 size: 40,
                    //               ),
                    //             ),
                    //           )
                    //         : Container(
                    //             height: 200,
                    //             width: 200,
                    //             decoration: ShapeDecoration(
                    //               shape: const OvalBorder(),
                    //               image: DecorationImage(
                    //                 image: FileImage(
                    //                   selectedLogoImage!,
                    //                 ),
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //     InkWell(
                    //       onTap: () {
                    //         showModalBottomSheet(
                    //           context: context,
                    //           elevation: 20,
                    //           barrierColor: kBlackColor.withOpacity(0.8),
                    //           showDragHandle: true,
                    //           useSafeArea: true,
                    //           isDismissible: true,
                    //           isScrollControlled: true,
                    //           shape: const RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.vertical(
                    //               top: Radius.circular(kDefaultPadding),
                    //             ),
                    //           ),
                    //           enableDrag: true,
                    //           builder: ((builder) => uploadLogoImage()),
                    //         );
                    //       },
                    //       splashColor: kAccentColor.withOpacity(0.1),
                    //       borderRadius: BorderRadius.circular(10),
                    //       child: Container(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Text(
                    //           'Upload business logo',
                    //           style: TextStyle(
                    //             color: kAccentColor,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w400,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              kSizedBox,
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shop Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kSizedBox,
                    MyBlueTextFormField(
                      controller: shopNameEC,
                      validator: (value) {
                        if (value == null || value!.isEmpty) {
                          shopNameFN.requestFocus();
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: shopNameFN,
                      hintText: "Name of shop",
                      textInputType: TextInputType.text,
                    ),
                    kSizedBox,
                    const Text(
                      "Type of Business",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kSizedBox,
                    GetBuilder<CategoryController>(builder: (type) {
                      return InkWell(
                        onTap: () async {
                          var data =
                              await shopTypeModal(context, type.category);
                          if (data != null) {
                            setState(() {
                              shopType = data.id;
                              shopTypeHint = data.name;
                              vendorBusinessTypeEC.text = data.name;
                            });
                            consoleLog(shopType.toString());
                          }
                        },
                        child: MyBlueTextFormField(
                          controller: vendorBusinessTypeEC,
                          isEnabled: false,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              "Field cannot be empty";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            vendorBusinessTypeEC.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: vendorBusinessTypeFN,
                          hintText: shopTypeHint ??
                              "E.g Restaurant, Auto Dealer, etc",
                          textInputType: TextInputType.text,
                        ),
                      );
                    }),
                    kSizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Business hours".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        kSizedBox,
                        const Center(
                          child: Text(
                            "Mondays to Fridays",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        kSizedBox,
                        const Text(
                          "Opening hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyBlueTextFormField(
                          controller: vendorMonToFriOpeningHoursEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            UppercaseTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.next,
                          focusNode: vendorMonToFriOpeningHoursFN,
                          hintText: "00:00 AM",
                          textInputType: TextInputType.text,
                        ),
                        kSizedBox,
                        const Text(
                          "Closing hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyBlueTextFormField(
                          controller: vendorMonToFriClosingHoursEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            UppercaseTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.next,
                          focusNode: vendorMonToFriClosingHoursFN,
                          hintText: "00:00 PM",
                          textInputType: TextInputType.text,
                        ),
                        kSizedBox,
                        const Center(
                          child: Text(
                            "Saturdays",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        kSizedBox,
                        const Text(
                          "Opening hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyBlueTextFormField(
                          controller: vendorSatOpeningHoursEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            UppercaseTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.next,
                          focusNode: vendorSatOpeningHoursFN,
                          hintText: "00:00 AM",
                          textInputType: TextInputType.text,
                        ),
                        kSizedBox,
                        const Text(
                          "Closing hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyBlueTextFormField(
                          controller: vendorSatClosingHoursEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            UppercaseTextInputFormatter(), // Custom formatter to make text uppercase
                          ],
                          textInputAction: TextInputAction.next,
                          focusNode: vendorSatClosingHoursFN,
                          hintText: "00:00 PM",
                          textInputType: TextInputType.text,
                        ),
                        kSizedBox,
                        const Center(
                          child: Text(
                            "Sundays",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        kSizedBox,
                        const Text(
                          "Opening hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyBlueTextFormField(
                          controller: vendorSunOpeningHoursEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            UppercaseTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.next,
                          focusNode: vendorSunOpeningHoursFN,
                          hintText: "00:00 AM",
                          textInputType: TextInputType.text,
                        ),
                        kSizedBox,
                        const Text(
                          "Closing hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyBlueTextFormField(
                          controller: vendorSunClosingHoursEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            UppercaseTextInputFormatter(),
                          ],
                          textInputAction: TextInputAction.next,
                          focusNode: vendorSunClosingHoursFN,
                          hintText: "00:00 AM",
                          textInputType: TextInputType.text,
                        ),
                        kSizedBox,
                        const Text(
                          "Business description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        MyMessageTextFormField(
                          controller: businessBioEC,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              businessBioFN.requestFocus();
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {},
                          textInputAction: TextInputAction.go,
                          focusNode: businessBioFN,
                          hintText: "Business description",
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          maxLength: 1000,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
