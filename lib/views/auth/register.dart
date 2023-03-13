import 'package:fashion_app/controller/obscure_password.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  RegisterView() : super();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildNameTextField(),
          _buildEmailTextField(),
          _buildPasswordTextField(),
          Config.spaceSmall,
          Button(
            width: double.infinity,
            title: 'Sign Up',
            onPressed: () async {},
            disable: false,
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
}
