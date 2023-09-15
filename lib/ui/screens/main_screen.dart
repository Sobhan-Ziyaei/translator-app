import 'package:flutter/material.dart';
import 'package:translator_app/gen/assets.gen.dart';
import 'package:translator_app/ui/screens/first_screen.dart';
import 'package:translator_app/ui/screens/second_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    'مترجم آنلاین',
                    style: theme.textTheme.titleSmall,
                  ),
                  accountEmail: const Text(''),
                  currentAccountPicture: CircleAvatar(
                    child: Assets.images.logo.image(),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'درباره ما',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.info),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'ارتباط با ما',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.telegram),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'ثبت نظر',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.star_rate),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'سایر برنامه ها',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.app_shortcut),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'اشتراک برنامه',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.share),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(
                      'خروج از برنامه',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.exit_to_app),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 4, right: 0),
              child: Text('مترجم آنلاین', style: theme.textTheme.titleMedium),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                ),
              )
            ],
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                );
              },
            ),
            bottom: TabBar(
              labelStyle: theme.textTheme.titleSmall,
              labelColor: Colors.white,
              tabs: const [
                Tab(
                  text: 'مترجم متون آنلاین',
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: 'تشخیص کلمات',
                  icon: Icon(Icons.remove_red_eye),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              SecondScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
