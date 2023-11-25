// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member

import 'dart:async';
import 'dart:io';

import 'package:benji_vendor/app/google_maps/get_location_on_map.dart';
import 'package:benji_vendor/src/components/button/my%20elevatedButton.dart';
import 'package:benji_vendor/src/components/input/my_intl_phonefield.dart';
import 'package:benji_vendor/src/components/input/my_maps_textformfield.dart';
import 'package:benji_vendor/src/components/input/name_textformfield.dart';
import 'package:benji_vendor/src/components/section/location_list_tile.dart';
import 'package:benji_vendor/src/components/section/my_floating_snackbar.dart';
import 'package:benji_vendor/src/controller/latlng_detail_controller.dart';
import 'package:benji_vendor/src/controller/user_controller.dart';
import 'package:benji_vendor/src/googleMaps/autocomplete_prediction.dart';
import 'package:benji_vendor/src/googleMaps/places_autocomplete_response.dart';
import 'package:benji_vendor/src/providers/keys.dart';
import 'package:benji_vendor/src/providers/network_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../theme/colors.dart';
import '../../controller/form_controller.dart';
import '../../controller/push_notifications_controller.dart';
import '../../providers/api_url.dart';
import '../../providers/constants.dart';
import '../image/my_image.dart';

class PersonalInfoBody extends StatefulWidget {
  const PersonalInfoBody({Key? key}) : super(key: key);

  @override
  State<PersonalInfoBody> createState() => _PersonalInfoBodyState();
}

class _PersonalInfoBodyState extends State<PersonalInfoBody> {
  //==========================================================================================\\
  @override
  void initState() {
    super.initState();
    userCode = UserController.instance.user.value.code;
    firstNameEC.text = UserController.instance.user.value.firstName;
    lastNameEC.text = UserController.instance.user.value.lastName;
    mapsLocationEC.text = UserController.instance.user.value.address;
    userPhoneNumberEC.text = UserController.instance.user.value.phone;
    latitude = UserController.instance.user.value.latitude;
    longitude = UserController.instance.user.value.longitude;
    horizontalGroupValue = UserController.instance.user.value.gender;
    profileLogo = UserController.instance.user.value.profileLogo;
    consoleLog("This is the profile logo url: $profileLogo");
  }

  @override
  void dispose() {
    super.dispose();
    selectedLocation.dispose();
    scrollController.dispose();
  }

//==========================================================================================\\

//======================================== ALL VARIABLES ==============================================\\
  final String countryDialCode = '+234';
  String? userCode;
  String? latitude;
  String? longitude;
  List<AutocompletePrediction> placePredictions = [];
  final selectedLocation = ValueNotifier<String?>(null);
  final genders = ["Male", "Female"];
  String? horizontalGroupValue;
  String? profileLogo;

  //=========================== BOOL VALUES ====================================\\

  bool isTyping = false;

  //======================================== GLOBAL KEYS ==============================================\\
  final formKey = GlobalKey<FormState>();

  //=========================== CONTROLLERS ====================================\\
  final scrollController = ScrollController();
  final userNameEC = TextEditingController();
  final firstNameEC = TextEditingController();
  final lastNameEC = TextEditingController();
  final mapsLocationEC = TextEditingController();
  final LatLngDetailController latLngDetailController =
      LatLngDetailController.instance;
  final userPhoneNumberEC = TextEditingController();

  //=========================== FOCUS NODES ====================================\\
  final userPhoneNumberFN = FocusNode();
  final userNameFN = FocusNode();
  final firstNameFN = FocusNode();
  final lastNameFN = FocusNode();
  final mapsLocationFN = FocusNode();

//=========================== IMAGE PICKER ====================================\\

  final ImagePicker _picker = ImagePicker();
  File? selectedLogoImage;
  //================================== function ====================================\\

  pickLogoImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );
    if (image != null) {
      selectedLogoImage = File(image.path);
      Get.back();
      setState(() {});
    }
  }

  //========================================================================\\
  //=========================== FUNCTIONS ====================================\\
  //Google Maps
  setLocation(index) async {
    final newLocation = placePredictions[index].description!;
    selectedLocation.value = newLocation;

    setState(() {
      mapsLocationEC.text = newLocation;
    });

    List<Location> location = await locationFromAddress(newLocation);
    latitude = location[0].latitude.toString();
    longitude = location[0].longitude.toString();
  }

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        '/maps/api/place/autocomplete/json', //unencoder path
        {
          "input": query, //query params
          "key": googlePlacesApiKey, //google places api key
        });

    String? response = await NetworkUtility.fetchUrl(uri);
    PlaceAutocompleteResponse result =
        PlaceAutocompleteResponse.parseAutoCompleteResult(response!);
    if (result.predictions != null) {
      setState(() {
        placePredictions = result.predictions!;
      });
    }
  }

  void getLocationOnMap() async {
    await Get.to(
      () => const GetLocationOnMap(),
      routeName: 'GetLocationOnMap',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    latitude = latLngDetailController.latLngDetail.value[0];
    longitude = latLngDetailController.latLngDetail.value[1];
    mapsLocationEC.text = latLngDetailController.latLngDetail.value[2];
    latLngDetailController.setEmpty();
    if (kDebugMode) {
      print("LATLNG: $latitude,$longitude");
      print(mapsLocationEC.text);
    }
  }

  Future<void> updateData() async {
    // if (selectedLogoImage == null && profileLogo!.isEmpty) {
    //   ApiProcessorController.errorSnack("Please select a logo image");
    //   return;
    // }
    Map data = {
      'first_name': firstNameEC.text,
      'last_name': lastNameEC.text,
      'address': mapsLocationEC.text,
      'gender': horizontalGroupValue,
      'phone': userPhoneNumberEC.text,
      'latitude': latitude,
      'longitude': longitude,
    };
    consoleLog("This is the data: $data");
    consoleLog(
        Api.baseUrl + Api.changeVendorBusinessProfile + vendorId.toString());
    consoleLog("profile logo: $selectedLogoImage");
    await FormController.instance.postAuthstream(
        Api.baseUrl + Api.changeVendorPersonalProfile + vendorId.toString(),
        data,
        {'profileLogo': selectedLogoImage},
        "changeVendorPersonalProfile");
    if (FormController.instance.status.toString().startsWith('2')) {}
    await PushNotificationController.showNotification(
      title: "Success.",
      body: "Your personal profile has been successfully updated.",
    );
    Get.close(1);
  }

  //===================== COPY TO CLIPBOARD =======================\\
  void copyToClipboard(BuildContext context, String userCode) {
    Clipboard.setData(
      ClipboardData(text: userCode),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
      kSuccessColor,
      "Success!",
      "ID copied to clipboard",
      const Duration(seconds: 2),
    );
  }

  Widget uploadLogoImage() => Container(
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
              "Upload Logo Image",
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
                        pickLogoImage(ImageSource.camera);
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
                        pickLogoImage(ImageSource.gallery);
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
                            FontAwesomeIcons.images,
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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scrollbar(
        controller: scrollController,
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(kDefaultPadding),
          physics: const BouncingScrollPhysics(),
          children: [
            GetBuilder<UserController>(
              builder: (controller) {
                return Container(
                  width: media.width,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username: ${controller.user.value.username}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: kTextBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Business Email: ${controller.user.value.email}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: kTextBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            userCode!,
                            softWrap: true,
                            style: const TextStyle(
                              color: kTextBlackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              copyToClipboard(context, userCode!);
                            },
                            tooltip: "Copy ID",
                            mouseCursor: SystemMouseCursors.click,
                            icon: FaIcon(
                              FontAwesomeIcons.solidCopy,
                              size: 14,
                              color: kAccentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            kSizedBox,
            const Divider(thickness: 4),
            kSizedBox,
            Text(
              "Edit your Business Logo".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 20,
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
            Column(
              children: [
                selectedLogoImage == null
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
                          child: MyImage(url: profileLogo!),

                          //           CachedNetworkImage(
                          //     imageUrl: profileLogo!,
                          //     fit: BoxFit.cover,
                          //     progressIndicatorBuilder:
                          //         (context, url, downloadProgress) => Center(
                          //             child: CupertinoActivityIndicator(
                          //                 color: kAccentColor)),
                          //     errorWidget: (context, url, error) =>
                          //         Icon(Icons.error, color: kAccentColor),
                          // ),
                        ),
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        decoration: ShapeDecoration(
                          shape: const OvalBorder(),
                          image: DecorationImage(
                            image: FileImage(selectedLogoImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                kHalfSizedBox,
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
                      builder: ((builder) => uploadLogoImage()),
                    );
                  },
                  splashColor: kAccentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Upload business logo',
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
            kSizedBox,
            const Divider(thickness: 4),
            kSizedBox,
            Text(
              "Edit your personal profile".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Your personal profile is not visible to users",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kAccentColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            kSizedBox,
            Form(
              key: formKey,
              child: ValueListenableBuilder(
                  valueListenable: selectedLocation,
                  builder: (context, selectedLocationValue, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kSizedBox,
                        Text(
                          "First Name".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfSizedBox,
                        NameTextFormField(
                          controller: firstNameEC,
                          hintText: "Enter your first name",
                          nameFocusNode: firstNameFN,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            RegExp namePattern =
                                RegExp(r'^.{3,}$'); //Min. of 3 characters
                            if (value == null || value!.isEmpty) {
                              firstNameFN.requestFocus();
                              return "Enter your first name";
                            } else if (!namePattern.hasMatch(value)) {
                              firstNameFN.requestFocus();
                              return "Name must be at least 3 characters";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            firstNameEC.text = value;
                          },
                        ),
                        kSizedBox,
                        Text(
                          "Last Name".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfSizedBox,
                        NameTextFormField(
                          controller: lastNameEC,
                          hintText: "Enter your last name",
                          nameFocusNode: lastNameFN,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            RegExp namePattern =
                                RegExp(r'^.{3,}$'); //Min. of 3 characters
                            if (value == null || value!.isEmpty) {
                              lastNameFN.requestFocus();
                              return "Enter your last name";
                            } else if (!namePattern.hasMatch(value)) {
                              lastNameFN.requestFocus();
                              return "Name must be at least 3 characters";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            lastNameEC.text = value;
                          },
                        ),
                        kSizedBox,
                        Text(
                          "Gender".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfSizedBox,
                        RadioGroup<String>.builder(
                          groupValue: horizontalGroupValue!,
                          direction: Axis.horizontal,
                          activeColor: kAccentColor,
                          onChanged: (value) => setState(() {
                            horizontalGroupValue = value!;
                          }),
                          items: genders,
                          itemBuilder: (item) => RadioButtonBuilder(item),
                        ),
                        kSizedBox,
                        Text(
                          "Phone Number".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfSizedBox,
                        MyIntlPhoneField(
                          controller: userPhoneNumberEC,
                          initialCountryCode: "NG",
                          invalidNumberMessage: "Invalid phone number",
                          dropdownIconPosition: IconPosition.trailing,
                          showCountryFlag: true,
                          showDropdownIcon: true,
                          dropdownIcon: Icon(Icons.arrow_drop_down_rounded,
                              color: kAccentColor),
                          textInputAction: TextInputAction.next,
                          focusNode: userPhoneNumberFN,
                          validator: (value) {
                            if (value == null ||
                                userPhoneNumberEC.text.isEmpty) {
                              return "Field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            userPhoneNumberEC.text = value!;
                          },
                        ),
                        kSizedBox,
                        Text(
                          "Address".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfSizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Location on Google maps',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            kHalfSizedBox,
                            MyMapsTextFormField(
                              controller: mapsLocationEC,
                              validator: (value) {
                                if (value == null) {
                                  mapsLocationFN.requestFocus();
                                  "Enter a location";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                placeAutoComplete(value);
                                setState(() {
                                  selectedLocation.value = value;
                                  isTyping = true;
                                });
                                if (kDebugMode) {
                                  print(
                                      "ONCHANGED VALUE: ${selectedLocation.value}");
                                }
                              },
                              textInputAction: TextInputAction.done,
                              focusNode: mapsLocationFN,
                              hintText: "Search a location",
                              textInputType: TextInputType.text,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: kAccentColor,
                                  size: 18,
                                ),
                              ),
                            ),
                            kSizedBox,
                            Divider(
                              height: 10,
                              thickness: 2,
                              color: kLightGreyColor,
                            ),
                            ElevatedButton.icon(
                              onPressed: getLocationOnMap,
                              icon: FaIcon(
                                FontAwesomeIcons.locationArrow,
                                color: kAccentColor,
                                size: 18,
                              ),
                              label: const Text("Locate on map"),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: kLightGreyColor,
                                foregroundColor: kTextBlackColor,
                                fixedSize: Size(media.width, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Divider(
                              height: 10,
                              thickness: 2,
                              color: kLightGreyColor,
                            ),
                            const Text(
                              "Suggestions:",
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kHalfSizedBox,
                            SizedBox(
                              height: () {
                                if (isTyping == false) {
                                  return 0.0;
                                }
                                if (isTyping == true) {
                                  return 150.0;
                                }
                              }(),
                              child: Scrollbar(
                                controller: scrollController,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: placePredictions.length,
                                  itemBuilder: (context, index) =>
                                      LocationListTile(
                                    onTap: () => setLocation(index),
                                    location:
                                        placePredictions[index].description!,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        kSizedBox,
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: GetBuilder<FormController>(
                init: FormController(),
                builder: (saving) {
                  return MyElevatedButton(
                    onPressed: (() async {
                      if (formKey.currentState!.validate()) {
                        updateData();
                      }
                    }),
                    isLoading: saving.isLoad.value,
                    title: "Save",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
