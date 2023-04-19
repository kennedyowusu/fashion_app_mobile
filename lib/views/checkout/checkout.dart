import 'package:fashion_app/controller/user.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:fashion_app/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout';

  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final UserController userController = Get.put(UserController());

  bool showTextFormField = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _cardNumberController.dispose();
    _expirationDateController.dispose();
    _cvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Checkout Details',
        leadingIcon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Shipping Address'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    keyboardType: TextInputType.name,
                    labelText: 'Full Name',
                    hintText: 'Full Name',
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Full Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    keyboardType: TextInputType.streetAddress,
                    labelText: 'Address Line 1',
                    hintText: 'Address Line 1',
                    controller: _addressLine1Controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    keyboardType: TextInputType.streetAddress,
                    labelText: 'Address Line 2',
                    hintText: 'Address Line 2',
                    controller: _addressLine2Controller,
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 60.0,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Stack(
                      children: [
                        Offstage(
                          offstage: showTextFormField,
                          child: Row(
                            children: [
                              Text(
                                userController.user.value.phone.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showTextFormField = true;
                                  });
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: !showTextFormField,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  // controller: _phoneController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    showTextFormField = false;
                                  });
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _cityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'City',
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _stateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your state';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'State',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    labelText: 'Zip Code',
                    hintText: 'Zip Code',
                    controller: _zipCodeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your zip code';
                      }
                      return null;
                    },
                  ),
                  // SizedBox(height: 32.0),
                  // Text(
                  //   'Payment Information',
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 16.0),
                  // CustomTextField(
                  //   keyboardType: TextInputType.number,
                  //   labelText: 'Card Number',
                  //   hintText: 'Card Number',
                  //   controller: _cardNumberController,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter your Card Number';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(height: 16.0),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextFormField(
                  //         keyboardType: TextInputType.datetime,
                  //         controller: _expirationDateController,
                  //         validator: (value) {
                  //           if (value!.isEmpty) {
                  //             return 'Please enter the expiration date';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: InputDecoration(
                  //           hintText: 'Expiration Date',
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 16.0),
                  //     Expanded(
                  //       child: TextFormField(
                  //         keyboardType: TextInputType.number,
                  //         controller: _cvvController,
                  //         validator: (value) {
                  //           if (value!.isEmpty) {
                  //             return 'Please enter the CVV';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: InputDecoration(
                  //           hintText: 'CVV',
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 32.0),
                  Button(
                    width: double.infinity,
                    title: 'Proceed To Pay',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform checkout
                        debugPrint('Checkout successful');
                      }
                    },
                    disable: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
