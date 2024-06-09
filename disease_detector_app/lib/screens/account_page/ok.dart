// import 'package:ecommerce/widget/my_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../provider/provider.dart';
//
// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});
//
//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }
//
// class _AccountScreenState extends State<AccountScreen> {
//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(
//       context,
//     );
//
//     final dark = HelpFunctions.isDarkMode(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Account",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 appProvider.getUserInformation?.image != null
//                     ? CircleAvatar(
//                   backgroundImage:
//                   NetworkImage(appProvider.getUserInformation!.image!),
//                   radius: 60,
//                 )
//                     : const Icon(
//                   Icons.person_outline,
//                   size: 120,
//                 ),
//                 Text(
//                   appProvider.getUserInformation!.name,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   appProvider.getUserInformation!.email,
//                 ),
//                 const SizedBox(
//                   height: 12.0,
//                 ),
//                 SizedBox(
//                   width: 130,
//                   child: MyButton(
//                     name: "Edit Profile",
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => EditProfile()));
//                     },
//                     dark: dark,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               children: [
//                 ListTile(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => OrderScreen()));
//                   },
//                   leading: const Icon(Icons.shopping_bag_outlined),
//                   title: const Text("Your Orders"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => FavouriteScreen()));
//                   },
//                   leading: const Icon(Icons.favorite_outline),
//                   title: const Text("Favourite"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => AboutUs()));
//                   },
//                   leading: const Icon(Icons.info_outline),
//                   title: const Text("About us"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ChangePassword()));
//                   },
//                   leading: const Icon(Icons.change_circle_outlined),
//                   title: const Text("Change Password"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     FirebaseAuthHelper.instance.signOut();
//
//                     setState(() {});
//                   },
//                   leading: const Icon(Icons.exit_to_app),
//                   title: const Text("Log out"),
//                 ),
//                 const SizedBox(
//                   height: 12.0,
//                 ),
//                 const Text("Version 1.0.0")
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }