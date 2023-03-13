import 'package:fashion_app/controller/obscure_password.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/layout.dart';
import 'package:fashion_app/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  late final ObscurePassword _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = Get.put(ObscurePassword());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email Address',
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          GetBuilder<ObscurePassword>(
            builder: (controller) => TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Config.primaryColor,
              obscureText: controller.obscurePass,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Colors.grey,
                suffixIcon: IconButton(
                  onPressed: () => controller.toggleObscurePass(),
                  icon: controller.obscurePass
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Config.primaryColor,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Button(
            width: double.infinity,
            title: 'Sign In',
            onPressed: () async {},
            disable: false,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
