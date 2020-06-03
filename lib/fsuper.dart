/// Copyright 1999-2020 Fliggy Android Team <alitrip_android@list.alibaba-inc.com>.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at following link.
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';

/// 圆角风格。
/// [round] - 圆角
/// [bevel] - 斜角
///
/// Rounded corner style.
/// [round]-rounded corners
/// [bevel]-beveled corners
enum CornerStyle {
  round,
  bevel,
}

/// FSuper 是一个强大的组件，能够支持富文本、圆角、边框、图片、小红点、以及同时设置多达两个子组件，且能够通过相对位置控制它们。
/// FSuper 能够帮助开发者快速舒适的构建复杂视图。
///
/// FSuper is a powerful component that can support rich text, rounded corners, borders, pictures, small red dots, and set up to two sub-components at the same time, and control their relative positions.
/// FSuper can help developers build complex views quickly and comfortably.
// ignore: must_be_immutable
class FSuper extends StatefulWidget {
  /// 宽。null 将会自适应文字大小。设置 double.infinity 将会充满父容器。
  ///
  /// Width，null will adapt the text size. Setting double.infinity will fill the parent container.
  double width;

  /// 宽。null 将会自适应文字大小。
  ///
  /// Height， null will adapt the text size.
  double height;

  /// 组件最大宽度。
  ///
  /// Maximum component width.
  double maxWidth;

  /// 组件最大高度
  ///
  /// Maximum component height
  double maxHeight;

  /// 文字内容
  ///
  /// Text content
  String text;

  /// 文字颜色
  ///
  /// Text color
  Color textColor;

  /// 文字字号
  ///
  /// Text size
  double textSize;

  /// 文字风格。详见 [TextStyle]
  ///
  /// Text style. See [TextStyle] for details
  FontStyle textStyle;

  /// 文字宽度。默认 [FontWeight.normal]
  ///
  /// Text width. Default [FontWeight.normal]
  FontWeight textWeight;

  /// 一行文字高度 = textSize * fontHeight
  ///
  /// height of one line of text = textSize * fontHeight
  double fontHeight;

  /// 文字整体相对位置。详见 [Alignment]
  ///
  /// The overall relative position of the text. See [Alignment] for details
  Alignment textAlignment;

  /// 文字对齐方式。详见 [Align]
  ///
  /// Text alignment. See [Align] for details
  TextAlign textAlign;

  /// 富文本内容。详见 [TextSpan] 。
  /// [TextSpan] 元素默认会使用 [textColor]，[textSize]，[textStyle]，[textWeight] 的配置。
  ///
  /// Rich text content. See [TextSpan] for more details.
  /// The [TextSpan] element uses the configuration of [textColor], [textSize], [textStyle], [textWeight] by default.
  List<TextSpan> spans;

  /// 点击监听回调
  ///
  /// Click listen callback
  GestureTapCallback onClick;

  /// 组件背景颜色。
  ///
  /// Component background color
  Color backgroundColor;

  /// 设置组件渐变色背景。会覆盖 [backgroundColor]
  /// 你可选择 [LinearGradient]，[RadialGradient]，[SweepGradient] 等..
  ///
  /// Sets the gradient background of the component. [BackgroundColor]
  /// You can choose [LinearGradient], [RadialGradient], [SweepGradient], etc ..
  Gradient gradient;

  /// 组件背景图片，会覆盖 [backgroundColor]  和 [gradient]。详见 [ImageProvider]
  ///
  /// Component background image, overwrites [backgroundColor] and [gradient].
  /// See [ImageProvider] for details
  ImageProvider backgroundImage;

  /// 设置组件圆角。详见 [Corner]
  ///
  /// Sets the component fillet. See [Corner] for details
  Corner corner;

  /// 设置圆角风格，默认 [CornerStyle.round]
  ///
  /// Set rounded corner style, default [CornerStyle.round]
  CornerStyle cornerStyle;

  /// 设置组件内间距，只影响文字。通过该属性可以设置文字和 [FSuper.child1]、[FSuper.child2] 的间距。
  ///
  /// Sets the spacing between components, affecting only text.
  /// This property can set the space between the text and [FSuper.child1], [FSuper.child2].
  EdgeInsetsGeometry padding;

  /// 设置组件与父容器边缘的间距。详见 [EdgeInsets]
  ///
  /// Sets the distance between the component and the edge of the parent container. See [EdgeInsets] for details
  EdgeInsets margin;

  /// 子组件。子组件允许是任意类型的 Widget。
  /// 通过 [child1Alignment] 和 [child1Margin] 可以控制它在组件中的位置。
  ///
  /// Subassembly. Child components are allowed to be any type of widget.
  /// [Child1Alignment] and [child1Margin] can control its position in the component.
  Widget child1;

  /// 指定 [child1] 在组件中的相对位置
  ///
  /// Specify the relative position of the child component in the component
  Alignment child1Alignment;

  /// 基于 [child1] 的相对位置，为它设置偏移
  ///
  /// Set an offset for the child component based on its relative position
  EdgeInsets child1Margin;

  /// 为 [child1] 设置点击监听器
  ///
  /// Set click listener for [child1]
  GestureTapCallback onChild1Click;

  /// 子组件。子组件允许是任意类型的 Widget。
  /// 通过 [child1Alignment] 和 [child1Margin] 可以控制它在组件中的位置。
  ///
  /// Subassembly. Child components are allowed to be any type of widget.
  /// [Child1Alignment] and [child1Margin] can control its position in the component.
  Widget child2;

  /// 指定 [child2] 在组件中的相对位置
  ///
  /// Specify the relative position of the child component in the component
  Alignment child2Alignment;

  /// 基于 [child2] 的相对位置，为它设置偏移
  ///
  /// Set an offset for the child component based on its relative position
  EdgeInsets child2Margin;

  /// 为 [child2] 设置点击监听器
  ///
  /// Set click listener for [child2]
  GestureTapCallback onChild2Click;

  /// 是否显示小红点。默认不展示。
  ///
  /// Whether to show the Red Point.Not displayed by default.
  bool redPoint;

  /// 小红点颜色。默认 [Colors.redAccent]
  ///
  /// Red Point color. Default [Colors.redAccent]
  Color redPointColor;

  /// 设置 Red Point 大小。Red Point 的 宽=高
  ///
  /// Set the Red Point size. Red Point width = height
  double redPointSize;

  /// 设置 Red Point 中的文字。比如消息数量..
  ///
  /// Set the text in Red Point. Like number of messages ...
  String redPointText;

  /// 设置 Red Point 中文字的颜色。默认 [Colors.white]
  ///
  /// Sets the color of text in Red Point. Default [Colors.white]
  Color redPointTextColor;

  /// 设置 Red Point 中文字的字号。默认 11
  ///
  /// Sets the font size of the text in Red Point. Default 11
  double redPointTextSize;

  /// 基于组件右上角设置 Red Point 的位置偏移。
  /// 默认 Red Point 会向右上方偏移 [redPointSize] / 2
  ///
  /// Sets the position of the Red Point based on the upper right corner of the component.
  /// The default Red Point is shifted to the upper right [redPointSize] / 2
  Offset redPointOffset;

  /// 设置边框颜色。
  ///
  /// Set the border color.
  Color strokeColor;

  /// 设置边框宽
  ///
  /// Set border width
  double strokeWidth;

  /// 设置组件阴影颜色
  ///
  /// Set component shadow color
  Color shadowColor;

  /// 设置组件阴影偏移
  ///
  /// Set component shadow offset
  Offset shadowOffset;

  /// 设置组件高斯与阴影形状卷积的标准偏差。
  ///
  /// Sets the standard deviation of the component's Gaussian convolution with the shadow shape.
  double shadowBlur;

  FSuper({
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.text,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.textWeight,
    this.fontHeight,
    this.textAlignment,
    this.textAlign,
    this.spans,
    this.onClick,
    this.backgroundColor,
    this.backgroundImage,
    this.child1,
    this.child1Alignment,
    this.child1Margin,
    this.onChild1Click,
    this.child2,
    this.child2Alignment,
    this.child2Margin,
    this.onChild2Click,
    this.redPoint = false,
    this.redPointColor = Colors.redAccent,
    this.redPointSize = 20,
    this.redPointOffset,
    this.redPointText,
    this.redPointTextColor = Colors.white,
    this.redPointTextSize = 11,
    this.gradient,
    this.padding,
    this.corner,
    this.cornerStyle = CornerStyle.round,
    this.strokeColor,
    this.strokeWidth,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlur = 1,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return _FSuperState();
  }

  /// 在富文本 [spans] 中插入垂直方向的文字间距
  ///
  /// Insert vertical spacing in rich text [spans]
  static TextSpan VerticalSpace(double space) {
    return TextSpan(
        text: '\n \n',
        style: TextStyle(
          fontSize: 1,
          height: space,
        ));
  }

  /// 在富文本 [spans] 中插入水平方向的文字间距
  ///
  /// Insert horizontal spacing in rich text [spans]
  static TextSpan HorizontalSpace(double space) {
    return TextSpan(
        text: " ",
        style: TextStyle(
          fontSize: 0.1,
          wordSpacing: (space - 1),
        ));
  }
}

class _FSuperState extends State<FSuper> {
  GlobalKey key = GlobalKey();
  Size containerSize;

  /// [FSuper] 在初始化时会注册一帧回调，当组件首次测量完成后，将会根据现有尺寸根据再次确定尺寸配置。
  /// 接着会确定 [FSuper.child1]，[FSuper.child2] 的位置。
  /// 最后会再次触发绘制。
  ///
  /// [FSuper] A frame callback is registered during initialization.
  /// After the component's first measurement is completed, the size configuration will be determined again based on the existing size.
  /// Then the location of [FSuper.child1], [FSuper.child2] will be determined.
  /// Finally, the drawing will be triggered again.
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_handleSizeChanged);
    super.initState();
  }

  void _handleSizeChanged(duration) {
    if (!mounted) return;
    RenderBox box = key.currentContext.findRenderObject() as RenderBox;
    if (box != null && containerSize != box.size) {
      setState(() {
        containerSize = box.size;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback(_handleSizeChanged);
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textTheme = themeData.textTheme;
    widget.textColor = widget.textColor ?? textTheme.body1.color;
    widget.textSize = widget.textSize ?? textTheme.body1.fontSize;
    widget.textStyle = widget.textStyle ?? textTheme.body1.fontStyle;
    double opacity = 0.38;
    BorderRadius borderRadius = widget.corner == null
        ? BorderRadius.all(Radius.circular(0))
        : BorderRadius.only(
            topLeft: Radius.circular(widget.corner.leftTopCorner),
            topRight: Radius.circular(widget.corner.rightTopCorner),
            bottomRight: Radius.circular(widget.corner.rightBottomCorner),
            bottomLeft: Radius.circular(widget.corner.leftBottomCorner),
          );
    var sideColor = widget.strokeColor ?? Colors.transparent;
    var borderSide = BorderSide(
      width: widget.strokeWidth ?? 0,
      color: sideColor,
      style: BorderStyle.solid,
    );
    var shape = widget.cornerStyle == CornerStyle.round
        ? RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: borderSide,
          )
        : BeveledRectangleBorder(
            borderRadius: borderRadius,
            side: borderSide,
          );
    var decorationImage = widget.backgroundImage != null
        ? DecorationImage(
            fit: BoxFit.cover,
            image: widget.backgroundImage,
          )
        : null;
    var decoration = ShapeDecoration(
        color: widget.backgroundColor,
        gradient: widget.gradient,
        image: decorationImage,
        shadows: widget.shadowColor != null && widget.shadowBlur != 0
            ? [
                BoxShadow(
                  color: widget.shadowColor ??
                      widget.backgroundColor.withOpacity(opacity),
                  offset: widget.shadowOffset ?? Offset(0, 0),
                  blurRadius: widget.shadowBlur,
                )
              ]
            : null,
        shape: shape);
    var textPart = Text.rich(
      TextSpan(text: widget.text, children: widget.spans),
      textAlign: widget.textAlign ?? TextAlign.center,
      style: TextStyle(
        color: widget.textColor,
        fontStyle: widget.textStyle,
        fontSize: widget.textSize,
        fontWeight: widget.textWeight,
        height: widget.fontHeight,
      ),
    );
    List<Widget> children = [];

    /// Build base text area
    Widget containerPart = Container(
      key: key,
      padding: widget.padding,
      alignment: widget.textAlignment,
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      child: textPart,
    );
    if (widget.maxWidth != null || widget.maxHeight != null) {
      containerPart = LimitedBox(
        maxWidth: widget.maxWidth ?? double.infinity,
        maxHeight: widget.maxHeight ?? double.infinity,
        child: containerPart,
      );
    }
    children.add(containerPart);

    /// if getted [containerSize]， [child1] or [child2] not null，build child part
    if (containerSize != null) {
      if (widget.child1 != null || widget.child2 != null) {
        SizedBox childPart = _buildChildPart();
        children.add(childPart);
      }
    }

    /// build red point
    if (widget.redPoint) {
      var redPointPart = _buildRedPoint();
      children.add(redPointPart);
    }

    /// build up
    var stackPart = Stack(
      overflow: Overflow.visible,
      children: children,
    );

    /// add click listener
    var gestureDetectorPart = GestureDetector(
      onTap: widget.onClick,
      child: stackPart,
    );
    var result = Semantics(
      button: true,
      child: widget.margin == null
          ? gestureDetectorPart
          : Padding(
              padding: widget.margin,
              child: gestureDetectorPart,
            ),
    );
    return result;
  }

  /// 创建 [FSuper.child1] 和  [FSuper.child2] 部分
  ///
  /// Create [FSuper.child1] and [FSuper.child2] part
  SizedBox _buildChildPart() {
    List<_ChildInfo> childInfos = [];
    List<Widget> layoutIds = [];
    if (widget.child1 != null) {
      var childInfo = _ChildInfo()
        ..type = "child1"
        ..alignment = widget.child1Alignment
        ..margin = widget.child1Margin;
      childInfos.add(childInfo);
      layoutIds.add(LayoutId(
          id: childInfo,
          child: GestureDetector(
            onTap: widget.onChild1Click,
            child: widget.child1,
          )));
    }
    if (widget.child2 != null) {
      var childInfo = _ChildInfo()
        ..type = "child2"
        ..alignment = widget.child2Alignment
        ..margin = widget.child2Margin;
      childInfos.add(childInfo);
      layoutIds.add(LayoutId(
          id: childInfo,
          child: GestureDetector(
            onTap: widget.onChild2Click,
            child: widget.child2,
          )));
    }
    var childPart = SizedBox(
      width: containerSize.width,
      height: containerSize.height,
      child: CustomMultiChildLayout(
        delegate: _LayoutDelegate(childInfos),
        children: layoutIds,
      ),
    );
    return childPart;
  }

  Positioned _buildRedPoint() {
    bool redPointTextEmpty =
        widget.redPointText == null || widget.redPointText == "";
    double redPointTextSize = redPointTextEmpty ? 0 : widget.redPointTextSize;
    var offset = widget.redPointOffset ??
        Offset(widget.redPointSize / 2, widget.redPointSize / 2);
    var redPointPart = Positioned(
      right: -offset.dx,
      top: -offset.dy,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            redPointTextSize / 2, 0, redPointTextSize / 2, 0),
        constraints: BoxConstraints(
          minWidth: widget.redPointSize,
          maxHeight: widget.redPointSize,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.redPointColor,
          borderRadius:
              BorderRadius.all(Radius.circular(widget.redPointSize / 2)),
        ),
        child: redPointTextEmpty
            ? null
            : Text(
                widget.redPointText ?? "",
                style: TextStyle(
                    color: widget.redPointTextColor,
                    fontSize: redPointTextSize),
              ),
      ),
    );
    return redPointPart;
  }
}

/// 为 [FSuper] 设置圆角。详见 [FSuper.corner]
///
/// Set rounded corners for [FSuper]. See [FSuper.corner] for details
class Corner {
  final double leftTopCorner;
  final double rightTopCorner;
  final double rightBottomCorner;
  final double leftBottomCorner;

  /// 指定每一个圆角的大小
  ///
  /// Specify the size of each rounded corner
  const Corner({
    this.leftTopCorner = 0,
    this.rightTopCorner = 0,
    this.rightBottomCorner = 0,
    this.leftBottomCorner = 0,
  });

  /// 设置所有圆角为一个大小
  ///
  /// Set all rounded corners to one size
  Corner.all(double radius)
      : leftTopCorner = radius,
        rightTopCorner = radius,
        rightBottomCorner = radius,
        leftBottomCorner = radius;
}

/// 确定 [FSuper.child1] 和 [FSuper.child2] 在 [FSuper] 中的位置
///
/// Determine where [FSuper.child1] and [FSuper.child2] are in [FSuper]
class _LayoutDelegate extends MultiChildLayoutDelegate {
  List<_ChildInfo> childInfos;

  _LayoutDelegate(this.childInfos)
      : assert(childInfos != null),
        super();

  @override
  void performLayout(Size size) {
    _ChildInfo child1;
    _ChildInfo child2;
    for (_ChildInfo temp in childInfos) {
      if (temp.type == "child1") {
        child1 = temp;
      } else if (temp.type == "child2") {
        child2 = temp;
      }
    }

    if (child1 != null) {
      handleChild(child1, size);
    }
    if (child2 != null) {
      handleChild(child2, size);
    }
  }

  /// 在首次测量获得 [FSuper] 的准确大小后，根据 [FSuper.child1] 和 [FSuper.child2] 的配置确定它们的位置
  ///
  /// After obtaining the exact size of [FSuper] for the first measurement, position them according to the configuration of [FSuper.child1] and [FSuper.child2]
  void handleChild(_ChildInfo child, Size size) {
    Size childSize = layoutChild(
        child, BoxConstraints(maxWidth: size.width, maxHeight: size.height));
    Offset childOffset;
    if (child.alignment == Alignment.topLeft) {
      childOffset = Offset(0, 0);
    } else if (child.alignment == Alignment.topCenter) {
      childOffset = Offset(size.width / 2 - childSize.width / 2, 0);
    } else if (child.alignment == Alignment.topRight) {
      childOffset = Offset(size.width - childSize.width, 0);
    } else if (child.alignment == Alignment.centerRight) {
      childOffset = Offset(
          size.width - childSize.width, size.height / 2 - childSize.height / 2);
    } else if (child.alignment == Alignment.bottomRight) {
      childOffset =
          Offset(size.width - childSize.width, size.height - childSize.height);
    } else if (child.alignment == Alignment.bottomCenter) {
      childOffset = Offset(
          size.width / 2 - childSize.width / 2, size.height - childSize.height);
    } else if (child.alignment == Alignment.bottomLeft) {
      childOffset = Offset(0, size.height - childSize.height);
    } else if (child.alignment == Alignment.centerLeft) {
      childOffset = Offset(0, size.height / 2 - childSize.height / 2);
    } else {
      childOffset = Offset(size.width / 2 - childSize.width / 2,
          size.height / 2 - childSize.height / 2);
    }
    if (child.margin != null) {
      childOffset = childOffset.translate(
          child.margin.left - child.margin.right,
          child.margin.top - child.margin.bottom);
    }
    positionChild(child, childOffset);
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

/// 用于记录 [FSuper.child1] 和 [FSuper.child2] 的信息。
/// 在进行布局的时候会用到。
///
/// Used to record the information of [FSuper.child1] and [FSuper.child2].
/// will be used during layout.
class _ChildInfo {
  String type;
  Alignment alignment;
  EdgeInsets margin;
}
