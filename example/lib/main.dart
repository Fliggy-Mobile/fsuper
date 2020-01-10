import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsuper/fsuper.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  var text =
      "FWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidgetFWidget";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Color(0xffffc900),
//          title: const Text('FSuper'),
//          centerTitle: true,
//        ),
//          body: FSuper(
//            text: text,
////            padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
//            backgroundColor: Colors.blue,
//            child1: Icon(Icons.check_circle),
//            child1Alignment: Alignment.bottomRight,
////            child1Margin: EdgeInsets.all(20),
//            margin: EdgeInsets.all(20),
////            padding: EdgeInsets.all(50),
//            redPoint: true,
//            onChild1Click: () {
//              setState(() {
//                text = "哈哈哈哈哈哈哈哈哈😂，变了变了！";
//              });
//            },
//          )
////        body: GestureDetector(
////            onTap: (){
////              setState(() {
////                text = "asdfasdfsadfdsfsda";
////              });
////            },
////            child: Test(text)),
//      ),
      home: FSuperPage(),
    );
  }
}

class FSuperPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSuperPageState();
  }
}

class _FSuperPageState extends State<FSuperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffffc900),
          title: const Text('FSuper'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildTitle("Size & Rich Text"),
                  _buildSmallMargin(),
                  FSuper(
                    text: "This is FSuper!",
                    backgroundColor: Color(0xffffc900),
                  ),
                  _buildDesc("在不设置 width、height 属性的情况下，FSuper 大小为 text 的大小\n"
                      "在这种情况下，textAlignment 将会失效，text 始终看起来是居中的"),
                  FSuper(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    width: double.infinity,
                    text: "This is FSuper!",
                    backgroundColor: Color(0xffffc900),
                  ),
                  _buildDesc('设置 "width: double.infinity"，可让 FSuper 宽充满可用空间\n'
                      '但不要将 height 设置为 double.infinity，你应该给他一个具体值，\n'
                      '或者干脆就空着'),
                  FSuper(
                    text: "En.. ",
                    spans: [
                      TextSpan(
                          text: "FWidget",
                          style: TextStyle(
                            color: Color(0xffffc900),
                            backgroundColor: Colors.black38,
                            fontSize: 20,
                          )),
                      TextSpan(text: " are really "),
                      TextSpan(
                          text: "delicious",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          )),
                      TextSpan(text: "!"),
                      TextSpan(
                        text: "\nYou can try to ",
                      ),
                      TextSpan(
                        text: "click here",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _showDialog(
                                context, "YA! How dare you clicked me?");
                          },
                      ),
                      TextSpan(text: " !"),
                    ],
                  ),
                  _buildDesc("通过 spans 属性，可以传入一个 List<TextSpan> 来实现富文本"),
                  _buildTitle("Corner"),
                  _buildSmallMargin(),
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FSuper(
                          padding: EdgeInsets.fromLTRB(9, 6, 9, 6),
                          text: '¥',
                          textSize: 11,
                          textColor: Colors.white,
                          spans: [
                            TextSpan(
                              text: '370起 ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: '2.4折',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                          backgroundColor: Colors.redAccent,
                          corner: Corner.all(20),
                        ),
                        FSuper(
                          text: 'GO',
                          textColor: Color(0xffB44431),
                          padding:
                              EdgeInsets.fromLTRB(9, 6, 3.0 + 12.0 + 6.0, 6),
                          backgroundColor: Color(0xfffeebc5),
                          corner: Corner.all(15),
                          child1: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xffB44431),
                          ),
                          child1Alignment: Alignment.centerRight,
                          child1Margin: EdgeInsets.only(right: 6),
                          onClick: () {
                            _showDialog(context, "HA.. Go Go Go!🏃️🏃️🏃️");
                          },
                        ),
                      ],
                    ),
                  ),
                  _buildDesc("corner 属性能够赋予 FSuper 边角\n"
                      "默认情况下，FSuper 的边角是圆角"),
                  FSuper(
                    width: 130,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    text: 'Corner FSuper',
                    backgroundColor: Color(0xffFF7043),
                    corner: Corner.all(12),
                    cornerStyle: CornerStyle.bevel,
                  ),
                  _buildDesc('设置 cornerStyle: CornerStyle.bevel 将变成斜切角'),
                  Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FSuper(
                          width: 130,
                          text: 'Corner FSuper',
                          backgroundColor: Color(0xff00B0FF),
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          corner: Corner(
                              leftTopCorner: 25,
                              leftBottomCorner: 25,
                              rightBottomCorner: 25),
                        ),
                        FSuper(
                          width: 130,
                          text: 'Corner FSuper',
                          backgroundColor: Color(0xffFFA726),
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          corner: Corner(rightTopCorner: 10),
                          cornerStyle: CornerStyle.bevel,
                        ),
                      ],
                    ),
                  ),
                  _buildDesc("通过设置单个 Corner 值，可以控制每个圆角"),
                  _buildTitle("Stroke"),
                  _buildSmallMargin(),
                  Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FSuper(
                          text: '私享假日时光',
                          textColor: Color(0xffe56837),
                          padding: EdgeInsets.fromLTRB(9, 2, 12.0 + 6.0, 2),
                          corner: Corner.all(16),
                          strokeColor: Color(0xffd76d44),
                          strokeWidth: 1,
                          child1: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color(0xffe56837),
                          ),
                          child1Alignment: Alignment.centerRight,
                          child1Margin: EdgeInsets.only(right: 6),
                        ),
                        FSuper(
                          text: '音乐类型:流行音乐',
                          textColor: Color(0xffc2bfc2),
                          padding: EdgeInsets.all(2),
                          corner: Corner.all(3),
                          strokeColor: Color(0xffc2bfc2),
                          strokeWidth: 1,
                        ),
                      ],
                    ),
                  ),
                  _buildDesc("FSuper 支持边框效果，只需要 strokeWidth > 0 即可"),
                  _buildTitle("Gradient"),
                  _buildSmallMargin(),
                  FSuper(
                    width: 280,
                    height: 45,
                    text: 'Search Flight',
                    textAlignment: Alignment.center,
                    textSize: 16,
                    textColor: Color(0xff333333),
                    corner: Corner.all(23),
                    gradient: LinearGradient(colors: [
                      Color(0xfffed83a),
                      Color(0xfffcad2c),
                    ]),
                  ),
                  _buildDesc("gradient 属性能够为 FSuper 设置渐变色背景\n"
                      "这会覆盖 backgroundColor 属性"),
                  _buildTitle("Shadow"),
                  _buildSmallMargin(),
                  FSuper(
                    text: 'Overview',
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(6.0 + 18.0 + 6.0, 9, 9, 9),
                    corner: Corner(rightTopCorner: 20, rightBottomCorner: 20),
                    child1: Icon(
                      Icons.subject,
                      size: 18,
                      color: Color(0xffa6a4a7),
                    ),
                    child1Alignment: Alignment.centerLeft,
                    child1Margin: EdgeInsets.only(left: 3),
                    shadowColor: Colors.black38,
                    shadowBlur: 10,
                    onClick: () {
                      _showDialog(context, "Disco");
                    },
                  ),
                  _buildDesc('shadowColor 和 shadowBlur 属性能够设置阴影颜色和样式\n'
                      '而 shadowOffset 则可以控制阴影的偏移量'),
                  _buildTitle("ReadPoint"),
                  _buildMiddleMargin(),
                  Container(
                    width: 360,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FSuper(
                          width: 60,
                          height: 60,
                          backgroundColor: Color(0xffeeeeee),
                          corner: Corner.all(6),
                          redPoint: true,
                          redPointSize: 20,
                        ),
                        FSuper(
                          width: 60,
                          height: 60,
                          backgroundColor: Color(0xffeeeeee),
                          corner: Corner.all(6),
                          redPoint: true,
                          redPointSize: 20,
                          redPointText: "5",
                        ),
                        FSuper(
                          width: 60,
                          height: 60,
                          backgroundColor: Color(0xffeeeeee),
                          corner: Corner.all(6),
                          redPoint: true,
                          redPointSize: 20,
                          redPointText: "红包",
                        ),
                      ],
                    ),
                  ),
                  _buildDesc('通过设置 "redPoint: true" 可以展示一个小红点\n'
                      '使用 redPointSize 属性可以设置小红点的大小\n'
                      'redPointText 属性可以设置小红点中的文字\n'),
                  Container(
                    width: 360,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FSuper(
                          text: "Home",
                          width: 60,
                          height: 60,
                          textAlignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 6),
                          corner: Corner.all(6),
                          child1: Icon(
                            Icons.home,
                            size: 28,
                          ),
                          child1Alignment: Alignment.topCenter,
                          child1Margin: EdgeInsets.only(top: 6),
                          redPoint: true,
                          redPointSize: 10,
                          redPointOffset: Offset(-5, 0),
                        ),
                        FSuper(
                          width: 36,
                          height: 36,
                          corner: Corner.all(6),
                          redPoint: true,
                          redPointSize: 15,
                          redPointText: "99+",
                          redPointTextSize: 11,
                          child1: Icon(
                            Icons.chat_bubble,
                            size: 36,
                          ),
                        ),
                        FSuper(
                          text: "You have messages",
                          textColor: Colors.white,
                          redPoint: true,
                          redPointSize: 10,
                          redPointOffset: Offset(5, 3),
                          shadowColor: Color(0xffffc900),
                          shadowBlur: 18,
                        ),
                      ],
                    ),
                  ),
                  _buildDesc("通过 redPointOffset 可以控制小红点的位置\n"
                      "(0, 0) 点在 FSuper 的右上角"),
                  _buildTitle("Child1 & Child2"),
                  _buildSmallMargin(),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FSuper(
                          text: "综合排序",
                          textColor: Colors.blue,
//                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.fromLTRB(
                              8, 6, (4 + 12 + 8).toDouble(), 6),
                          corner: Corner.all(18),
                          child1: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.blue,
                            size: 15,
                          ),
                          child1Alignment: Alignment.centerRight,
                          child1Margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          onClick: () {
                            _showDialog(context, "Sorting..");
                          },
                        ),
                        FSuper(
                          text: "标签",
                          textColor: Colors.white,
                          backgroundColor: Color(0xffffc900),
                          padding: EdgeInsets.fromLTRB(
                              8, 6, (4 + 12 + 8).toDouble(), 6),
                          corner: Corner.all(18),
                          child1: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 11,
                          ),
                          child1Alignment: Alignment.centerRight,
                          child1Margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          onChild1Click: () {
                            _showDialog(context, "Close");
                          },
                        ),
                        FSuper(
                          text: "9999+",
                          height: 15,
                          textColor: Color(0xff333333),
                          padding: EdgeInsets.fromLTRB(22.0 + 3.0, 0, 0, 0),
                          child1: Icon(
                            Icons.message,
                            color: Color(0xff333333),
                            size: 22,
                          ),
                          child1Alignment: Alignment.centerLeft,
                          onClick: () {
                            _showDialog(context, "Message count: >9999");
                          },
                        ),
                      ],
                    ),
                  ),
                  _buildDesc("FSuper 允许设置最多两个确定大小的子组件\n"
                      "而且你能够通过 child1Alignment、child2Alignment\n"
                      "以及 child1Margin、child2Margin 来控制它们的位置"),
                  FSuper(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                        (12.0 + 15.0 + 8.0), 8, (15.0 + 12.0), 8),
                    margin: EdgeInsets.all(10),
                    corner: Corner.all(6),
                    backgroundColor: Color(0xfff3faf1),
                    strokeColor: Color(0xffe8f6e2),
                    strokeWidth: 1,
                    text: '成功提示的文案',
                    textColor: Colors.grey,
                    textAlignment: Alignment.centerLeft,
                    child1: Transform.rotate(
                      angle: 0,
                      child: Icon(
                        Icons.check_circle,
                        size: 15,
                        color: Color(0xff89cf6d),
                      ),
                    ),
                    child1Alignment: Alignment.centerLeft,
                    child1Margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  ),
                  FSuper(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                        (16.0 + 25.0 + 12), 8, (0.0 + 8.0), 8),
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    corner: Corner.all(6),
                    backgroundColor: Color(0xfffff0e7),
                    strokeColor: Color(0xfffee0cd),
                    strokeWidth: 1,
                    text: '警告提示的文案',
                    textColor: Color(0xff7e7c7a),
                    textAlignment: Alignment.centerLeft,
                    textAlign: TextAlign.left,
                    spans: [
                      FSuper.VerticalSpace(8),
                      TextSpan(
                        text: "错误提示的辅助性文字介绍错误提示的辅助性文字介绍错误提"
                            "示的辅助性文字介绍错误提示的辅助性文字介绍错误提示的辅"
                            "助性文字介绍错误提示的辅助性文字介绍",
                        style: TextStyle(
                          color: Color(0xffc2c9cc),
                          fontSize: 11,
                        ),
                      )
                    ],
                    child1: Transform.rotate(
                      angle: pi,
                      child: Icon(
                        Icons.info,
                        size: 25,
                        color: Color(0xfffd6721),
                      ),
                    ),
                    child1Alignment: Alignment.centerLeft,
                    child1Margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child2: Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.black38,
                    ),
                    child2Alignment: Alignment.topRight,
                    child2Margin: EdgeInsets.fromLTRB(0, 8, 12, 0),
                    onChild2Click: () {
                      _showDialog(context, "关闭警告⚠️");
                    },
                  ),
                  _buildDesc("你需要确定 FSuper 的大小，或者让 FSuper 自适应大小\n"
                      "通过 padding 来为子组件留够位置\n"
                      "当然，你可以为子组件设置点击事件监听\n"
                      "通过 onChild1Click 和 onChild2Click"),
                  _buildTitle('FSuper Power'),
                  _buildSmallMargin(),
                  FSuper(
                    width: double.infinity,
                    text: "FWidget",
                    textAlign: TextAlign.left,
                    textSize: 18,
                    textWeight: FontWeight.w600,
                    padding:
                        EdgeInsets.fromLTRB(12.0 + 60.0 + 12.0, 20, 12, 20),
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    strokeWidth: 1,
                    strokeColor: Colors.grey[300],
                    backgroundColor: Colors.white,
                    corner: Corner.all(9),
                    spans: [
                      FSuper.VerticalSpace(9),
                      TextSpan(
                          text: "构建精美 Flutter 应用的绝佳利器 ⚔️",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              fontWeight: FontWeight.w300))
                    ],
                    child1: SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.network(
                            "https://gw.alicdn.com/tfs/TB1a288sxD1gK0jSZFKXXcJrVXa-360-360.png")),
                    child1Alignment: Alignment.centerLeft,
                    child1Margin: EdgeInsets.only(left: 9),
                    child2: FSuper(
                      text: 'Start Now',
                      textColor: Color(0xffffad2f),
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      corner: Corner.all(14),
                      strokeColor: Color(0xffffc900),
                      strokeWidth: 1,
                    ),
                    child2Alignment: Alignment.centerRight,
                    child2Margin: EdgeInsets.only(right: 9),
                    onChild2Click: () {
                      _showDialog(context, "Welcome to use FWidget ⚔");
                    },
                  ),
                  _buildSmallMargin(),
                  _buildDesc('使用 FSuper 能够快速构建出精美的组件\n'
                      '你甚至可以将 child1、child2 也设置成 FSuper\n'
                      '再复杂的视图也能轻松迎刃而解 😉'),
                  _buildSmallMargin(),
                  FSuper(
                    height: 86,
                    padding: EdgeInsets.fromLTRB(12.0 + 80.0 + 12.0, 0, 0, 0),
                    text: '泰国之行',
                    textSize: 15,
                    textAlignment: Alignment.centerLeft,
                    textAlign: TextAlign.left,
                    textWeight: FontWeight.w600,
                    spans: [
                      FSuper.VerticalSpace(8),
                      TextSpan(
                          text: '**月**日-**月**日 | **天',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffb8b4b8),
                              fontWeight: FontWeight.normal)),
                    ],
                    corner: Corner.all(10),
                    backgroundColor: Colors.white,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    shadowColor: Colors.black38.withOpacity(0.12),
                    shadowBlur: 5,
                    child1: Container(
                      width: 80,
                      height: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://bkimg.cdn.bcebos.com/pic/023b5bb5c9ea15cef6ee42feb7003af33b87b2c1@wm_1,g_7,k_d2F0ZXIvYmFpa2U5Mg==,xp_5,yp_5",
                          ),
                        ),
                      ),
                    ),
                    child1Alignment: Alignment.centerLeft,
                    child1Margin: EdgeInsets.only(left: 12),
                    child2: FSuper(
                      width: 76,
                      height: 30,
                      text: '查看',
                      textColor: Color(0xff333333),
                      textAlignment: Alignment.center,
                      corner: Corner.all(15),
                      strokeWidth: 1,
                      strokeColor: Color(0xfff3f1f7),
                    ),
                    child2Alignment: Alignment.centerRight,
                    child2Margin: EdgeInsets.only(right: 12),
                    onChild2Click: () {
                      _showDialog(context, "HAHAHAHA.. 😄");
                    },
                  ),
                  _buildSmallMargin(),
                  _buildDesc("尝试使用 FSuper 构建精美的组件吧！"),
                  _buildSmallMargin(),
                  FSuper(
                    width: double.infinity,
                    height: 78,
                    text: '舌尖风味',
                    textWeight: FontWeight.w600,
                    spans: [
                      FSuper.VerticalSpace(6),
                      TextSpan(
                          text: '时令甄选美食 VIP专属价',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ))
                    ],
                    textSize: 20,
                    textColor: Colors.white,
                    textAlignment: Alignment.centerLeft,
                    textAlign: TextAlign.left,
                    padding: EdgeInsets.only(left: 12),
                    margin: EdgeInsets.only(left: 12, right: 12),
                    corner: Corner(leftTopCorner: 10, rightTopCorner: 10),
                    backgroundImage: NetworkImage(
                        'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=4186127082,3602109448&fm=15&gp=0.jpg'),
                    child1: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    child1Alignment: Alignment.centerRight,
                    child1Margin: EdgeInsets.only(right: 12),
                    shadowColor: Colors.black38.withOpacity(0.28),
                    shadowBlur: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xfff3f0f3),
                    ),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: FSuper(
                            text: 'Hi, Welcome to use FWidget.',
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 15, bottom: 15),
                            backgroundColor: Color(0xffa5ed7e),
                            corner: Corner.all(6),
                            child1: Transform.rotate(
                              angle: pi / 4,
                              child: FSuper(
                                width: 10,
                                height: 10,
                                backgroundColor: Color(0xffa5ed7e),
                                corner: Corner.all(1.5),
                              ),
                            ),
                            child1Alignment: Alignment.topRight,
                            child1Margin: EdgeInsets.only(right: -4, top: 20),
                            shadowColor: Color(0xffa5ed7e),
                            shadowBlur: 5,
                          ),
                        ),
                        _buildMiddleMargin(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: FSuper(
                            text: 'FWidget is great!Very useful!',
                            textAlign: TextAlign.left,
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 15, bottom: 15),
                            backgroundColor: Colors.white,
                            corner: Corner.all(6),
                            child1: Transform.rotate(
                              angle: pi / 4,
                              child: FSuper(
                                width: 10,
                                height: 10,
                                backgroundColor: Colors.white,
                                corner: Corner.all(1.5),
                              ),
                            ),
                            child1Alignment: Alignment.topLeft,
                            child1Margin: EdgeInsets.only(left: -4, top: 20),
                            shadowColor: Colors.white,
                            shadowBlur: 5,
                          ),
                        ),
                        _buildMiddleMargin(),
                        Align(
                          alignment: Alignment.topRight,
                          child: FSuper(
                            text: "I'm created by FSuper 😄",
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 15, bottom: 15),
                            backgroundColor: Color(0xffa5ed7e),
                            corner: Corner.all(6),
                            child1: Transform.rotate(
                              angle: pi / 4,
                              child: FSuper(
                                width: 10,
                                height: 10,
                                backgroundColor: Color(0xffa5ed7e),
                                corner: Corner.all(1.5),
                              ),
                            ),
                            child1Alignment: Alignment.topRight,
                            child1Margin: EdgeInsets.only(right: -4, top: 20),
                            shadowColor: Color(0xffa5ed7e),
                            shadowBlur: 5,
                          ),
                        ),
                        _buildMiddleMargin(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: FSuper(
                            text: "So am I 😄",
                            textAlign: TextAlign.left,
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 15, bottom: 15),
                            backgroundColor: Colors.white,
                            corner: Corner.all(6),
                            child1: Transform.rotate(
                              angle: pi / 4,
                              child: FSuper(
                                width: 10,
                                height: 10,
                                backgroundColor: Colors.white,
                                corner: Corner.all(1.5),
                              ),
                            ),
                            child1Alignment: Alignment.topLeft,
                            child1Margin: EdgeInsets.only(left: -4, top: 20),
                            shadowColor: Colors.white,
                            shadowBlur: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildMiddleMargin(),
                  _buildMiddleMargin(),
                ],
              ),
            );
          },
        ));
  }

  SizedBox _buildMiddleMargin() {
    return const SizedBox(
      height: 18,
    );
  }

  SizedBox _buildSmallMargin() {
    return const SizedBox(
      height: 10,
    );
  }

  void _showDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    msg,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              backgroundColor: Colors.black45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ));
  }

  Padding _buildDesc(String desc) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ));
  }

  Container _buildTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(9),
      color: Color(0xffe0e0e0).withOpacity(0.38),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}

class Test extends StatelessWidget {
  String text;

  Test(this.text);

  @override
  Widget build(BuildContext context) {
    return FSuper(
      text: text,
//            padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
      backgroundColor: Colors.blue,
      child1: Icon(Icons.check_circle),
      child1Alignment: Alignment.bottomRight,
//            child1Margin: EdgeInsets.all(20),
      margin: EdgeInsets.all(50),
//            padding: EdgeInsets.all(50),
      redPoint: true,
      onChild1Click: () {},
    );
  }
}
