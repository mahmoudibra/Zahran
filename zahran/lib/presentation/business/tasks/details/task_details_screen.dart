import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/tasks/details/question.component.dart';
import 'package:zahran/presentation/business/tasks/details/task_details_view_model.dart';
import 'package:zahran/presentation/commom/brands_view.dart';
import 'package:zahran/presentation/commom/comment_form_field.dart';
import 'package:zahran/presentation/commom/scaffold_list_silver_app_bar.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

typedef CaptureImageCallback = void Function({@required int subBrandIndex, @required int productIndex});

class TaskDetailsScreen extends StatelessWidget {
  final ProgressButtonKey buttonKey = ProgressButtonKey();

  TaskDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TaskDetailsViewModel(context),
        builder: (TaskDetailsViewModel vm) {
          return ScaffoldListSilverAppBar(
            content: content(context, vm),
            title: vm.model.title.format(context),
          );
        });
  }

  Widget content(BuildContext context, TaskDetailsViewModel vm) {
    return Stack(
      children: <Widget>[
        regularTaskContent(context, vm),
        footerSection(context, vm),
      ],
    );
  }

  Widget regularTaskContent(BuildContext context, TaskDetailsViewModel vm) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _brandsRow(vm, context),
          Visibility(
            visible: !(vm.model.description.format(context).isBlank ?? true),
            child: buildDescriptionSection(context, vm),
          ),
          Visibility(
            visible: vm.model.media.length > 0,
            child: ViewsToolbox.emptySpaceWidget(height: 8),
          ),
          if (vm.model.media.length > 0) ...[
            SizedBox(height: 10),
            MediaView(
              media: vm.model.media,
            ),
          ],
          ViewsToolbox.emptySpaceWidget(height: 16),
          Visibility(
            visible: !(vm.model.instructions.format(context).isBlank ?? true),
            child: buildInstructionSection(context, vm),
          ),
          // buildSubBrandsListRow(context, vm),
          // brandsList(vm, context),
          ViewsToolbox.emptySpaceWidget(height: 12),
          Visibility(
            visible: vm.model.questions.isNotEmpty,
            child: buildQuestionSection(context, vm),
          ),
          // brandsList(),
          // Divider(height: 1),
          // taskReports(context, vm),
          // ViewsToolbox.emptySpaceWidget(height: 12),
          // Divider(height: 1),
          ViewsToolbox.emptySpaceWidget(height: 70),
        ],
      ),
    );
  }

  // Widget taskReports(BuildContext context, TaskDetailsViewModel vm) {
  //   return GestureDetector(
  //     onTap: vm.showReportListAction(),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Image.asset(R.assetsImagesReportIcon),
  //         ViewsToolbox.emptySpaceWidget(width: 6),
  //         Expanded(
  //           child: Text(TR.of(context).reports, style: Theme.of(context).textTheme.headline6),
  //         ),
  //         _buildSeeAllButton(context, vm.seeAllReportAction, TR.of(context).see_all),
  //       ],
  //     ),
  //   );
  // }

  Widget buildDescriptionSection(BuildContext context, TaskDetailsViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ViewsToolbox.emptySpaceWidget(height: 12),
        Text(
          TR.of(context).task_description,
          style: Theme.of(context).textTheme.headline6,
        ),
        ViewsToolbox.emptySpaceWidget(height: 4),
        Text(vm.model.description.format(context), style: Theme.of(context).textTheme.subtitle2),
      ],
    );
  }

  Widget buildInstructionSection(BuildContext context, TaskDetailsViewModel vm) {
    if (vm.model.instructions.format(context).isBlank ?? false) {
      return ViewsToolbox.emptyWidget();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1),
        ViewsToolbox.emptySpaceWidget(height: 10),
        Text(
          TR.of(context).action_to_be_done,
          style: Theme.of(context).textTheme.headline6,
        ),
        ViewsToolbox.emptySpaceWidget(height: 8),
        Text(
          vm.model.instructions.format(context),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        ViewsToolbox.emptySpaceWidget(height: 16),
      ],
    );
  }

  Widget buildSubBrandsListRow(BuildContext context, TaskDetailsViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1),
        ViewsToolbox.emptySpaceWidget(height: 16),
        Text(
          TR.of(context).brands_list_num(vm.model.brands.length.toString()),
          style: Theme.of(context).textTheme.headline6,
        ),
        ViewsToolbox.emptySpaceWidget(height: 8),
      ],
    );
  }

  Widget buildQuestionSection(BuildContext context, TaskDetailsViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1),
        ViewsToolbox.emptySpaceWidget(height: 16),
        Text(
          TR.of(context).task_question,
          style: Theme.of(context).textTheme.headline6,
        ),
        ViewsToolbox.emptySpaceWidget(height: 8),
        vm.model.questions.length != 0 ? buildQuestionComponent(vm) : ViewsToolbox.emptySpaceWidget(),
        ViewsToolbox.emptySpaceWidget(height: 12),
      ],
    );
  }

  Widget footerSection(BuildContext context, TaskDetailsViewModel vm) {
    return Positioned(
      right: 16,
      left: 16,
      bottom: 24,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ProgressButton(
              onPressed: vm.model.isCompleted.onFalse(() async {
                return vm.completeTaskAction();
              }),
              key: buttonKey,
              child: Text(TR.of(context).complete_task),
            ),
          )

          // Flexible(
          //         flex: 2,
          //         child: SizedBox(
          //           height: 48,
          //           child: FlatButton(
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          //             color: Color(0xFF45F3F6), //TODO: change this later
          //             onPressed: vm.completeTaskAction(),
          //             child: Center(
          //               child: Text(
          //                 TR.of(context).complete_task,
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .subtitle1
          //                     ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          // vm.model.isCompleted ? ViewsToolbox.emptyWidget() : ViewsToolbox.emptySpaceWidget(width: 6),
          // Flexible(
          //   flex: 1,
          //   child: Center(
          //     child: SizedBox(
          //       height: 48,
          //       child: FlatButton(
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          //         color: Color(0xFF45F3F6), //TODO: change this later
          //         onPressed: vm.addReportAction(),
          //         child: Center(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisSize: MainAxisSize.max,
          //             children: [
          //               Image.asset(R.assetsImagesReportIcon, color: Colors.white),
          //               Text(
          //                 TR.of(context).report,
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .subtitle1
          //                     ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  // Widget brandsList(TaskDetailsViewModel vm, BuildContext context) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: vm.model.brands.length,
  //     itemBuilder: (context, index) {
  //       return TaskBrandRow(
  //         subBrands: vm.model.brands[index],
  //         captureImageCallback: ({int? productIndex}) {
  //           vm.pickImageAction(brandIndex: index, productIndex: productIndex!);
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _brandsRow(TaskDetailsViewModel vm, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              BrandsView(brands: vm.model.brands),
              Text(vm.model.brands.first.name.format(context)),
            ],
          ),
        ),
        SizedBox(width: 5),
        _buildSeeAllButton(context, vm.seeAllBrandsAction, TR.of(context).see_all),
      ],
    );
  }

  Directionality _buildSeeAllButton(BuildContext context, VoidCallback callback, String label) {
    return Directionality(
      textDirection: Directionality.of(context) == TextDirection.rtl ? TextDirection.ltr : TextDirection.rtl,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.only(top: 5, bottom: 5, end: 10),
        ),
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.theme.accentColor,
          size: 20,
        ),
        onPressed: callback,
        label: Text(label),
      ),
    );
  }

  Widget buildQuestionComponent(TaskDetailsViewModel vm) {
    return Container(
        height: 350,
        child: QuestionComponent(
          questionTextChangeCallback: ({required int index, required String textChange}) {
            vm.questionTextChangeAction(questionIndex: index, textChange: textChange);
          },
          questionSelectionChangeCallback: ({required int index, required int selectionIndex}) {
            vm.questionSelectionChangeAction(questionIndex: index, selectionIndex: selectionIndex);
          },
          questionDateChangeCallback: ({required int index, required DateTime selectedDate}) {
            vm.questionDateChangeAction(questionIndex: index, selectedDate: selectedDate);
          },
          questionMediaRemoveCallback: ({required int index, required int removeMediaIndex}) {
            vm.questionMediaRemoveAction(questionIndex: index, removeMediaIndex: removeMediaIndex);
          },
          questionMediaChooseCallback: ({required int index}) {
            vm.questionMediaChooseCallback(questionIndex: index);
          },
          questions: vm.model.questions,
        ));
  }
}
