import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:zhihu_imitate/view/custom_dismissible.dart';
import 'package:zhihu_imitate/view/image_view.dart';

Widget userCenterTitleDivdingLine() {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: DividingLine(
      Colors.grey[300],
      height: 15,
      widget: 0.5,
    ),
  );
}

class DividingLine extends StatelessWidget {
  double height = 0;
  double widget;
  Color _color;

  DividingLine(this._color, {this.height = 0, this.widget = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: widget,
      color: _color,
    );
  }
}

// 模仿知乎的滑动移除卡片
// 基本思路
// 1、卡片支持滑动删除
// 2、第一层的卡片被移除后第二层的卡片上移到第一层并且有一个放大的动画
// 3、淡入一个新的第二层卡片
// 最关键的在于第二步
// - 在第一层和第二层之间增加一个中间层用来做缩放动画，中间层的数据和第二层一样
// - 当第一层卡片被移除后，中间层卡片做放大移动动画，此时第二层卡片透明度为0，第一层卡片透明度为0，
// - 等移动动画完成后，设置数据，同时将第一层卡片透明度设置回来，将中间层卡片透明度设为0并复位，同时将第二层卡片做渐显动画

/// 最终实现的思路
/// 实际上两层卡片就足够了
/// 第一层卡片使用 Dismissible 配合 Offstage ，当滑动删除后，使用 Offstage 使第一层不可见，
/// 接着执行动画使第二层卡片上移并放大，当缩放移动动画结束后立即做以下操作
/// - 第一层的 Offstage 可见，
/// - 使第二层卡片透明度为0
/// - 使第二层卡片复位
/// 做完以上三个操作后接着执行渐显动画同时更新第二层卡片的数据即可。
/// 
/// 接下来要处理的事情： 当滑动到最后时处理方式，动态更新数据

class DragRemoveCard extends StatefulWidget {
  final List<String> list = [
    "111",
    "2222",
    "3333",
    "4444",
    "5555",
    "6666",
    "777",
    "8888",
    "9999",
    "aaaaa"
  ];

  int currentIndex = 0;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DragRemoveCardState();
  }
}

class _DragRemoveCardState extends State<DragRemoveCard>
    with TickerProviderStateMixin {
  bool doAnim = false;
  Animation<double> animation;
  AnimationController _scaleController;

  Animation<double> opacityAnimation;
  AnimationController _opacityController;
  bool hide = false;
  double second0pacity = 1;

  @override
  void initState() {
    super.initState();
    _scaleController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: 1.0, end: 0.0).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hide = false;
            second0pacity = 0;
            doAnim = true;
          });
          _scaleController.reset();
          _opacityController.forward();
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _opacityController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    opacityAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(_opacityController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                doAnim = false;
                _opacityController.reset();
                second0pacity = 1;
              });
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 第二层做上移动画，做渐显动画
        Opacity(
            opacity: doAnim ? opacityAnimation.value : second0pacity,
            child: Center(
                child: Container(
              width: MediaQuery.of(context).size.width - animation.value * 20,
              color: Colors.blueAccent[400],
              transform: Matrix4.translationValues(0, animation.value * 10, 0),
              height: 100,
              child: Text(widget
                  .list[hide ? widget.currentIndex : widget.currentIndex + 1]),
              // ),
            ))),

        //第一层 滑动 使用显示隐藏控制
        Offstage(
          offstage: hide,
          child: MyDismissible(
            key: Key(widget.currentIndex.toString()),
            dragStartBehavior: DragStartBehavior.down,
            direction: MyDismissDirection.horizontal,
            background: Container(color: Colors.transparent),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blueAccent[400],
              height: 100,
              child: Text(widget.list[widget.currentIndex]),
            ),
            onDismissed: (direction) {
              setState(() {
                hide = true;
                widget.currentIndex++;
              });
              _scaleController.forward();
            },
          ),
        )
      ],
    );
  }
}

// 卡片堆叠式切换效果
class CardFlipWidget extends StatefulWidget {
  @override
  _CardFlipWidgetState createState() => _CardFlipWidgetState();
}

class _CardFlipWidgetState extends State<CardFlipWidget> {
  var currentPage = 4.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 4);
    controller.addListener(() {
      setState(() {
        print("controller.page:${controller.page}");
        currentPage = controller.page;
      });
    });
    return Stack(
      children: <Widget>[
        CardScrollWidget(currentPage),
        Positioned.fill(
          child: PageView.builder(
            itemCount: maxPageSize,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
  }
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;
var maxPageSize = 5;


class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    print("widgetAspectRatio::${widgetAspectRatio}");
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, contraints) {
          print(contraints.maxHeight);
          print(contraints.maxHeight);
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < maxPageSize; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);
            print("start::${start}");
            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Image.asset(loadImage("owl.jpg"), fit: BoxFit.cover),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
