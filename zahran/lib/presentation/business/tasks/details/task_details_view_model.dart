import 'package:flutter/material.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/commom/media_picker/media_local.domain.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class BrandProductTaskMedia {
  int brandId;
  int productId;
  int uploadedMedia;

  BrandProductTaskMedia({required this.brandId, required this.productId, required this.uploadedMedia});
}

class TaskDetailsViewModel extends BaseDetailsViewModel<TaskModel> {
  final BuildContext context;
  Promotion promotion = Promotion.empty();

  MediaPickerType mediaPickerType = MediaPickerType.CAMERA_WITH_GALLERY;
  MediaLocal? mediaFile;
  int? uploadedMediaId;

  List<BrandProductTaskMedia> brandProductTaskMedia = [];

  TaskDetailsViewModel(this.context) : super(context);

  showReportListAction() {
    print(" 🚀🚀🚀🚀 Report list action");
  }

  addReportAction() {
    print(" 🚀🚀🚀🚀 Route to add report");
  }

  completeTaskAction() {
    print(" 🚀🚀🚀🚀 on complete task Action");
  }

  seeAllBrandsAction() {
    ScreenNames.BRANDS_LIST.push(model.visitId);
  }

  seeAllReportAction() {
    print(" 🚀🚀🚀🚀 on See all brands clicked");
  }

  pickImageAction({required int brandIndex, required int productIndex}) {
    ScreenRouter.showPopup(
        type: PopupsNames.MEDIA_PICKER_POPUP,
        parameters: _prepareMediaParameter(),
        actionsCallbacks: _prepareMediaAction(brandIndex: brandIndex, productIndex: productIndex));
  }

  Map<String, dynamic>? _prepareMediaParameter() {
    Map<String, dynamic>? parameters = Map();
    parameters["pickerType"] = mediaPickerType;
    return parameters;
  }

  Future<void> selectImage() async {}

  Map<String, Function> _prepareMediaAction({required int brandIndex, required int productIndex}) {
    print("🚀🚀🚀🚀 Heeeereeeeeeeeee");
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['mediaPickerCallback'] = (MediaLocal? mediaModel) => {
          mediaFile = mediaModel,
          FlareAnimation.show(
              action: _uploadMedia(brandIndex: brandIndex, productIndex: productIndex), context: context)
        };
    actionsCallbacks['dismissCallback'] = () => {print("🚀🚀🚀🚀 User Dismissed")};

    return actionsCallbacks;
  }

  Future<void> _uploadMedia({required int brandIndex, required int productIndex}) async {
    try {
      var uploadedMedia = await Repos.mediaRepo.uploadMedia(uploadedFile: mediaFile!.mediaFile);
      model.brands[brandIndex].products[productIndex].media = uploadedMedia!.path;
      brandProductTaskMedia.add(BrandProductTaskMedia(
          brandId: model.brands[brandIndex].id,
          productId: model.brands[brandIndex].products[productIndex].id,
          uploadedMedia: uploadedMedia.id));
      print("🚀🚀🚀 Media hahahah: $brandProductTaskMedia ");
      update();
    } catch (error) {
      print("🚀🚀🚀 exception while uploading media: $error ");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
