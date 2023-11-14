library menu_bar;

import 'package:flutter/material.dart';
import 'package:menu_bar/controller.dart';
import 'package:menu_bar/models.dart';
import 'package:provider/provider.dart';

typedef BarCallBack = void Function(BarItem item, int index);
typedef TranslationFunc = String Function(String key);

String _DefaultTranslation(String key){
  return key;
}

class MenuBar extends StatefulWidget{
  final MenuBarController controller;
  final Color? barColor;
  final double barHeight;
  final BarCallBack? onClick;
  final int duration;
  final AnimationType animationType;
  final TranslationFunc translationFunc;
  MenuBar({
    required this.controller,
    required
    this.barColor,
    this.onClick,
    this.barHeight = 50,
    this.animationType = AnimationType.top,
    this.duration = 300,
    this.translationFunc = _DefaultTranslation
  });

  @override
  _MenuBarState createState() => _MenuBarState();

}

class _MenuBarState extends State<MenuBar> {
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MenuBarController>(
        create: (context) => widget.controller,
      builder: (context, child) {
        return Consumer<MenuBarController>(
            builder: (context, controller, child) {
              return Container(
                decoration: BoxDecoration(
                  color: widget.barColor,
                  boxShadow: const [
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
                          children: controller.getItems().map((e) => buildTab(e, controller.getSelectedItem())).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
        );
      },
    );
  }

  void itemClicked(BarItem item){
    widget.controller.setId(item.id);
    if(widget.onClick != null){
      widget.onClick!(widget.controller.getSelectedItem(), widget.controller.index);
    }
  }

  Widget buildTab(BarItem item, BarItem selectedItem){
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

    Widget icon;
    if(item.id == selectedItem.id){
      icon = Container(
          decoration: BoxDecoration(
            color: item.selectedIconBgColor,
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
              icon: item.selectedIcon != null? item.selectedIcon! : item.icon,
              onPressed: () => itemClicked(item),
            ),
          )
      );
    }else{
      icon = Container(
          decoration: BoxDecoration(
            color: item.iconBgColor,
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
              icon: item.icon,
              onPressed: () => itemClicked(item),
            ),
          )
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
                  child: icon,
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
