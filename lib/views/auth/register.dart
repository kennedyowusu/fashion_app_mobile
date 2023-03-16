import 'package:fashion_app/controller/authentication.dart';
import 'package:fashion_app/controller/obscure_password.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  final AuthenticationController authController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildNameTextField(),
          _buildEmailTextField(),
          _buildPasswordTextField(),
          _buildConfirmPasswordTextField(),
          _buildLocationTextField(),
          _buildAddressTextField(),
          _buildPhoneTextField(),
          Config.spaceSmall,
          Obx(
            () {
              if (authController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Config.primaryColor,
                  ),
                );
              } else {
                return Button(
                  width: double.infinity,
                  title: 'Sign Up',
                  onPressed: () async {
                    if (authController.formKey.currentState!.validate()) {
                      authController.registerUser(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passController.text,
                        passwordConfirmation: _confirmPassController.text,
                        location: _locationController.text,
                        address: _addressController.text,
                        phone: _phoneController.text,
                      );
                    }
                  },
                  disable: authController.isLoading.value,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Full Name',
        labelText: 'Full Name',
        prefixIcon: Icon(Icons.person_outlined),
        prefixIconColor: Colors.grey,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Email Address',
        labelText: 'Email Address',
        prefixIcon: Icon(Icons.email_outlined),
        prefixIconColor: Colors.grey,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return GetBuilder<ObscurePassword>(
      builder: (controller) {
        return TextFormField(
          controller: _passController,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          obscureText: controller.obscurePass,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            prefixIconColor: Colors.grey,
            suffixIcon: IconButton(
              onPressed: () {
                controller.toggleObscurePass();
              },
              icon: controller.obscurePass
                  ? const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.black38,
                    )
                  : const Icon(
                      Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return GetBuilder<ObscurePassword>(
      builder: (controller) {
        return TextFormField(
          controller: _confirmPassController,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          obscureText: controller.obscurePass,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            labelText: 'Confirm Password',
            prefixIcon: const Icon(Icons.lock_outline),
            prefixIconColor: Colors.grey,
            suffixIcon: IconButton(
              onPressed: () {
                controller.toggleObscurePass();
              },
              icon: controller.obscurePass
                  ? const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.black38,
                    )
                  : const Icon(
                      Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            if (value != _passController.text) {
              return 'Password does not match';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildLocationTextField() {
    return TextFormField(
      controller: _locationController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Location',
        labelText: 'Location',
        prefixIcon: Icon(Icons.location_on_outlined),
        prefixIconColor: Colors.grey,
      ),
    );
  }

  Widget _buildAddressTextField() {
    return TextFormField(
      controller: _addressController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Address',
        labelText: 'Address',
        prefixIcon: Icon(Icons.location_on_outlined),
        prefixIconColor: Colors.grey,
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: 'Phone Number',
        labelText: 'Phone Number',
        prefixIcon: Icon(Icons.phone_outlined),
        prefixIconColor: Colors.grey,
      ),
    );
  }
}
