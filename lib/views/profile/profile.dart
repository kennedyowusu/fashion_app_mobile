import 'package:fashion_app/controller/authentication.dart';
import 'package:fashion_app/controller/user.dart';
import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final AuthenticationController authController =
      Get.put(AuthenticationController());

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            final user = userController.user.value;

            if (userController.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(
                color: Config.primaryColor,
              ));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1523413651479-597eb2da0ad6',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${user.name}'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userController.user.value.email.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec nulla ut purus lobortis maximus ut at tortor. Praesent malesuada ipsum eget ullamcorper interdum. Sed faucibus dolor ac bibendum volutpat. Nulla tincidunt facilisis velit, vitae consequat sapien. Proin euismod tincidunt sapien. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec non efficitur velit.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Name: ${user.name?.replaceRange(0, 1, user.name![0].toUpperCase())}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Email: ${user.email}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Phone: ${user.phone}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Address: ${user.address}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            onTap: () {
                              authController.logoutUser();
                            },
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Config.primaryColor,
                              child: Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
