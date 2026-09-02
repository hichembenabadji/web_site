part of '../main_section.dart';

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);
    var theme = Theme.of(context);
    return Drawer(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Material(
            color: theme.scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Column(
                children: [
                  const Center(child: NavBarLogo()),
                  const Divider(),
                  ...NavBarUtils.names.asMap().entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            hoverColor: theme.primaryColor.withAlpha(70),
                            onPressed: () {
                              scrollProvider.jumpTo(e.key);
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              leading: Icon(
                                NavBarUtils.icons[e.key],
                              ),
                              title: Text(
                                e.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                  Space.y(5.w)!,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
