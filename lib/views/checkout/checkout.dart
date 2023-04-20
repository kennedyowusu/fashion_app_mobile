import 'package:fashion_app/controller/phone_controller.dart';
import 'package:fashion_app/controller/user.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/services/shipping_Address.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:fashion_app/widgets/custom_textformfield.dart';
import 'package:fashion_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  final TextEditingController _phoneController = TextEditingController();

  final UserController userController = Get.put(UserController());
  // final PhoneController phoneController = Get.put(PhoneController());
  final ShippingAddressService shippingAddressService =
      Get.put(ShippingAddressService());

  bool showTextFormField = false;

  void clearFormFields() {
    _nameController.clear();
    _addressLine1Controller.clear();
    _addressLine2Controller.clear();
    _cityController.clear();
    _stateController.clear();
    _zipCodeController.clear();
    _phoneController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();

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
                    // child: Obx(
                    //   () => Row(
                    //     children: [
                    //       Expanded(
                    //         child: phoneController.showTextFormField.value
                    //             ? TextFormField(
                    //                 // controller: _phoneNumberController,
                    //                 initialValue:
                    //                     phoneController.phoneNumber.value,
                    //                 keyboardType: TextInputType.phone,
                    //                 decoration: InputDecoration(
                    //                   hintText: 'Enter phone number',
                    //                 ),
                    //                 onChanged: (value) {
                    //                   phoneController.setPhoneNumber(value);
                    //                 },
                    //                 validator: (value) {
                    //                   if (value!.isEmpty) {
                    //                     return 'Please enter your phone number';
                    //                   }
                    //                   return null;
                    //                 },
                    //               )
                    //             : Text(
                    //                 phoneController.phoneNumber.value,
                    //                 style: TextStyle(
                    //                   fontSize: 16.0,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //       ),
                    //       SizedBox(width: 16.0),
                    //       phoneController.showTextFormField.value
                    //           ? IconButton(
                    //               onPressed: () {
                    //                 phoneController.setShowTextFormField(false);
                    //               },
                    //               icon: Icon(Icons.close),
                    //             )
                    //           : TextButton(
                    //               onPressed: () {
                    //                 phoneController.setShowTextFormField(true);
                    //               },
                    //               child: Text(
                    //                 'Change',
                    //                 style: TextStyle(
                    //                   color: Config.primaryColor,
                    //                   fontSize: 16.0,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //     ],
                    //   ),
                    // ),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
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
                  SizedBox(height: 32.0),
                  Obx(
                    () => shippingAddressService.isLoading.value
                        ? Center(
                            child: Loader(),
                          )
                        : Button(
                            width: double.infinity,
                            title: 'Save Address',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform checkout

                                shippingAddressService.createShippingAddress(
                                  name: _nameController.text,
                                  addressLineOne: _addressLine1Controller.text,
                                  phone: _phoneController.text,
                                  city: _cityController.text,
                                  state: _stateController.text,
                                  zip: _zipCodeController.text,
                                  userId: userController.user.value.id!,
                                );
                              }

                              debugPrint(
                                'Name: ${_nameController.text}, Address: ${_addressLine1Controller.text}, Phone: ${_phoneController.text}, City: ${_cityController.text}, State: ${_stateController.text}, Zip: ${_zipCodeController.text}, User: ${userController.user.value.id}',
                              );

                              clearFormFields();
                            },
                            disable: shippingAddressService.isLoading.value,
                          ),
                  ),
                  SizedBox(height: 16.0),
                  Button(
                    width: double.infinity,
                    title: 'Proceed to Pay',
                    onPressed: () {
                      Get.back();
                    },
                    disable: shippingAddressService.isLoading.value,
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
