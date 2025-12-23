import 'package:flutter/material.dart';
import 'package:test_app/widgets/admin_navigation.dart';
import 'package:test_app/widgets/dr_navigation.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();

  final _signupEmailCtrl = TextEditingController();
  final _signupPassCtrl = TextEditingController();

  bool _signupShowPass = false;

  @override
  void dispose() {
    _signupEmailCtrl.dispose();
    _signupPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final double headerH = height * 0.32;
    final double overlap = height * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerH,
            child: _signupBuildHeader(context, headerH, width, height),
          ),
          Positioned(
            top: headerH - overlap,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              clipBehavior: Clip.antiAlias,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      width * 0.04,
                      height * 0.03,
                      width * 0.04,
                      height * 0.03,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.006),
                        _signupBuildForm(context),
                        SizedBox(height: height * 0.02),
                        _signupBuildActions(context),
                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signupBuildHeader(
    BuildContext context,
    double headerH,
    double width,
    double height,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/doctor_header.jpg',
          width: double.infinity,
          height: headerH,
          fit: BoxFit.cover,
        ),
        Container(height: headerH, color: Colors.black.withOpacity(0.5)),
        Positioned(
          left: width * 0.02,
          top: height * 0.05,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/onboarding2');
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        ),
        Positioned(
          left: width * 0.36,
          top: height * 0.055,
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.085,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _signupBuildForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 14),
          CustomTextField(
            label: 'Email',
            hint: 'Enter your email',
            controller: _signupEmailCtrl,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.endsWith('@gmail.com')) {
                return 'Email must end with @gmail.com';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          CustomTextField(
            label: 'Password',
            hint: "Enter your password",
            controller: _signupPassCtrl,
            isPassword: true,
            obscure: _signupShowPass,
            onToggleVisibility: () =>
                setState(() => _signupShowPass = !_signupShowPass),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }

              return null;
            },
          ),
          const SizedBox(height: 14),
          // Forgot password link (aligned left)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/resetpassword');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Forgot password",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signupBuildActions(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Column(
      children: [
        SizedBox(
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: _signupOnCreatePressed,
            child: const Text(
              'Sign in',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: const [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('OR', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),
        const SizedBox(height: 18),
        SocialButton(
          icon: Image.asset(
            'assets/images/google_icon_image.jpg',
            height: 24,
            width: 24,
          ),
          text: 'Sign in with Google',
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        SocialButton(
          icon: Image.asset(
            'assets/images/facebook_icon_image.jpg',
            height: 24,
            width: 24,
          ),
          text: 'Sign in with Facebook',
          onPressed: () {},
        ),
        const SizedBox(height: 24),
        // Sign up link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _signupOnCreatePressed() {
    if (_formkey.currentState!.validate()) {
      _signupToast(context, 'Sign in successfully!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminNavigationpage()),
      );
    }
  }

  void _signupToast(BuildContext context, String msg) {
    if (msg == 'Sign in successfully!') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }
  }
}
