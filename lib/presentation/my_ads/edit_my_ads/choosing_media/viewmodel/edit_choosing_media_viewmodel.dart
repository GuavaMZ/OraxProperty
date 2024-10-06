import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';

class EditChoosingMediaViewModel extends ChangeNotifier {
  final ImagePicker mediaPicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List prevPropertyImages = [];
  Future adsImagesPicker() async {
    if (ValueHolders.androidVersion.contains('13') ||
        ValueHolders.androidVersion.contains('14')) {
      try {
        await Permission.photos.request();
        await Permission.storage.request();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      try {
        await Permission.storage.request();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    try {
      if (await Permission.photos.isGranted ||
          await Permission.storage.isGranted) {
        try {
          final List<XFile> selectedImages =
              await mediaPicker.pickMultiImage(imageQuality: 60);
          if (selectedImages.isNotEmpty) {
            imageFileList!.addAll(selectedImages);
          }
          if (imageFileList!.length > 5) {
            imageFileList!.removeRange(5, imageFileList!.length);
          }
        } on PlatformException catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  deletePhoto(int index) {
    if (imageFileList!.isEmpty) {
      prevPropertyImages.removeAt(index);
    } else {
      imageFileList!.removeAt(index);
    }
    notifyListeners();
  }

  assignImagesToAdetailsMap(BuildContext context) async {
    EditConfirmBeforeSendViewModel.prevPropertyImages = prevPropertyImages;
    if (imageFileList!.isNotEmpty) {
      for (var element in imageFileList!) {
        EditConfirmBeforeSendViewModel
                .propertyImages['image${imageFileList!.indexOf(element)}'] =
            element.path;
      }
    }
  }
}
