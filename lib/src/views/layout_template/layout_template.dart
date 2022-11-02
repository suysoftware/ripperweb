import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/widgets/centered_view/centered_view.dart';
import 'package:ripper_web/src/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:ripper_web/src/widgets/privacy_terms/dynamic_gentis_button.dart';
import 'package:ripper_web/src/widgets/privacy_terms/terms_button.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/time_screen_cubit.dart';
import '../../models/time_screen_models.dart';
import '../../widgets/navigation_bar/navigation_bar.dart';

class LayoutTemplate extends StatefulWidget {
  final Widget child;
  const LayoutTemplate({Key? key, required this.child}) : super(key: key);

  @override
  State<LayoutTemplate> createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  @override
  void initState() {
    super.initState();

    context.read<TimeScreenCubit>().changeTimeScreen(TimeScreenModels(
        year: 15421551253,
        month: 8,
        day: 12,
        hour: 7,
        minute: 44,
        second: 19,
        tradeAvailableDay: 255));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? const NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: [
              const NavigatiorBar(),
              Expanded(child: widget.child),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: (100.h > 700) ? 1.0 : 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    const DynamicGentisButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        TermsOfUse(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
