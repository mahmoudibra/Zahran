import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/data/repo/question.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/domain/models/question_types.enum.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';
import 'package:zahran/presentation/business/visits/visits_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/helpers/date/date-manager.dart';
import 'package:zahran/presentation/localization/tr.dart';
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

  MediaPickerType mediaPickerType = MediaPickerType.BOTH;
  MediaLocal? mediaFile;
  int? uploadedMediaId;

  // List<BrandProductTaskMedia> brandProductTaskMedia = [];

  TaskDetailsViewModel(this.context) : super(context);

  // showReportListAction() {
  //   print(" 🚀🚀🚀🚀 Report list action");
  // }

  // addReportAction() {
  //   print(" 🚀🚀🚀🚀 Route to add report");
  // }

  completeTaskAction() async {
    // await FlareAnimation.show<EmptyModel?>(action: Repos.taskRepo.completeTask(taskId: model.id), context: context);
    if (_checkAllMandatoryQuestionAreAnswered()) {
      try {
        await Repos.questionRepo.answerTaskQuestions(model.id, _prepareAnswers());
        await Repos.taskRepo.completeTask(taskId: model.id);
        model = model.copyWith(isCompleted: true);
        getController<VisitDetailsViewModel>()?.setTaskCompleted(model.id);
        getController<VisitsViewModel>()?.setTaskCompleted(model.id);

        context.primarySnackBar(TR.of(context).task_completed_successfully(model.title.format(context)));
      } catch (error) {
        if (!(error is ApiFetchException)) {
          context.errorSnackBar(TR.of(context).un_expected_error);
        }
      }
    } else {
      context.errorSnackBar(TR.of(context).answer_all_mandatory_question_first);
    }
  }

  List<AnswerRequest> _prepareAnswers() {
    return model.questions.map<AnswerRequest>((question) => AnswerRequest.fromQuestionModel(question)).toList();
  }

  bool _checkAllMandatoryQuestionAreAnswered() {
    var filteredMandatoryQuestions = model.questions.where((element) => element.mandatory);

    var unAnsweredQuestions = filteredMandatoryQuestions.where((element) {
      if (element.answerType == QuestionTypes.MEDIA.value) {
        return element.selectedMultimedia.length == 0;
      } else {
        return element.answerText.isEmpty;
      }
    });

    return unAnsweredQuestions.isEmpty;
  }

  seeAllBrandsAction() {
    ScreenNames.BRANDS_LIST.push(model.visitId);
  }

  seeAllReportAction() {
    print(" 🚀🚀🚀🚀 on See all brands clicked");
  }

  // pickImageAction({required int brandIndex, required int productIndex}) {
  //   ScreenRouter.showPopup(
  //       type: PopupsNames.MEDIA_PICKER_POPUP,
  //       parameters: _prepareMediaParameter(),
  //       actionsCallbacks: _prepareMediaAction(brandIndex: brandIndex, productIndex: productIndex));
  // }

  pickImageForQuestionAction({required int questionIndex}) {
    // ScreenRouter.showBottomSheet(
    //     type: BottomSheetNames.VOICE_NOTE,
    //     parameters: _prepareVoiceNoteParameter(voiceNoteIntent: VoiceNoteIntent.Record),
    //     actionsCallbacks: _prepareVoiceNoteActions(questionIndex: questionIndex));

    ScreenRouter.showPopup(
        type: PopupsNames.MEDIA_PICKER_POPUP,
        parameters: _prepareMediaParameter(),
        actionsCallbacks: _prepareMediaActionForQuestions(questionIndex: questionIndex));
  }

  Map<String, dynamic>? _prepareMediaParameter() {
    Map<String, dynamic>? parameters = Map();
    parameters["pickerType"] = mediaPickerType;
    return parameters;
  }

  // Map<String, dynamic>? _prepareVoiceNoteParameter(
  //     {required VoiceNoteIntent voiceNoteIntent, File? voiceNoteFile, String? voiceNoteUrl}) {
  //   Map<String, dynamic>? parameters = Map();
  //   parameters["voiceNoteIntent"] = voiceNoteIntent;
  //   parameters["voiceNoteFile"] = voiceNoteFile;
  //   parameters["voiceNoteUrl"] = voiceNoteUrl;
  //   return parameters;
  // }

  Future<void> selectImage() async {}

  // Map<String, Function> _prepareMediaAction({required int brandIndex, required int productIndex}) {
  //   print("🚀🚀🚀🚀 Heeeereeeeeeeeee");
  //   Map<String, Function> actionsCallbacks = Map();
  //   actionsCallbacks['mediaPickerCallback'] = (MediaLocal? mediaModel) => {
  //         mediaFile = mediaModel,
  //         FlareAnimation.show(
  //             action: _uploadMedia(brandIndex: brandIndex, productIndex: productIndex), context: context)
  //       };
  //   actionsCallbacks['dismissCallback'] = () => {print("🚀🚀🚀🚀 User Dismissed")};
  //
  //   return actionsCallbacks;
  // }

  Map<String, Function> _prepareMediaActionForQuestions({required int questionIndex}) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['mediaPickerCallback'] = (MediaLocal? mediaModel) => {
          mediaFile = mediaModel,
          FlareAnimation.show(action: _uploadMediaForQuestion(questionIndex: questionIndex), context: context)
        };
    actionsCallbacks['dismissCallback'] = () => {print("🚀🚀🚀🚀 User Dismissed")};

    return actionsCallbacks;
  }

  // Map<String, Function> _prepareVoiceNoteActions({required int questionIndex}) {
  //   Map<String, Function> actionsCallbacks = Map();
  //   actionsCallbacks['onAcceptNoteCallback'] = (File? file) => {
  //         ScreenRouter.pop(),
  //         print("🚀🚀🚀🚀 onAcceptNoteCallback done with file $file}"),
  //         mediaFile = MediaLocal(mediaFile: file!, mediaFileTypes: MediaFileTypes.AUDIO),
  //         // FlareAnimation.show(action: _uploadMediaForQuestion(questionIndex: questionIndex), context: context)
  //       };
  //   actionsCallbacks['onCloseNoteCallback'] = () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Close Note Callback")};
  //   actionsCallbacks['onRemoveNoteCallback'] = () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Remove Note Callback")};
  //
  //   return actionsCallbacks;
  // }

  // Future<void> _uploadMedia({required int brandIndex, required int productIndex}) async {
  //   try {
  //     var uploadedMedia = await Repos.mediaRepo.uploadMedia(uploadedFile: mediaFile!.mediaFile);
  //     model.brands[brandIndex].products[productIndex].media = uploadedMedia!.path;
  //     brandProductTaskMedia.add(BrandProductTaskMedia(
  //         brandId: model.brands[brandIndex].id,
  //         productId: model.brands[brandIndex].products[productIndex].id,
  //         uploadedMedia: uploadedMedia.id));
  //     print("🚀🚀🚀 Media hahahah: $brandProductTaskMedia ");
  //     update();
  //   } catch (error) {
  //     print("🚀🚀🚀 exception while uploading media: $error ");
  //   }
  // }

  Future<void> _uploadMediaForQuestion({required int questionIndex}) async {
    try {
      await mediaFile?.compressVideo();
      await mediaFile?.extractVideoThumbnailFromFile();
      var uploadedMedia = await Repos.mediaRepo.uploadMedia(
          uploadedFile: mediaFile!.mediaFile, mediaFileTypes: mediaFile?.mediaFileTypes ?? MediaFileTypes.IMAGE);
      model.questions[questionIndex].answerMediaList.add(uploadedMedia!.id);
      model.questions[questionIndex].selectedMultimedia.add(mediaFile!);
      update();
    } catch (error) {
      print("🚀🚀🚀 exception while uploading media: $error ");
      if (!(error is ApiFetchException)) {
        context.errorSnackBar(TR.of(context).un_expected_error);
      }
    }
  }

  questionTextChangeAction({required int questionIndex, required String textChange}) {
    model.questions[questionIndex].answerText = textChange;
    print("${model.questions}");
    update();
  }

  questionSelectionChangeAction({required int questionIndex, required int selectionIndex}) {
    model.questions[questionIndex].answerText = model.questions[questionIndex].options[selectionIndex].value;
    update();
    print("${model.questions[questionIndex]}");
  }

  questionMediaRemoveAction({required int questionIndex, required int removeMediaIndex}) {
    model.questions[questionIndex].selectedMultimedia.removeAt(removeMediaIndex);
    model.questions[questionIndex].answerMediaList.removeAt(removeMediaIndex);
    update();
  }

  questionDateChangeAction({required int questionIndex, required DateTime selectedDate}) {
    model.questions[questionIndex].answerText = DateTimeManager.convertDateTimeToAppFormat(selectedDate);
    print("${model.questions}");
    update();
  }

  questionMediaChooseCallback({required int questionIndex}) {
    pickImageForQuestionAction(questionIndex: questionIndex);
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
