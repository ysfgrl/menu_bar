library menu_bar;

import 'package:flutter/material.dart';
import 'package:menu_bar/models.dart';

typedef BarCallBack = void Function(BarItem item);
typedef TranslationFunc = String Function(String key);

String _DefaultTranslation(String key){
  return key;
}

class MenuBar extends StatefulWidget{
  int selectedIndex = 0;
  List<BarItem> items;
  final Color? barColor;
  final double barHeight;
  final BarCallBack? onClick;
  final int duration;
  final AnimationType animationType;
  final TranslationFunc translationFunc;
  MenuBar({
    required this.items,
    required this.selectedIndex,
    required this.barHeight,
    this.barColor,
    this.onClick,
    this.animationType = AnimationType.top,
    this.duration = 300,
    this.translationFunc = _DefaultTranslation
  });

  @override
  _MenuBarState createState() => _MenuBarState();

}

class _MenuBarState extends State<MenuBar> {

  late BarItem selectedItem;
  double fabIconAlpha = 1;
  @override
  void initState() {
    selectedItem = widget.items[widget.selectedIndex];
  }

  @override
  void didUpdateWidget(covariant MenuBar oldWidget) {
    super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: widget.barColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: widget.barHeight,
              decoration: BoxDecoration(
                color: widget.barColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getTabList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void itemClicked(BarItem item){

    setState(() {
      selectedItem = item;
      // _initAnimationAndStart(_positionAnimation.value, position);
    });
    if(widget.onClick != null){
      widget.onClick!(item);
    }
  }

  List<Widget> getTabList(){
    List<Widget> tabs = [];
    widget.items.forEach((element) {
      tabs.add(buildTab(element));
    });
    return tabs;
  }
  Widget buildTab(BarItem item){
    Alignment labelAlign;
    if(widget.animationType == AnimationType.top){
      if(selectedItem.id == item.id){
        labelAlign = Alignment(0, 1);
      }else{
        labelAlign = Alignment(0, 2);
      }
    }else{
      if(selectedItem.id == item.id){
        labelAlign = Alignment(0, -1);
      }else{
        labelAlign = Alignment(0, -2);
      }
    }
    Widget label = Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: AnimatedAlign(
        duration: Duration(milliseconds: widget.duration),
        alignment: labelAlign,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedItem.id == item.id
                ? Text(widget.translationFunc(item.label),
              softWrap: false,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: item.textStyle,
            )
                : Text("")
        ),
      ),
    );

    Icon icon;
    if(item.id == selectedItem.id){
      icon = Icon(
        item.selectedIcon,
        color: item.selectedColor,
        size: widget.barHeight/10*6,
      );
    }else{
      icon = Icon(
        item.icon,
        color: item.color,
        size: widget.barHeight/10*6,
      );
    }
    Widget iconWidget = InkWell(
      onTap: () => {

      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: AnimatedAlign(
          duration: Duration(milliseconds: widget.duration),
          curve: Curves.easeIn,
          alignment: selectedItem.id == item.id ?  widget.animationType == AnimationType.top ? Alignment(0, -8): Alignment(0, 8):  Alignment(0, 0),
          child: Stack(
            alignment: Alignment(0,0),
            children: [
              Container(
                height: widget.barHeight/10*9,
                width: widget.barHeight/10*9,
                padding: EdgeInsets.all(widget.barHeight/10),
                decoration: BoxDecoration(
                  color: widget.barColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.barColor,
                      shape: BoxShape.circle,
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     blurRadius: 8,
                      //   )
                      // ],
                    ),
                    child: SizedBox.expand(
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        alignment: Alignment(0, 0),
                        icon: icon,
                        onPressed: () => itemClicked(item),
                      ),
                    ),
                  ),
                ),
              ),
              item.badge != null
                  ? Positioned(
                top: 0,
                right: 0,
                child: item.badge!,
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: widget.animationType == AnimationType.top
        ? [label, iconWidget]
          : [iconWidget, label]
      ),
    );
  }

}
