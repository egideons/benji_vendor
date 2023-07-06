// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../reusable widgets/my appbar.dart';
import '../../reusable widgets/my disabled outlined elevatedButton.dart';
import '../../reusable widgets/my elevatedButton.dart';
import '../../reusable widgets/my outlined elevatedButton.dart';
import '../../reusable widgets/my textformfield.dart';
import '../../theme/colors.dart';
import '../../theme/constants.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //============================= ALL VARIABLES =====================================\\

  //===================== GLOBAL KEYS =======================\\
  final _formKey = GlobalKey<FormState>();

  //================================== DROP DOWN BUTTONFORMFIELD ====================================\\
  String dropDownItemValue = "Food";

  //================================== FOCUS NODES ====================================\\
  FocusNode productType = FocusNode();
  FocusNode productNameFN = FocusNode();
  FocusNode productPriceFN = FocusNode();
  FocusNode productQuantityFN = FocusNode();
  FocusNode productDiscountFN = FocusNode();

  void dropDownOnChanged(String? onChanged) {
    setState(() {
      dropDownItemValue = onChanged!;
    });
  }

  //================================== CONTROLLERS ====================================\\
  TextEditingController productNameEC = TextEditingController();
  TextEditingController productPriceEC = TextEditingController();
  TextEditingController productQuantityEC = TextEditingController();
  TextEditingController productCategoryEC = TextEditingController();
  TextEditingController productDiscountEC = TextEditingController();

  //================================== BOOL VALUES ====================================\\

  bool isChecked = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  var isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Add New Item ",
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            // color: kAccentColor,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(
              kDefaultPadding,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 346,
                    height: 144,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          color: Color(
                            0xFFE6E6E6,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icons/image-upload.png",
                          ),
                          kHalfSizedBox,
                          const Text(
                            'Upload product image',
                            style: TextStyle(
                              color: Color(
                                0xFF808080,
                              ),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kSizedBox,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Type',
                        style: TextStyle(
                          color: Color(
                            0xFF575757,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      kHalfSizedBox,
                      DropdownButtonFormField<String>(
                        value: dropDownItemValue,
                        onChanged: dropDownOnChanged,
                        enableFeedback: true,
                        focusNode: productType,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        elevation: 20,
                        validator: (value) {
                          if (value == null) {
                            productType.requestFocus();
                            return "Pick a Product Type";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            borderSide: BorderSide(
                              color: Colors.blue.shade50,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            borderSide: BorderSide(
                              color: Colors.blue.shade50,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            borderSide: BorderSide(
                              color: Colors.blue.shade50,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            borderSide: const BorderSide(
                              color: kErrorBorderColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        iconEnabledColor: kAccentColor,
                        iconDisabledColor: kGreyColor2,
                        items: const [
                          DropdownMenuItem<String>(
                            value: "Food",
                            enabled: true,
                            child: Text(
                              'Food',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "Drinks",
                            enabled: true,
                            child: Text(
                              'Drinks',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "Vegetables",
                            enabled: true,
                            child: Text(
                              "Vegetables",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "Meat",
                            enabled: true,
                            child: Text(
                              "Meat",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      const Text(
                        'Product Name',
                        style: TextStyle(
                          color: Color(
                            0xFF575757,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: productNameEC,
                        focusNode: productNameFN,
                        hintText: "Enter the product name here",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        prefixIcon: const Icon(
                          null,
                        ),
                        suffixIcon: const Icon(
                          null,
                        ),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            productNameFN.requestFocus();
                            return "Enter the product name";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productNameEC.text = value!;
                        },
                      ),
                      kSizedBox,
                      const Text(
                        'Unit Price',
                        style: TextStyle(
                          color: Color(
                            0xFF575757,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: productPriceEC,
                        focusNode: productPriceFN,
                        hintText: "Enter the unit price here",
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(
                          null,
                        ),
                        suffixIcon: const Icon(
                          null,
                        ),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            productPriceFN.requestFocus();
                            return "Enter the unit price";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productPriceEC.text = value!;
                        },
                      ),
                      kSizedBox,
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          color: Color(
                            0xFF575757,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: productQuantityEC,
                        focusNode: productQuantityFN,
                        hintText: "Enter the quantity here",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(
                          null,
                        ),
                        suffixIcon: const Icon(
                          null,
                        ),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            productQuantityFN.requestFocus();
                            return "Enter the quantity";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productQuantityEC.text = value!;
                        },
                      ),
                      kSizedBox,
                      const Text(
                        'Product Category',
                        style: TextStyle(
                          color: Color(
                            0xFF575757,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      kHalfSizedBox,
                      ListTile(
                        enableFeedback: true,
                        onTap: () {},
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kAccentColor,
                        ),
                        title: const Text(
                          'Select Category',
                          style: TextStyle(
                            color: Color(
                              0xFF979797,
                            ),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Special Offer',
                                style: TextStyle(
                                  color: Color(
                                    0xFF222222,
                                  ),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.26,
                                ),
                              ),
                              kHalfWidthSizedBox,
                              Text(
                                '(Optional)',
                                style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.20,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            tooltip: isToggled ? "Turn on" : "Turn off",
                            isSelected: isToggled,
                            onPressed: () {
                              setState(() {
                                isToggled = !isToggled;
                              });
                            },
                            icon: isToggled
                                ? const Icon(
                                    Icons.toggle_off,
                                    color: kGreyColor1,
                                  )
                                : Icon(
                                    Icons.toggle_on,
                                    color: kAccentColor,
                                  ),
                          ),
                        ],
                      ),
                      isToggled
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: false,
                                  fillColor: const MaterialStatePropertyAll(
                                      kGreyColor1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  onChanged: (newValue) {
                                    null;
                                  },
                                ),
                                const Text(
                                  'Free Delivery',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF222222,
                                    ),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.26,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  splashRadius: 50,
                                  activeColor: kAccentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked = newValue!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Free Delivery',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF222222,
                                    ),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.26,
                                  ),
                                ),
                              ],
                            ),
                      isToggled
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: false,
                                  fillColor: const MaterialStatePropertyAll(
                                      kGreyColor1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  onChanged: (newValue) {
                                    null;
                                  },
                                ),
                                const Text(
                                  'Percentage Discount',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF222222,
                                    ),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.26,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isChecked2,
                                  splashRadius: 50,
                                  activeColor: kAccentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked2 = newValue!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Percentage Discount',
                                  style: TextStyle(
                                    color: Color(
                                      0xFF222222,
                                    ),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.26,
                                  ),
                                ),
                              ],
                            ),
                      kSizedBox,
                      const Text(
                        'Set Custom Discount',
                        style: TextStyle(
                          color: Color(
                            0xFF222222,
                          ),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.26,
                        ),
                      ),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: productDiscountEC,
                        validator: (value) {
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        focusNode: productDiscountFN,
                        hintText: "Enter Discount",
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(
                          Icons.percent_rounded,
                          size: 20,
                          color: kBlackColor,
                        ),
                        suffixIcon: const Icon(
                          null,
                        ),
                      ),
                      kSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked3,
                            splashRadius: 50,
                            activeColor: kAccentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                isChecked3 = newValue!;
                              });
                            },
                          ),
                          const Text(
                            'Varieties',
                            style: TextStyle(
                              color: Color(
                                0xFF222222,
                              ),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.26,
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                      isChecked3
                          ? ListTile(
                              enableFeedback: true,
                              onTap: () {},
                              onLongPress: () {
                                const Tooltip(
                                  message: "Select a variety",
                                );
                              },
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: kAccentColor,
                              ),
                              title: const Text(
                                'Select variety',
                                style: TextStyle(
                                  color: Color(
                                    0xFF979797,
                                  ),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : const ListTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                              title: Text(
                                'Select variety',
                                style: TextStyle(
                                  color: Color(
                                    0xFF979797,
                                  ),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                      kHalfSizedBox,
                      isChecked3
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: MyOutlinedElevatedButton(
                                onPressed: () {},
                                buttonTitle: "+ Add a variety",
                                titleFontSize: 16,
                                circularBorderRadius: 20,
                                maximumSizeHeight: 30,
                                maximumSizeWidth: 150,
                                minimumSizeHeight: 30,
                                minimumSizeWidth: 150,
                              ),
                            )
                          : const Align(
                              alignment: Alignment.bottomRight,
                              child: MyDisabledOutlinedElevatedButton(
                                buttonTitle: "+ Add a variety",
                                titleFontSize: 16,
                                circularBorderRadius: 20,
                                maximumSizeHeight: 30,
                                maximumSizeWidth: 150,
                                minimumSizeHeight: 30,
                                minimumSizeWidth: 150,
                              ),
                            ),
                      kSizedBox,
                      MyElevatedButton(
                        onPressed: () {},
                        buttonTitle: "Save",
                        titleFontSize: 14,
                        circularBorderRadius: 20,
                        maximumSizeHeight: 56,
                        maximumSizeWidth: MediaQuery.of(context).size.width,
                        minimumSizeHeight: 56,
                        minimumSizeWidth: MediaQuery.of(context).size.width,
                      ),
                    ],
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
