import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/utils/app_text.dart';
import 'package:fashion_app/views/auth/login.dart';
import 'package:fashion_app/views/auth/register.dart';
import 'package:flutter/material.dart';

class AuthSelector extends StatefulWidget {
  const AuthSelector({Key? key}) : super(key: key);

  @override
  State<AuthSelector> createState() => _AuthSelectorState();
}

class _AuthSelectorState extends State<AuthSelector> {
  late bool isSignIn;

  @override
  void initState() {
    super.initState();
    isSignIn = true;
  }

  @override
  Widget build(BuildContext context) {
    Config.init(context);
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 35,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Spacer(),
            Text(
              AppText.enText['welcome_text']!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Config.primaryColor,
              ),
            ),
            Config.spaceSmall,
            Text(
              isSignIn
                  ? AppText.enText['signIn_text']!
                  : AppText.enText['register_text']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            isSignIn ? const LoginView() : RegisterView(),
            SizedBox(
              height: 10.0,
            ),
            isSignIn
                ? Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppText.enText['forgot-password']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isSignIn
                      ? AppText.enText['signUp_text']!
                      : AppText.enText['registered_text']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignIn = !isSignIn;
                    });
                  },
                  child: Text(
                    isSignIn ? 'Sign Up' : 'Sign In',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4682B4),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
