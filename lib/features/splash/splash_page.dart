import 'package:felix/common/utils/context_util/context_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../common/blocs/get_bloc/get_bloc.dart';
import '../../common/controller/provider/project_model.dart';
import '../auth/sign_up.dart';
import '../clubs_ads_add/clubs_ads_add_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<ProjectModel>().getLocale();
    super.initState();
  }

  void dropDownCallback(String? selectedValue, BuildContext context) {
    context.read<ProjectModel>().setLocale(
          Locale(selectedValue!),
          selectedValue,
        );
  }

  void onPressed(state) {
    if (state is GetSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const ClubsAdsAddScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: size.height * 0.4),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/FindSport-Logo.svg"),
                Text(
                  "FindSport",
                  style: context.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.3),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Languages",
                    style: context.textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: size.height * 0.045,
                    width: size.width * 0.67,
                    child: DropdownButton(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      underline: const SizedBox.shrink(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF949CA9),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      value: context.watch<ProjectModel>().dropDownValue,
                      items: const [
                        DropdownMenuItem<String>(
                          value: "uz",
                          child: Row(
                            children: [
                              Image(image: AssetImage("assets/images/uzb.png")),
                              Text(
                                "Uzbek",
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "en",
                          child: Row(
                            children: [
                              Image(image: AssetImage("assets/images/uzb.png")),
                              Text(
                                "Kiril",
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "ru",
                          child: Row(
                            children: [
                              Image(image: AssetImage("assets/images/rus.png")),
                              Text(
                                "Rus",
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) => dropDownCallback(value, context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            CircleAvatar(
              radius: size.height * 0.028,
              child: BlocBuilder<GetBloc, GetState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () => onPressed(state),
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
