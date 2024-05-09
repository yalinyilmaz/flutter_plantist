

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_plantist_app/view/components/custom_primary_button.dart';
import 'package:flutter_plantist_app/view/components/custom_text_field.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';
import 'package:go_router/go_router.dart';

class TodoListPage extends StatefulWidget {
  static const routeName = '/todo_list_page';
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
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
              icon:  Icon(Icons.add,color: context.whiteColor.shade100,),
              enabled: true,
              text: "New Reminder",
              height: 75,
              onButtonPressed: (p0) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.viewInsetsOf(context).bottom),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: context.textTheme.bodyEmphasized
                                            .copyWith(color: Colors.blueAccent),
                                      )),
                                  Text("New Reminder",
                                      style: context.textTheme.bodyEmphasized
                                          .copyWith(
                                              fontWeight: FontWeight.w600)),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Add",
                                        style: context.textTheme.bodyEmphasized
                                            .copyWith(fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                hintText: "Title",
                                hintStyle: context.textTheme.bodyEmphasized.copyWith(color:Colors.grey),
                                isObscured: false,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                maxLines: 5,
                                hintText: "Notes",
                                hintStyle: context.textTheme.bodyEmphasized.copyWith(color:Colors.grey),
                                inputBorder: InputBorder.none,
                                isObscured: false,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.1),
                                      border: Border.all(
                                          color: context.darkColor.shade100),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Details",
                                                  style: context
                                                      .textTheme.bodyRegular.copyWith(fontWeight: FontWeight.w400)),
                                              Text("Today",
                                                  style: context
                                                      .textTheme.calloutRegular.copyWith(color:Colors.grey.shade900))
                                            ],
                                          ),
                                          Icon(Icons.arrow_forward_ios,
                                              color: context.darkColor.shade100)
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        )
      ]),
    ));
  }
}
