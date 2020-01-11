import 'package:flutter/material.dart';

enum CornerStyle {
  round,
  bevel,
}

enum AlignTextMode {
  left,
  top,
  right,
  bottom,
}

class FSuper extends StatefulWidget {
  double width;
  double height;
  double maxWidth;
  double maxHeight;
  String text;
  Color textColor;
  double textSize;
  FontStyle textStyle;
  FontWeight textWeight;
  Alignment textAlignment;
  TextAlign textAlign;
  List<TextSpan> spans;
  GestureTapCallback onClick;
  Color backgroundColor;
  Gradient gradient;
  ImageProvider backgroundImage;
  Corner corner;
  CornerStyle cornerStyle;
  EdgeInsetsGeometry padding;
  EdgeInsets margin;
  Widget child1;
  Alignment child1Alignment;
  EdgeInsets child1Margin;
  GestureTapCallback onChild1Click;
  Widget child2;
  Alignment child2Alignment;
  EdgeInsets child2Margin;
  GestureTapCallback onChild2Click;
  bool redPoint;
  Color redPointColor;
  double redPointSize;
  String redPointText;
  Color redPointTextColor;
  double redPointTextSize;
  Offset redPointOffset;
  Color strokeColor;
  double strokeWidth;
  Color shadowColor;
  Offset shadowOffset;
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

  static TextSpan VerticalSpace(double space) {
    return TextSpan(
        text: '\n \n',
        style: TextStyle(
          fontSize: 1,
          height: space,
        ));
  }

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
  GlobalKey textContainerKey = GlobalKey();
  Size containerSize;

  @override
  void initState() {
//    print("initState");
    WidgetsBinding.instance.addPostFrameCallback(_handleSizeChanged);
    super.initState();
  }

  void _handleSizeChanged(duration) {
    if (!mounted) return;
    var renderBox =
        textContainerKey.currentContext.findRenderObject() as RenderBox;
    if (containerSize != renderBox.size ||
        (widget.maxHeight != null &&
            renderBox.size.height > widget.maxHeight)) {
      setState(() {
        if (widget.maxHeight != null &&
            renderBox.size.height > widget.maxHeight) {
          containerSize = Size(renderBox.size.width, widget.maxHeight);
          widget.height = widget.maxHeight;
        } else {
          containerSize = renderBox.size;
        }
      });
//      print("_handleSizeChanged.setState");
    }
    WidgetsBinding.instance.addPostFrameCallback(_handleSizeChanged);
//    print("_handleSizeChanged");
  }

  @override
  Widget build(BuildContext context) {
//    print("build");
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
      ),
    );

    double textWidth;
    if (widget.width == null) {
      var textRenderObjectWidget =
          (textPart.build(context) as RenderObjectWidget);
      // ignore: invalid_use_of_protected_member
      var textRenderObject = textRenderObjectWidget.createRenderObject(context);
      textRenderObject.layout(BoxConstraints());
      if (widget.width == null) {
        textWidth = textRenderObject.paintBounds.width;
      }
    }
    if (widget.padding != null && textWidth != null) {
      textWidth += widget.padding.horizontal;
    }
    if (widget.maxWidth != null) {
      if ((textWidth != null && textWidth > widget.maxWidth) ||
          (widget.width != null && widget.width > widget.maxWidth)) {
        widget.width = widget.maxWidth;
      }
    }
    List<Widget> children = [];
    var containerPart = Container(
      key: textContainerKey,
      padding: widget.padding,
      alignment: widget.textAlignment,
      width: widget.width,
      height: widget.height,
      decoration: decoration,
      child: textPart,
    );
    children.add(containerPart);

    if (containerSize != null) {
      if (widget.child1 != null || widget.child2 != null) {
        SizedBox childPart = _buildChildPart();
        children.add(childPart);
      }
    }

    if (widget.redPoint) {
      var redPointPart = _buildRedPoint();
      children.add(redPointPart);
    }
    var stackPart = Stack(
      overflow: Overflow.visible,
      children: children,
    );
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
          color: Colors.redAccent,
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

class Corner {
  final double leftTopCorner;
  final double rightTopCorner;
  final double rightBottomCorner;
  final double leftBottomCorner;

  const Corner({
    this.leftTopCorner = 0,
    this.rightTopCorner = 0,
    this.rightBottomCorner = 0,
    this.leftBottomCorner = 0,
  });

  Corner.all(double radius)
      : leftTopCorner = radius,
        rightTopCorner = radius,
        rightBottomCorner = radius,
        leftBottomCorner = radius;
}

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

class _ChildInfo {
  String type;
  Alignment alignment;
  EdgeInsets margin;
}
