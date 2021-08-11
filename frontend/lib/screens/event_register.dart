import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/bottom_nav.dart';
class RegisterForm extends StatefulWidget {
   final ScreenType screen;
     const RegisterForm({ Key? key, required this.screen }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create an Event',
      debugShowCheckedModeBanner: false, //hide the debug banner
      home: Scaffold(
          //backgroundColor: Colors.transparent,
          backgroundColor: context.canvasColor,
          body: SafeArea(
            child: Container(
                padding: Vx.m32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    "Create an Event"
                        .text
                        .xl4
                        .bold
                        .color(context.theme.accentColor)
                        .make(),
                    SizedBox(
                      height: 25,
                    ),
                    "Event Details".text.xl2.make(),
                    CupertinoFormSection(
                        header: "Event Details".text.make(),
                        children: [
                          CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                              placeholder: "Enter Event Name",
                            ),
                            prefix: "Event Name".text.make(),
                          ),
                          CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                              placeholder: "Enter Date",
                            ),
                            prefix: "Date".text.make(),
                          ),
                          CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                              placeholder: "Enter Start Time",
                            ),
                            prefix: "Start Time".text.make(),
                          ),
                          CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                              placeholder: "Enter Description",
                            ),
                            prefix: "Description".text.make(),
                          ),
                        ]),
                    // CupertinoFormSection(header: "User".text.make(), children: [
                    //   CupertinoFormRow(
                    //     child: CupertinoTextFormFieldRow(
                    //       placeholder: "Enter Description",
                    //     ),
                    //     prefix: "Description".text.make(),
                    //   ),
                    // ]),
                    20.heightBox,
                    Material(
                      color: context.theme.buttonColor,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Create Event",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ).centered(),
                  ],
                )),
          ),
          // FormBuilder(
          //   key: _formKey,
          //   child: Column(
          //     children: <Widget>[
          //       FormBuilderTextField(name: 'textfield'),
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: Text('Submit'))
          //     ],
          //   ),
          //   onChanged: () => print("Form has been changed"),
          //   autovalidateMode: AutovalidateMode.always,
          // ),
          bottomNavigationBar: BottomNav(screen: widget.screen,),

          ),
    );
  }
}
