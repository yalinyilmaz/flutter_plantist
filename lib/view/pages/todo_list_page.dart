import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_plantist_app/gen/assets.gen.dart';
import 'package:flutter_plantist_app/view/components/bottom_sheet_header.dart';
import 'package:flutter_plantist_app/view/components/custom_primary_button.dart';
import 'package:flutter_plantist_app/view/components/custom_tertiary_button.dart';
import 'package:flutter_plantist_app/view/components/custom_text_field.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';

class TodoListPage extends StatefulWidget {
  static const routeName = '/todo_list_page';
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}


PageController pageController = PageController(initialPage: 0);
bool isDatePicked = false;
bool isTimePicked = false;
DateTime now = DateTime.now();


@override
void dispose() {
  pageController.dispose();
}


class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: height / 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Plantist",
                style: context.textTheme.title1Emphasized
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 34)),
            const Icon(Icons.search, size: 40),
          ]),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  color: Colors.red,
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: SizedBox(
            child: CustomPrimaryButton(
              icon: Icon(
                Icons.add,
                color: context.whiteColor.shade100,
              ),
              enabled: true,
              text: "New Reminder",
              height: 75,
              onButtonPressed: (p0) {
                _addNewReminder(context);
              },
            ),
          ),
        )
      ]),
    ));
  }

  Future<dynamic> _addNewReminder(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ExpandablePageView(controller: pageController, children: [
                Column(
                  children: [
                    BottomSheetHeader(title: "New Reminder"),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Title",
                      hintStyle: context.textTheme.bodyEmphasized
                          .copyWith(color: Colors.grey),
                      isObscured: false,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      maxLines: 5,
                      hintText: "Notes",
                      hintStyle: context.textTheme.bodyEmphasized
                          .copyWith(color: Colors.grey),
                      inputBorder: InputBorder.none,
                      isObscured: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTertiaryButton(
                        onButtonPressed: () {
                          pageController.animateToPage(1,
                              duration: const Duration(microseconds: 300),
                              curve: Curves.easeIn);
                        },
                        mainTitle: "Details",
                        subtitle: "Today",
                        icon: Icon(Icons.arrow_forward_ios,
                            color: context.darkColor.shade100),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    BottomSheetHeader(title: "Details"),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Assets.images.datePicker.image(scale: 2),
                        const SizedBox(width: 5),
                        Text("Date",
                            style: context.textTheme.bodyRegular
                                .copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        FlutterSwitch(
                          width: 60,
                          activeColor: Colors.green,
                          value: isDatePicked,
                          onToggle: (value) {
                            isDatePicked = value;
                          },
                        )
                      ],
                    ),
                    const Divider(indent: 50, thickness: 0.5),
                    DateTimePicker(
                      customStringWeekdays: const ["MO","TU","WE","TH","FR","SA","SU"],
                      numberOfWeeksToDisplay: 4,
                      type: DateTimePickerType.Date,
                      initialSelectedDate: now,
                      onDateChanged: (date) {
                        setState(() {
                         // _d1 = DateFormat('dd MMM, yyyy').format(date);
                        });
                      },
                      // onTimeChanged: (time) {
                      //   setState(() {
                      //     _t1 = DateFormat('hh:mm:ss aa').format(time);
                      //   });
                      // },
                    ),
                    const Divider(indent: 50,thickness: 0.5),
                    Row(
                      children: [
                        Assets.images.timePicker.image(scale: 2),
                        const SizedBox(width: 5),
                        Text("Time",
                            style: context.textTheme.bodyRegular
                                .copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        FlutterSwitch(
                          width: 60,
                          activeColor: Colors.green,
                          value: isTimePicked,
                          onToggle: (value) {
                            isTimePicked = value;
                            //showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year,DateTime.now().month+2));
                          },
                        )
                      ],
                    ),
                    const Divider(indent: 50, thickness: 0.5),
                    DateTimePicker(
                      type: DateTimePickerType.Time,
                      timeInterval: const Duration(minutes: 15),
                      is24h: true,
                      onTimeChanged: (time) {
                        // setState(() {
                        //   _t1 = DateFormat('hh:mm:ss aa').format(time);
                        // });
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomTertiaryButton(
                        mainTitle: "Priority",
                        type: "None",
                        icon: Icon(Icons.arrow_forward_ios,
                            color: context.darkColor.shade100)),
                    const SizedBox(height: 20),
                    CustomTertiaryButton(
                        mainTitle: "Attach a file",
                        type: "None",
                        icon: Icon(Icons.attach_file,
                            color: context.darkColor.shade100)),
                    SizedBox(height: MediaQuery.sizeOf(context).height/2.5),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
