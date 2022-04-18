// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'login_page.dart';

// class HomeScreen extends StatefulWidget {
//   final User user;
//   const HomeScreen({required this.user});
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
// class _HomeScreenState extends State<HomeScreen> {
//   late User _currentUser;

//   @override
//   void initState() {
//     _currentUser = widget.user;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'NAME: ${_currentUser.displayName}',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             const SizedBox(height: 16.0),
//             Text(
//               'EMAIL: ${_currentUser.email}',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             const SizedBox(height: 16.0),
//             _currentUser.emailVerified
//                 ? Text(
//               'Email verified',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(color: Colors.green),
//             )
//                 : Text(
//               'Email not verified',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(color: Colors.red),
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   await FirebaseAuth.instance.signOut();

//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => LoginPage(),
//                     ),
//                   );
//                 },
//                 child: const Text('Sign out')
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }