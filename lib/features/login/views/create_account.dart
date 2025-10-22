import 'dart:convert';
import 'dart:io';
import 'package:etsy/features/login/cubit/login_cubit.dart';
import 'package:etsy/features/login/data/validators.dart';
import 'package:etsy/features/login/views/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController nationalId = TextEditingController();
  final TextEditingController gender = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSucess) {
            if (state.model.status == "success") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Account created successfully!"),
                    backgroundColor: Colors.green),
              );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Failed: ${state.model.message}"),
                    backgroundColor: Colors.red),
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<LoginCubit>(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0Xff302A35),
              centerTitle: true,
              title:
                  const Text('Sign Up', style: TextStyle(color: Colors.white)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text('Create Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    const Text('Enter your details to sign up',
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                    const SizedBox(height: 15),
                    Center(
                      child: GestureDetector(
                        onTap: pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0XffD9D9D9),
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : null,
                          child: _selectedImage == null
                              ? const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 40)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextForm(
                      validator: (p0) => MyValidators.displayNameValidator(p0),
                      controller: name,
                      keyboardType: TextInputType.text,
                      hint: 'Name',
                      label: 'Enter Your Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      validator: (p0) => MyValidators.emailValidator(p0),
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      hint: 'Email',
                      label: 'Enter Your Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      validator: (p0) => MyValidators.passwordValidator(p0),
                      controller: password,
                      keyboardType: TextInputType.text,
                      hint: 'Password',
                      label: 'Enter Your Password',
                      icon: Icons.lock,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      validator: (p0) => MyValidators.phoneValidator(p0),
                      controller: phone,
                      keyboardType: TextInputType.number,
                      hint: 'Phone',
                      label: 'Enter Your Phone',
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      validator: (p0) => MyValidators.nationalIdValidator(p0),
                      controller: nationalId,
                      keyboardType: TextInputType.number,
                      hint: 'National ID',
                      label: 'Enter Your National ID',
                      icon: Icons.credit_card,
                    ),
                    const SizedBox(height: 10),
                    CustomTextForm(
                      validator: (p0) =>
                          MyValidators.genderValidator(value: p0),
                      controller: gender,
                      keyboardType: TextInputType.text,
                      hint: 'Gender',
                      label: 'Enter Your Gender',
                      icon: Icons.people,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        String? nameError =
                            MyValidators.displayNameValidator(name.text);
                        String? emailError =
                            MyValidators.emailValidator(email.text);
                        String? passwordError =
                            MyValidators.passwordValidator(password.text);
                        String? phoneError = MyValidators.phoneValidator(
                          phone.text,
                        );
                        String? nationalIdError =
                            MyValidators.nationalIdValidator(nationalId.text);
                        String? genderError = MyValidators.genderValidator(value: gender.text);

                        final errors = [
                          nameError,
                          emailError,
                          passwordError,
                          phoneError,
                          nationalIdError,
                          genderError
                        ].where((e) => e != null).toList();

                        if (errors.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(errors.first!),
                                backgroundColor: Colors.red),
                          );
                          return;
                        }

                        String base64Image = "";
                        if (_selectedImage != null) {
                          List<int> imageBytes =
                              await _selectedImage!.readAsBytes();
                          base64Image =
                              "data:image/jpeg;base64,${base64Encode(imageBytes)}";
                        }

                        cubit.registerCubit(
                          email: email.text,
                          password: password.text,
                          name: name.text,
                          phone: phone.text,
                          nationalId: nationalId.text,
                          gender: gender.text.trim().toLowerCase(),
                          profileImage: base64Image,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF20DFB5),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text('Create Account',
                          style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Already have an account? Sign In',
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
