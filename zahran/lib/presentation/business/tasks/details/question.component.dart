import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusable/reusable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/domain/models/question_types.enum.dart';
import 'package:zahran/presentation/business/tasks/details/question_media_row.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../../../../r.dart';

typedef QuestionTextChangeCallback = Function({required int index, required String textChange});

typedef QuestionSelectionChangeCallback = Function({required int index, required int selectionIndex});

typedef QuestionDateChangeCallback = Function({required int index, required DateTime selectedDate});

typedef QuestionMediaChooseCallback = Function({required int index});

typedef QuestionMediaRemoveCallback = Function({required int index, required int removeMediaIndex});

class QuestionComponent extends StatefulWidget {
  final List<Question> questions;

  final QuestionTextChangeCallback questionTextChangeCallback;
  final QuestionSelectionChangeCallback questionSelectionChangeCallback;
  final QuestionDateChangeCallback questionDateChangeCallback;
  final QuestionMediaChooseCallback questionMediaChooseCallback;
  final QuestionMediaRemoveCallback questionMediaRemoveCallback;

  QuestionComponent({
    required this.questionTextChangeCallback,
    required this.questionSelectionChangeCallback,
    required this.questionDateChangeCallback,
    required this.questionMediaChooseCallback,
    required this.questionMediaRemoveCallback,
    required this.questions,
  });

  @override
  _QuestionComponentState createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  Duration scrollDuration = Duration(seconds: 1);
  int scrollableIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: const EdgeInsets.all(8.0), child: buildQuestionComponent()),
    );
  }

  Widget buildQuestionComponent() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 4,
            )
          ],
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TR.of(context).questions(decideMandatoryOrNot()),
                  style: Theme.of(context).textTheme.headline6,
                ),
                ViewsToolbox.emptySpaceWidget(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _previousAction();
                      },
                      child: Image.asset(R.assetsImagesPreviousArrow),
                    ),
                    Expanded(
                        child: Text(
                      TR.of(context).questions("${scrollableIndex + 1}/${widget.questions.length}"),
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    )),
                    GestureDetector(
                      onTap: () {
                        _nextAction();
                      },
                      child: Image.asset(R.assetsImagesNextArrow),
                    )
                  ],
                ),
                ViewsToolbox.emptySpaceWidget(height: 10),
                Flexible(child: buildScrollableList())
              ],
            )));
  }

  String decideMandatoryOrNot() {
    return widget.questions[scrollableIndex].mandatory ? TR.of(context).mandatory : TR.of(context).optional;
  }

  Widget buildScrollableList() {
    return ScrollablePositionedList.separated(
      itemCount: widget.questions.length,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => ViewsToolbox.emptySpaceWidget(width: 15),
      itemBuilder: (context, index) {
        return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return _decideQuestionType(widget.questions[index], index);
        });
      },
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget buildTextQuestion({required int index}) {
    return TextQuestionPromotionalTaskComponent(
      onTextChangeCallback: (text) {
        widget.questionTextChangeCallback(index: index, textChange: text);
      },
      questionModel: widget.questions[index],
    );
  }

  Widget buildNumberTextQuestion({required int index}) {
    return NumericalTextQuestionPromotionalTaskComponent(
      onTextChangeCallback: (text) {
        widget.questionTextChangeCallback(index: index, textChange: text);
      },
      questionModel: widget.questions[index],
    );
  }

  Widget buildDateQuestion({required int index}) {
    return DateQuestionPromotionalTaskComponent(
      onChangeDateSelect: (onChangeDateSelect) {
        widget.questionDateChangeCallback(index: index, selectedDate: onChangeDateSelect);
      },
      questionModel: widget.questions[index],
    );
  }

  Widget buildMediaQuestion({required int index}) {
    return MediaQuestionPromotionalTaskComponent(
      onMediaSelectCallback: () {
        widget.questionMediaChooseCallback(index: index);
      },
      onRemoveMediaCallback: (int mediaRemoveIndex) {
        print("🚀🚀🚀🚀🚀 with removed index of $mediaRemoveIndex");
        widget.questionMediaRemoveCallback(index: index, removeMediaIndex: mediaRemoveIndex);
      },
      questionModel: widget.questions[index],
    );
  }

  Widget buildOptionsQuestions(int index) {
    return SelectionsQuestionPromotionalTaskComponent(
      onChooseOptionIndex: (int selectedIndex) {
        widget.questionSelectionChangeCallback(index: index, selectionIndex: selectedIndex);
      },
      questionModel: widget.questions[index],
    );
  }

  // functions
  void _nextAction() {
    if (scrollableIndex + 1 < widget.questions.length) {
      setState(() {
        scrollableIndex++;
      });
      itemScrollController.scrollTo(
        index: scrollableIndex,
        duration: scrollDuration,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _previousAction() {
    if (scrollableIndex + 1 > 1) {
      setState(() {
        scrollableIndex--;
      });
      itemScrollController.scrollTo(
        index: scrollableIndex,
        duration: scrollDuration,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Widget _decideQuestionType(Question question, int index) {
    Widget widget;
    if (question.answerType == QuestionTypes.TEXT.value) {
      widget = buildTextQuestion(index: index);
    } else if (question.answerType == QuestionTypes.MEDIA.value) {
      widget = buildMediaQuestion(index: index);
    } else if (question.answerType == QuestionTypes.DATE.value) {
      widget = buildDateQuestion(index: index);
    } else if (question.answerType == QuestionTypes.SELECT.value) {
      widget = buildOptionsQuestions(index);
    } else {
      widget = buildNumberTextQuestion(index: index);
    }
    return widget;
  }
}

Widget buildTextFieldWidget(
    {required BuildContext context, required Function onTextChangeCallback, required TextInputType textInputType}) {
  return CustomTextField(
      onChanged: (value) {
        print("🎉🎉🎉 Updated value $value");
        onTextChangeCallback(value);
      },
      hint: TR.of(context).question_answer,
      textInputType: textInputType);
}

class TextQuestionPromotionalTaskComponent extends StatelessWidget {
  final Function onTextChangeCallback;
  final Question questionModel;

  TextQuestionPromotionalTaskComponent({required this.onTextChangeCallback, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            questionModel.question.format(context),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.headline6?.color),
            overflow: TextOverflow.fade,
          ),
          ViewsToolbox.emptySpaceWidget(height: 10),
          buildTextFieldWidget(
              context: context, onTextChangeCallback: onTextChangeCallback, textInputType: TextInputType.text)
        ],
      ),
    );
  }
}

class NumericalTextQuestionPromotionalTaskComponent extends StatelessWidget {
  final Function onTextChangeCallback;
  final Question questionModel;

  NumericalTextQuestionPromotionalTaskComponent({required this.onTextChangeCallback, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            questionModel.question.format(context),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.headline6?.color),
            overflow: TextOverflow.fade,
          ),
          ViewsToolbox.emptySpaceWidget(height: 10),
          buildTextField(context),
          buildTextFieldWidget(
              context: context, onTextChangeCallback: onTextChangeCallback, textInputType: TextInputType.number)
        ],
      ),
    );
  }

  Widget buildTextField(BuildContext context) {
    return TextField(
      onChanged: (text) => onTextChangeCallback(text),
      maxLines: 1,
      autofocus: false,
      textAlign: TextAlign.start,
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: Theme.of(context).textTheme.headline1?.color,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class DateQuestionPromotionalTaskComponent extends StatelessWidget {
  final Function onChangeDateSelect;
  final Question questionModel;

  DateQuestionPromotionalTaskComponent({required this.onChangeDateSelect, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            questionModel.question.format(context),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.headline6?.color),
            overflow: TextOverflow.fade,
          ),
          ViewsToolbox.emptySpaceWidget(height: 10),
          buildTextField(context),
          ViewsToolbox.emptySpaceWidget(height: 10),
          Text(
            questionModel.answerText,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.headline6?.color),
            overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }

  Widget buildTextField(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        showDatePicker(
                context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2022))
            .then((value) {
          onChangeDateSelect(value);
        });
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              R.assetsImagesCalenderIcon,
            ),
            ViewsToolbox.emptySpaceWidget(width: 5),
            Text(TR.of(context).select_date)
          ],
        ),
      ),
    );
  }
}

class MediaQuestionPromotionalTaskComponent extends StatelessWidget {
  final Function onMediaSelectCallback;
  final Function onRemoveMediaCallback;
  final Question questionModel;

  MediaQuestionPromotionalTaskComponent(
      {required this.onMediaSelectCallback, required this.onRemoveMediaCallback, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            questionModel.question.format(context),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.headline6?.color),
            overflow: TextOverflow.fade,
          ),
          ViewsToolbox.emptySpaceWidget(height: 10),
          buildMediaButton(context),
          ViewsToolbox.emptySpaceWidget(height: 8),
          _buildMediaList()
        ],
      ),
    );
  }

  Widget buildMediaButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => onMediaSelectCallback(),
      icon: Image.asset(
        R.assetsImagesCameraBlueIcon,
        color: Colors.white,
      ),
      label: Text(TR.of(context).take_picture),
    );
  }

  Widget _buildMediaList() {
    return Container(
        height: 70,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: questionModel.selectedMultimedia.length,
            itemBuilder: (context, index) {
              return QuestionMediaRow(
                mediaModel: questionModel.selectedMultimedia[index],
                onMediaRemoveCallback: () {
                  onRemoveMediaCallback(index);
                },
              );
            }));
  }
}

class SelectionsQuestionPromotionalTaskComponent extends StatefulWidget {
  final Function onChooseOptionIndex;
  final Question questionModel;

  SelectionsQuestionPromotionalTaskComponent({required this.onChooseOptionIndex, required this.questionModel});

  @override
  _SelectionsQuestionPromotionalTaskComponentState createState() => _SelectionsQuestionPromotionalTaskComponentState();
}

class _SelectionsQuestionPromotionalTaskComponentState extends State<SelectionsQuestionPromotionalTaskComponent> {
  String selectedOptions = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.questionModel.question.format(context),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.headline6?.color),
            overflow: TextOverflow.fade,
          ),
          ViewsToolbox.emptySpaceWidget(height: 10),
          Expanded(child: _buildMediaList())
        ],
      ),
    );
  }

  Widget _buildMediaList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.questionModel.options.length,
        itemBuilder: (context, index) {
          return ListTile(
              selectedTileColor: Theme.of(context).primaryColor,
              title: Text(widget.questionModel.options[index].value),
              leading: Radio(
                value: widget.questionModel.options[index].value,
                groupValue: selectedOptions,
                onChanged: (value) {
                  setState(() {
                    widget.onChooseOptionIndex(index);
                    selectedOptions = value as String;
                  });
                },
              ));
        });
  }
}
