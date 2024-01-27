import 'package:felix/common/blocs/sign_in/sign_in_bloc.dart';
import 'package:felix/common/utils/context_util/context_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils/text_field/custom_text_field.dart';
import '../../l10n/app_localizations.dart';
import '../clubs_ads_add/clubs_ads_add_screen.dart';
import 'sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  void listener(context, state) {
    if (state is SignInSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const ClubsAdsAddScreen()),
            (route) => false,
      );
    }
  }

  void enter() {
    if (formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(
        SignInRequired(
          firstName: firstNameEditingController.text,
          password: passwordEditingController.text,
        ),
      );
    }
  }

  void goPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
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
                child: BlocListener<SignInBloc, SignInState>(
                  listener: listener,
                  child: InkWell(
                    onTap: enter,
                    child: Text(
                      l10n.enter,
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
                  l10n.signUp,
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
                l10n.signIn,
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
