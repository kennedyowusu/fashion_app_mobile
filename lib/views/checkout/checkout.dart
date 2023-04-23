import 'package:fashion_app/controller/shipping_address.dart';
import 'package:fashion_app/controller/user.dart';
import 'package:fashion_app/services/shipping_Address.dart';
import 'package:fashion_app/views/checkout/shipping_address_list.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:fashion_app/widgets/custom_textformfield.dart';
import 'package:fashion_app/widgets/loader.dart';
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
  final TextEditingController _phoneController = TextEditingController();

  final UserController userController = Get.put(UserController());
  final ShippingAddressService shippingAddressService =
      Get.put(ShippingAddressService());

  final ShippingAddressController shippingAddressController =
      Get.put(ShippingAddressController());

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
                    () => shippingAddressController.isLoading.value
                        ? Center(
                            child: Loader(),
                          )
                        : Button(
                            width: double.infinity,
                            title: 'Save Address',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform checkout

                                print('Name: ${_nameController.text}');
                                print(
                                    'Address Line 1: ${_addressLine1Controller.text}');
                                print(
                                    'Address Line 2: ${_addressLine2Controller.text}');
                                print('Phone: ${_phoneController.text}');
                                print('City: ${_cityController.text}');
                                print('State: ${_stateController.text}');
                                print('Zip Code: ${_zipCodeController.text}');
                                print(
                                    'User ID: ${userController.user.value.id}');

                                shippingAddressController.createShippingAddress(
                                  name: _nameController.text,
                                  address: _addressLine1Controller.text,
                                  phone: _phoneController.text,
                                  city: _cityController.text,
                                  state: _stateController.text,
                                  zip: _zipCodeController.text,
                                  userId: userController.user.value.id!,
                                );

                                Get.to(
                                  () => ShippingAddressList(),
                                  transition: Transition.rightToLeft,
                                );
                              }

                              // Retrieve the values of the form fields
                              String name = _nameController.text;
                              String addressLine1 =
                                  _addressLine1Controller.text;
                              String addressLine2 =
                                  _addressLine2Controller.text;
                              String phone = _phoneController.text;
                              String city = _cityController.text;
                              String state = _stateController.text;
                              String zipCode = _zipCodeController.text;

                              // Only print when all fields are valid, otherwise print nothing
                              if (name.isNotEmpty &&
                                  addressLine1.isNotEmpty &&
                                  phone.isNotEmpty &&
                                  city.isNotEmpty &&
                                  state.isNotEmpty &&
                                  zipCode.isNotEmpty) {
                                clearFormFields();
                                debugPrint(
                                  'Name: $name, Address Line 1: $addressLine1, Address Line 2: $addressLine2, Phone: $phone, City: $city, State: $state, Zip Code: $zipCode, User: ${userController.user.value.id}',
                                );
                              } else {
                                debugPrint('Please fill all fields');
                              }
                            },
                            disable: shippingAddressController.isLoading.value,
                          ),
                  ),
                  SizedBox(height: 16.0),
                  Button(
                    width: double.infinity,
                    title: 'Proceed to Pay',
                    onPressed: () {
                      Get.back();
                    },
                    disable: shippingAddressController.isLoading.value,
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
