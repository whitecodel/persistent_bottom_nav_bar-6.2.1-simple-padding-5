part of persistent_bottom_nav_bar;

class _BottomNavSimple extends StatelessWidget {
  const _BottomNavSimple({
    required this.navBarEssentials,
    final Key? key,
  }) : super(key: key);
  final _NavBarEssentials navBarEssentials;

  Widget _buildItem(final PersistentBottomNavBarItem item,
          final bool isSelected, final double? height) =>
      navBarEssentials.navBarHeight == 0
          ? const SizedBox.shrink()
          : AnimatedContainer(
              width: 150,
              height: height,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.center,
                height: height,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
                      children: <Widget>[
                        Expanded(
                          child: IconTheme(
                            data: IconThemeData(
                                size: item.iconSize,
                                color: isSelected
                                    ? (item.activeColorSecondary ??
                                        item.activeColorPrimary)
                                    : item.inactiveColorPrimary ??
                                        item.activeColorPrimary),
                            child: isSelected
                                ? item.icon
                                : item.inactiveIcon ?? item.icon,
                          ),
                        ),
                        if (item.title == null)
                          const SizedBox.shrink()
                        else
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Material(
                              type: MaterialType.transparency,
                              child: FittedBox(
                                  child: Text(
                                item.title!,
                                style: item.textStyle != null
                                    ? (item.textStyle!.apply(
                                        color: isSelected
                                            ? (item.activeColorSecondary ??
                                                item.activeColorPrimary)
                                            : item.inactiveColorPrimary))
                                    : TextStyle(
                                        color: isSelected
                                            ? (item.activeColorSecondary ??
                                                item.activeColorPrimary)
                                            : item.inactiveColorPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                              )),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            );

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        height: navBarEssentials.navBarHeight,
        padding: navBarEssentials.padding,
        child: Row(
          mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
          children: navBarEssentials.items.map((final item) {
            final int index = navBarEssentials.items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  if (index != navBarEssentials.selectedIndex) {
                    navBarEssentials.items[index].iconAnimationController
                        ?.forward();
                    navBarEssentials.items[navBarEssentials.selectedIndex]
                        .iconAnimationController
                        ?.reverse();
                  }
                  if (navBarEssentials.items[index].onPressed != null) {
                    navBarEssentials.items[index].onPressed!(
                        navBarEssentials.selectedScreenBuildContext);
                  } else {
                    navBarEssentials.onItemSelected?.call(index);
                  }
                },
                child: _buildItem(item, navBarEssentials.selectedIndex == index,
                    navBarEssentials.navBarHeight),
              ),
            );
          }).toList(),
        ),
      );
}
