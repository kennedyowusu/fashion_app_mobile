import 'package:fashion_app/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/widgets/custom_textformfield.dart';

class CustomDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController expiryDate = TextEditingController();
  final TextEditingController cvvNumber = TextEditingController();

  final CartController cartController = Get.put(CartController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(
            left: 28.0,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 16.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Secured by Paystack',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              SizedBox(width: 10.0),
              Image.asset(
                'assets/images/paystack.png',
                width: 15.0,
                height: 15.0,
              ),
            ],
          ),
        ),
        content: Container(
          width: 450.0,
          height: 240.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              CustomTextField(
                controller: accountNumber,
                labelText: 'Account Number',
                hintText: '0000000000',
                obscureText: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid Account Number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: expiryDate,
                        labelText: 'Expiry Date',
                        hintText: '12/24',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid date';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: CustomTextField(
                        controller: cvvNumber,
                        labelText: 'CVV',
                        hintText: '000',
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid CVV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userController.user.value.name!),
                  SizedBox(width: 15.0),
                  Text(
                    "GHS${cartController.totalAmount.value.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0.0,
              minimumSize: Size(100.0, 40.0),
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              String field1 = accountNumber.text;
              String field2 = expiryDate.text;
              String field3 = cvvNumber.text;

              print('Field 1: $field1');
              print('Field 2: $field2');
              print('Field 3: $field3');

              formKey.currentState!.validate();

              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
