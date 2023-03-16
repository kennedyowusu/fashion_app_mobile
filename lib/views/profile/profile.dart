import 'package:fashion_app/controller/authentication.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final AuthenticationController authController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
      ),
      body: SingleChildScrollView(
        child: Column(
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
                            'John Doe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'john.doe@example.com',
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
                    'Name: John Doe',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Email: john.doe@example.com',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Phone: +1 (123) 456-7890',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Address: 1234 Main St, Anytown USA',
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
                  Row(
                    children: [
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          leading: Icon(Icons.person_outline),
                          title: Text('Name'),
                          // subtitle: Text(_profileData.name),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   onPressed: () => _showEditNameDialog(),
                          // ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.email_outlined),
                          title: Text('Email'),
                          // subtitle: Text(_profileData.email),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   onPressed: () => _showEditEmailDialog(),
                          // ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone_outlined),
                          title: Text('Phone'),
                          // subtitle: Text(_profileData.phone),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   onPressed: () => _showEditPhoneDialog(),
                          // ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.date_range_outlined),
                          title: Text('Date of Birth'),
                          // subtitle: Text(_profileData.dateOfBirth),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   onPressed: () => _showEditDOBDialog(),
                          // ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text('Address'),
                          // subtitle: Text(_profileData.address),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.edit),
                          //   onPressed: () => _showEditAddressDialog(),
                          // ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Information',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          leading: Icon(Icons.lock_outline),
                          title: Text('Change Password'),
                          // trailing: IconButton(
                          //   icon: Icon(Icons.arrow_forward_ios),
                          //   onPressed: () => Navigator.pushNamed(
                          //     context,
                          //     ChangePasswordScreen.routeName,
                          //   ),
                          // ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Log Out'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                            ),
                            onPressed: () => authController.logoutUser(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
