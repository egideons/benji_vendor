import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  static ImageController get instance {
    return Get.find<ImageController>();
  }

  var isLoad = false.obs;

  Future<void> getLostData(handleLostFiles, handleError) async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {
      handleLostFiles(files);
    } else {
      handleError(response.exception);
    }
  }
}
