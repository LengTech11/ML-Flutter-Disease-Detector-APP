import 'package:disease_detector_app/config/constants.dart';
import 'package:disease_detector_app/firebase_helpers/firebase_auth/firebase_auth_helpers.dart';
import 'package:disease_detector_app/provider/provider.dart';
import 'package:disease_detector_app/screens/login/login_screen.dart';
import 'package:disease_detector_app/widgets/tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (ctx, provider, _) {
        return TileButton(
          onpress: () async {
            try {
              showLoaderDialog(context);
              await FirebaseAuthHelper.instance.handleSignOut();
              FirebaseAuthHelper.instance.signOut();
              provider.clearUser();
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            } catch (e) {
              if (e is PlatformException) {
                print('Failed to disconnect: ${e.message}');
              } else {
                // Re-throw any other exceptions
                rethrow;
              }
            }
          },
          prefix: Iconsax.logout4,
          // suffix: Iconsax.arrow_right_3,
          title: 'Log out',
        );
      },
      // child: ,
    );
  }
}
