import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_text_field.dart';

class DrProfileScreen extends StatefulWidget {
  const DrProfileScreen({super.key});

  @override
  State<DrProfileScreen> createState() => _DrProfileScreenState();
}

class _DrProfileScreenState extends State<DrProfileScreen> {
  final _formkey = GlobalKey<FormState>();

  final _drProfileNameCtrl = TextEditingController();
  final _drProfileEmailCtrl = TextEditingController();
  /*final _drProfileOldPassCtrl = TextEditingController();
  final __drProfileNewPassCtrl = TextEditingController();
  final _drProfileConfirmPassCtrl = TextEditingController();*/
  /*
  bool _drProfileShowOldPass = false;
  bool _drProfileShowNewPass = false;
  bool _drProfileShowConfirm = false;
*/
  @override
  void dispose() {
    _drProfileNameCtrl.dispose();
    _drProfileEmailCtrl.dispose();
    /*_drProfileOldPassCtrl.dispose();
    __drProfileNewPassCtrl.dispose();
    _drProfileConfirmPassCtrl.dispose();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    double headerH = height * 0.39;
    double overlap = height * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerH,
            child: _profileBuildHeader(context, headerH, width, height),
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
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Mr. Ahmad Sami',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            width * 0.04,
                            height * 0.01,
                            width * 0.04,
                            height * 0.03,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.006),
                              _profileBuildForm(context),
                              SizedBox(height: height * 0.25),
                              _profileBuildActions(context),
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileBuildHeader(
    BuildContext context,
    double headerH,
    double width,
    double height,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(height: headerH, color: Color(0xFF34AFB7)),
        Positioned(
          left: width * 0.38,
          top: height * 0.055,
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Positioned(
          bottom: height * 0.075,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: width * 0.45,
                height: width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 4),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/User_profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 6,
                bottom: 6,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileBuildForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Full Name',
            hint: 'Enter your full name',
            controller: _drProfileNameCtrl,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          CustomTextField(
            label: 'Email',
            hint: 'Enter your email',
            controller: _drProfileEmailCtrl,
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
          /*
          CustomTextField(
            label: 'Old Password',
            controller: _drProfileOldPassCtrl,
            isPassword: true,
            obscure: _drProfileShowOldPass,
            onToggleVisibility: () =>
                setState(() => _drProfileShowOldPass = !_drProfileShowOldPass),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your old password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          CustomTextField(
            label: 'New Password',
            controller: __drProfileNewPassCtrl,
            isPassword: true,
            obscure: _drProfileShowNewPass,
            onToggleVisibility: () =>
                setState(() => _drProfileShowNewPass = !_drProfileShowNewPass),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your new password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          CustomTextField(
            label: 'Confirm Password',
            controller: _drProfileConfirmPassCtrl,
            isPassword: true,
            obscure: _drProfileShowConfirm,
            onToggleVisibility: () =>
                setState(() => _drProfileShowConfirm = !_drProfileShowConfirm),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your confirm password';
              }
              if (value != __drProfileNewPassCtrl.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),*/
        ],
      ),
    );
  }

  Widget _profileBuildActions(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return SizedBox(
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
        onPressed: _profileOnCreatePressed,
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void _profileOnCreatePressed() {
    if (_formkey.currentState!.validate()) {
      _profileToast('Saved information!');
    }
  }

  void _profileToast(String msg) {
    if (msg == 'Saved information!') {
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
