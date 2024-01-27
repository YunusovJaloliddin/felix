import 'package:felix/common/blocs/sign_up/sign_up_bloc.dart';
import 'package:felix/common/utils/context_util/context_util.dart';
import 'package:felix/features/clubs_ads_add/clubs_ads_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils/text_field/custom_text_field.dart';
import '../../l10n/app_localizations.dart';
import 'sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController phoneNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameEditingController.dispose();
    lastNameEditingController.dispose();
    phoneNameEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  void listener (context, state) {
    if (state is SignUpSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const ClubsAdsAddScreen()),
            (route) => false,
      );
    }
  }

  void save () {
    if (formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(
        SignUpRequired(
          firstNameEditingController.text,
          lastNameEditingController.text,
          phoneNameEditingController.text,
          passwordEditingController.text,
        ),
      );
    }
  }

  void goPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Form(
      key: formKey,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: size.width * .8,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF01001F).withOpacity(.68),
                    const Color(0xFF01001F),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                  child: BlocListener<SignUpBloc, SignUpState>(
                    listener: listener,
                    child: InkWell(
                      onTap: save,
                      child: Text(
                        l10n.save,
                        style: textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: goPage,
                child: Text(
                  l10n.signIn,
                  textAlign: TextAlign.right,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF01001F),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Image(image: AssetImage("assets/images/im_main.png")),
            ),
            Center(
              child: Text(
                l10n.signUp,
                style: textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF01001F),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                    mainText: l10n.firstName,
                    hintText: l10n.enterFirstName,
                    controller: firstNameEditingController,
                    address: false,
                  ),
                  CustomTextField(
                    mainText: l10n.lastName,
                    hintText: l10n.enterLastName,
                    controller: lastNameEditingController,
                    address: false,
                  ),
                  CustomTextField(
                    mainText: l10n.phoneNumber,
                    hintText: "(__) ___-__-__",
                    controller: phoneNameEditingController,
                    address: false,
                  ),
                  CustomTextField(
                    mainText: l10n.password,
                    hintText: l10n.enterPassword,
                    controller: passwordEditingController,
                    address: false,
                  ),
                  CustomTextField(
                    mainText: l10n.confirmPassword,
                    hintText: l10n.enterConfirmPassword,
                    controller: passwordEditingController,
                    address: false,
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
