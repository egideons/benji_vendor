// ignore_for_file: unused_element, unused_local_variable, empty_catches

import 'package:benji_vendor/src/model/product_type_model.dart';
import 'package:benji_vendor/src/model/sub_category.dart';
import 'package:get/get.dart';

class ProductPropertyController extends GetxController {
  static ProductPropertyController get instance {
    return Get.find<ProductPropertyController>();
  }

  var isLoadProductType = false.obs;
  var isLoadSubCategory = false.obs;
  var subCategory = <SubCategory>[].obs;
  var productType = <ProductTypeModel>[].obs;

  Future getSubCategoriesFunc() async {
    isLoadSubCategory.value = true;
    update();
    subCategory.value = await getSubCategories(0, 100);
    isLoadSubCategory.value = false;
    update();
  }

  Future getProductTypeFunc() async {
    isLoadProductType.value = false;
    update();
    productType.value = await getProductType(0, 100);
    isLoadProductType.value = false;
    update();
  }
}
