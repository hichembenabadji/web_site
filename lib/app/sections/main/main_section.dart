import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysite/app/widgets/arrow_on_top.dart';
import 'package:mysite/core/configs/app.dart';
import 'package:mysite/core/configs/configs.dart';
import 'package:mysite/core/providers/drawer_provider.dart';
import 'package:mysite/core/providers/scroll_provider.dart';
import 'package:mysite/app/utils/navbar_utils.dart';
import 'package:mysite/app/utils/utils.dart';
import 'package:mysite/app/widgets/navbar_actions_button.dart';
import 'package:mysite/app/widgets/navbar_logo.dart';
import 'package:mysite/core/res/responsive.dart';
import 'package:mysite/core/theme/cubit/theme_cubit.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
part 'widgets/_navbar_desktop.dart';
part 'widgets/_mobile_drawer.dart';
part 'widgets/_body.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final drawerProvider = Provider.of<DrawerProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: drawerProvider.key,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Responsive(
          desktop: _NavbarDesktop(),
          mobile: _NavBarTablet(),
          tablet: _NavBarTablet(),
        ),
      ),
      drawer: !Responsive.isDesktop(context) ? const _MobileDrawer() : null,
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Stack(
            children: [
              // if (!state.isDarkThemeOn)
              Stack(
                children: [
                  Responsive(
                    desktop: _defaultBackgroundImage(width, height, "assets/imgs/5424482.jpg"),
                    tablet: _defaultBackgroundImage(width, height, "assets/imgs/5424482.jpg"),
                    mobile: _defaultBackgroundImage(width, height, "assets/imgs/background_image_1000x750.jpg"),
                  ),
                  Container(
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                ],
              ),
              _Body(),
              const ArrowOnTop()
            ],
          );
        },
      ),
    );
  }

  Widget _defaultBackgroundImage(double width, double height, String imagePath) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        imagePath,
        opacity: const AlwaysStoppedAnimation<double>(0.2),
        width: width,
        height: height,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
