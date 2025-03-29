import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:simple_page/colors/color_widgets.dart';
import 'package:simple_page/form_valadation/form/login/components/textfield/custom_signin_button.dart';
import 'package:simple_page/form_valadation/form/login/components/textfield/custom_text_field_components.dart';
import 'package:simple_page/profile/constants/assets_images.dart';
import 'package:simple_page/profile/widgets/custom_rounded_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  // get  isChecked => null;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.tdWhite,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.close,
              color: AppColors.tdGrey,
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "This is my first message.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.amber,
                    textColor: Colors.white,
                  );
                },
                child: Text(
                  "Need Some Help?",
                  style: TextStyle(
                      color: AppColors.tdGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(30),
                  Text(
                    "Login Page",
                    style: TextStyle(
                      color: AppColors.tdBlue1,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: AppColors.tdBlue1.withOpacity(0.5),
                          offset: Offset(10, 4),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  CustomTextFieldComponents(
                    controller: emailController,
                    labelText: "Email Address",
                    hintText: "Enter your email",
                    icon: Icons.email,
                  ),
                  Gap(10),
                  CustomTextFieldComponents(
                    controller: passwordController,
                    isPasswordField: true,
                    labelText: "Password",
                    hintText: "Enter your Password",
                    icon: Icons.lock,
                  ),
                  Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          activeColor: AppColors.tdBlue1,
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            color: AppColors.tdBlue2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgetpassword');
                          },
                          child: Text(
                            "forget password",
                            style: TextStyle(
                              color: AppColors.tdBlue2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  CustomRoundedButton(
                    label: "Signed In",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pushNamed(context, "/discover");
                      }
                    },
                    // width: 300,
                    // height: 50,
                    // borderRadius: 25,
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Doesn't have an account? Register",
                            style: TextStyle(
                              color: AppColors.tdBlue2,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  Column(
                    children: [
                      CustomSigninButton(
                        imagePath: "assets/icons/google.png",
                        text: "Sign in with Google",
                        onPressed: () async {
                          Uri googleSignInUrl =
                              Uri.parse('https://www.youtube.com/@dave.dart11');
                          await _launchInBrowser(googleSignInUrl);
                        },
                      ),
                      Gap(20),
                      CustomSigninButton(
                        imagePath: AssetsImages.githubImage,
                        colorData: AppColors.tdBlue2,
                        text: "Sign in with GitHub",
                        onPressed: () {
                          Navigator.pushNamed(context, "/profile_ui");
                        },
                      ),
                    ],
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
