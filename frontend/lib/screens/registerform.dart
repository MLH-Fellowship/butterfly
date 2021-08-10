import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      home: Scaffold(

          //backgroundColor: Colors.transparent,
          backgroundColor: context.canvasColor,
          
          body: SafeArea(
            child: Container(
                padding: Vx.m32,


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    "Sign Up"
                        .text
                        .xl5
                        .bold
                        .color(context.theme.accentColor)
                        .make(),
                    "Create your account".text.xl2.make(),

                
                    CupertinoFormSection(
                        header: "Personal Details".text.make(),
                        children: [
                          CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                              placeholder: "Enter First Name",
                            ),
                            prefix: "First Name".text.make(),
                          ),
                          CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                              placeholder: "Enter Last Name",
                            ),
                            prefix: "Last Name".text.make(),
                          )
                        ]),
                    CupertinoFormSection(header: "User".text.make(), children: [
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          placeholder: "Enter email",
                        ),
                        prefix: "Email".text.make(),
                      ),
                      
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          obscureText: true,
                        ),
                        prefix: "Password".text.make(),
                      ),
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          obscureText: true,
                        ),
                        prefix: "Confirm Password".text.make(),
                      )
                    ]),
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
                            "SignUp",
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
          )
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
          ),
    );
  }
}
