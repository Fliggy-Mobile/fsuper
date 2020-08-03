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
export 'package:fcontrol/fdefine.dart';
import 'package:fcontrol/fcontrol.dart';
import 'package:fcontrol/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;

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
  final double width;

  /// 宽。null 将会自适应文字大小。
  ///
  /// Height， null will adapt the text size.
  final double height;

  /// 组件最大宽度。
  ///
  /// Maximum component width.
  final double maxWidth;

  /// 组件最大高度
  ///
  /// Maximum component height
  final double maxHeight;

  /// 文字内容
  ///
  /// Text content
  final String text;

  /// Widget 文本样式
  ///
  /// Widget text style
  final TextStyle style;

  /// 文字整体相对位置。详见 [Alignment]
  ///
  /// The overall relative position of the text. See [Alignment] for details
  final Alignment textAlignment;

  /// 文字对齐方式。详见 [Align]
  ///
  /// Text alignment. See [Align] for details
  final TextAlign textAlign;

  /// 富文本内容。详见 [TextSpan] 。
  /// [TextSpan] 元素默认会使用 [textColor]，[textSize]，[textStyle]，[textWeight] 的配置。
  ///
  /// Rich text content. See [TextSpan] for more details.
  /// The [TextSpan] element uses the configuration of [textColor], [textSize], [textStyle], [textWeight] by default.
  final List<TextSpan> spans;

  /// 点击监听回调
  ///
  /// Click listen callback
  final GestureTapCallback onClick;

  /// 组件背景颜色。
  ///
  /// Component background color
  final Color backgroundColor;

  /// 设置组件渐变色背景。会覆盖 [backgroundColor]
  /// 你可选择 [LinearGradient]，[RadialGradient]，[SweepGradient] 等..
  ///
  /// Sets the gradient background of the component. [BackgroundColor]
  /// You can choose [LinearGradient], [RadialGradient], [SweepGradient], etc ..
  final Gradient gradient;

  /// 组件背景图片，会覆盖 [backgroundColor]  和 [gradient]。详见 [ImageProvider]
  ///
  /// Component background image, overwrites [backgroundColor] and [gradient].
  /// See [ImageProvider] for details
  final ImageProvider backgroundImage;

  /// 设置组件圆角。详见 [FCorner]
  ///
  /// Sets the component fillet. See [FCorner] for details
  final FCorner corner;

  /// 设置圆角风格，默认 [FCornerStyle.round]
  ///
  /// Set rounded corner style, default [FCornerStyle.round]
  final FCornerStyle cornerStyle;

  /// 设置组件内间距，只影响文字。通过该属性可以设置文字和 [FSuper.child1]、[FSuper.child2] 的间距。
  ///
  /// Sets the spacing between components, affecting only text.
  /// This property can set the space between the text and [FSuper.child1], [FSuper.child2].
  final EdgeInsetsGeometry padding;

  /// 设置组件与父容器边缘的间距。详见 [EdgeInsets]
  ///
  /// Sets the distance between the component and the edge of the parent container. See [EdgeInsets] for details
  final EdgeInsets margin;

  /// 子组件。子组件允许是任意类型的 Widget。
  /// 通过 [child1Alignment] 和 [child1Margin] 可以控制它在组件中的位置。
  ///
  /// Subassembly. Child components are allowed to be any type of widget.
  /// [Child1Alignment] and [child1Margin] can control its position in the component.
  final Widget child1;

  /// 指定 [child1] 在组件中的相对位置
  ///
  /// Specify the relative position of the child component in the component
  final Alignment child1Alignment;

  /// 基于 [child1] 的相对位置，为它设置偏移
  ///
  /// Set an offset for the child component based on its relative position
  final EdgeInsets child1Margin;

  /// 为 [child1] 设置点击监听器
  ///
  /// Set click listener for [child1]
  final GestureTapCallback onChild1Click;

  /// 子组件。子组件允许是任意类型的 Widget。
  /// 通过 [child1Alignment] 和 [child1Margin] 可以控制它在组件中的位置。
  ///
  /// Subassembly. Child components are allowed to be any type of widget.
  /// [Child1Alignment] and [child1Margin] can control its position in the component.
  final Widget child2;

  /// 指定 [child2] 在组件中的相对位置
  ///
  /// Specify the relative position of the child component in the component
  final Alignment child2Alignment;

  /// 基于 [child2] 的相对位置，为它设置偏移
  ///
  /// Set an offset for the child component based on its relative position
  final EdgeInsets child2Margin;

  /// 为 [child2] 设置点击监听器
  ///
  /// Set click listener for [child2]
  final GestureTapCallback onChild2Click;

  /// 是否显示小红点。默认不展示。
  ///
  /// Whether to show the Red Point.Not displayed by default.
  final bool redPoint;

  /// 小红点颜色。默认 [Colors.redAccent]
  ///
  /// Red Point color. Default [Colors.redAccent]
  final Color redPointColor;

  /// 设置 Red Point 大小。Red Point 的 宽=高
  ///
  /// Set the Red Point size. Red Point width = height
  final double redPointSize;

  /// 设置 Red Point 中的文字。比如消息数量..
  ///
  /// Set the text in Red Point. Like number of messages ...
  final String redPointText;

  /// 小红点文本样式
  ///
  /// red point text style
  final TextStyle redPointTextStyle;

  /// 基于组件右上角设置 Red Point 的位置偏移。
  /// 默认 Red Point 会向右上方偏移 [redPointSize] / 2
  ///
  /// Sets the position of the Red Point based on the upper right corner of the component.
  /// The default Red Point is shifted to the upper right [redPointSize] / 2
  final Offset redPointOffset;

  /// 设置边框颜色。
  ///
  /// Set the border color.
  final Color strokeColor;

  /// 设置边框宽
  ///
  /// Set border width
  final double strokeWidth;

  /// 设置组件阴影颜色
  ///
  /// Set component shadow color
  final Color shadowColor;

  /// 设置组件阴影偏移
  ///
  /// Set component shadow offset
  final Offset shadowOffset;

  /// 设置组件高斯与阴影形状卷积的标准偏差。
  ///
  /// Sets the standard deviation of the component's Gaussian convolution with the shadow shape.
  final double shadowBlur;

  /// 是否支持 Neumorphism 风格。开启该项 [highlightColor] 将会失效
  ///
  /// Whether to support the Neumorphism style. Open this item [highlightColor] will be invalid
  final bool isSupportNeumorphism;

  /// 当 [isSupportNeumorphism] 为 true 时有效。光源方向，分为左上、左下、右上、右下四个方向。用来控制光源照射方向，会影响高亮方向和阴影方向
  ///
  /// Valid when [isSupportNeumorphism] is true. The direction of the light source is divided into four directions: upper left, lower left, upper right, and lower right. Used to control the illumination direction of the light source, which will affect the highlight direction and shadow direction
  final FLightOrientation lightOrientation;

  /// 开启 Neumorphism 风格后，亮部阴影颜色
  ///
  /// After the Neumorphism style is turned on, the bright shadow color
  final Color highlightShadowColor;

  /// 开启 Neumorphism 风格后，是否呈浮起效果，否则为凹陷效果，默认为 true
  ///
  /// Whether the Neumorphism style is turned on, whether it is a floating effect, otherwise it is a concave effect, the default is true
  final bool float;

  FSuper({
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.text,
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
    this.redPointTextStyle = const TextStyle(color: Colors.white, fontSize: 11),
    this.gradient,
    this.padding,
    this.corner,
    this.cornerStyle = FCornerStyle.round,
    this.strokeColor,
    this.strokeWidth,
    this.shadowColor,
    this.shadowOffset,
    this.shadowBlur = 1,
    this.margin,
    this.style,
    this.isSupportNeumorphism = false,
    this.highlightShadowColor,
    this.lightOrientation,
    this.float = true,
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
  GlobalKey rootKey = GlobalKey();
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
    RenderBox rootBox = rootKey.currentContext.findRenderObject() as RenderBox;
    if (rootBox != null && containerSize != rootBox.size) {
      setState(() {
        containerSize = rootBox.size;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback(_handleSizeChanged);
  }

  @override
  Widget build(BuildContext context) {
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
    var shape = widget.cornerStyle == FCornerStyle.round
        ? RoundedRectangleBorder(borderRadius: borderRadius)
        : BeveledRectangleBorder(borderRadius: borderRadius);

    /// shape
    FShape fShape = FShape(
      borderShape: widget.cornerStyle == FCornerStyle.round
          ? FBorderShape.RoundedRectangle
          : FBorderShape.BeveledRectangle,
      side: borderSide,
      borderRadius: borderRadius,
    );

    var decorationImage = widget.backgroundImage != null
        ? DecorationImage(
            fit: BoxFit.cover,
            image: widget.backgroundImage,
          )
        : null;
    var decoration = decorationImage != null
        ? ShapeDecoration(image: decorationImage, shape: shape)
        : null;
    var textPart = Text.rich(
      TextSpan(text: widget.text, children: widget.spans),
      textAlign: widget.textAlign ?? TextAlign.center,
      style: widget.style,
    );
    List<Widget> children = [];

    /// Build base container
    Widget containerPart = FControl(
      key: rootKey,
      lightOrientation: widget.lightOrientation,
      width: widget.width,
      height: widget.height,
      shape: fShape,
      gradient: widget.gradient,
      supportDropShadow:
          (widget.shadowColor != null && widget.shadowBlur != 0.0) ||
              widget.isSupportNeumorphism,
      dropShadow: FShadow(
        highlightColor: widget.isSupportNeumorphism
            ? widget.highlightShadowColor ?? Colors.white.withOpacity(0.83)
            : Colors.transparent,
        highlightBlur: widget.isSupportNeumorphism ? _shadowBlur : 0.0,
        highlightDistance: shadowDistance,
        shadowColor: widget.shadowColor ?? Color(0xffd1d9e6),
        shadowBlur: _shadowBlur,
        shadowDistance: shadowDistance,
        shadowOffset: widget.shadowOffset,
      ),
      supportInnerShadow: widget.isSupportNeumorphism,
      innerShadow: FShadow(
        highlightColor:
            widget.highlightShadowColor ?? Colors.white.withOpacity(0.83),
        highlightBlur: _shadowBlur,
        highlightDistance: shadowDistance,
        shadowColor: widget.shadowColor ?? Color(0xffd1d9e6),
        shadowBlur: _shadowBlur,
        shadowDistance: shadowDistance,
      ),
      appearance: widget.isSupportNeumorphism
          ? FAppearance.Neumorphism
          : FAppearance.Material,
      colorForCallback: (sender, state) {
        return widget.backgroundColor ?? Colors.transparent;
      },
      userInteractive: false,
      isSelected: !widget.float,
      controlType: FType.Toggle,
      maskColor: Colors.transparent,
      child: Container(
        alignment: widget.textAlignment,
        decoration: decoration,
        padding: widget.padding,
        child: textPart,
      ),
    );
    if (widget.maxWidth != null || widget.maxHeight != null) {
      containerPart = LimitedBox(
        maxWidth: widget.maxWidth ?? double.infinity,
        maxHeight: widget.maxHeight ?? double.infinity,
        child: Container(
            width: widget.maxWidth ?? double.infinity,
            child: containerPart),
      );
    }
    children.add(Container(
      margin: widget.margin,
      child: GestureDetector(
        onTap: widget.onClick,
        child: containerPart,
      ),
    ));

    /// if getted [containerSize]， [child1] or [child2] not null，build child part
    if (containerSize != null) {
      if (widget.child1 != null || widget.child2 != null) {
        children.addAll(buildChildPart());
      }
    }

    /// build red point
    if (widget.redPoint) {
      var redPointPart = buildRedPoint();
      children.add(redPointPart);
    }

    /// build up
    var stackPart = _Stack(
      overflow: Overflow.visible,
      children: children,
    );
    return stackPart;
  }

  double get _shadowBlur {
    if ((widget.shadowBlur == null || widget.shadowBlur == 0.0) &&
        widget.isSupportNeumorphism) {
      return 6.0;
    } else {
      return widget.shadowBlur;
    }
  }

  double get shadowDistance {
    if (widget.isSupportNeumorphism) {
      return widget.shadowOffset?.dy ?? 3.0;
    } else {
      return widget.shadowOffset?.dy ?? 0.0;
    }
  }

  Size child1Size = Size.zero;
  Size child2Size = Size.zero;

  List<Widget> buildChildPart() {
    List<Widget> children = [];
    if (widget.child1 != null) {
      Offset offset = computeChildOffset(
          widget.child1Alignment, child1Size, widget.child1Margin);
      children.add(_MeasureSize(
          onChange: (size) {
            setState(() {
              child1Size = size;
            });
          },
          child: Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              /// 当子 Child 不处理事件时，作为整体，应该响应 FSuper 的事件
              ///
              /// When Child does not handle events, as a whole, it should respond to FSuper events
              onTap: widget.onChild1Click ?? widget.onClick,
              child: widget.child1,
            ),
          )));
    }
    if (widget.child2 != null) {
      Offset offset = computeChildOffset(
          widget.child2Alignment, child2Size, widget.child2Margin);
      children.add(_MeasureSize(
          onChange: (size) {
            setState(() {
              child2Size = size;
            });
          },
          child: Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              /// 当子 Child 不处理事件时，作为整体，应该响应 FSuper 的事件
              ///
              /// When Child does not handle events, as a whole, it should respond to FSuper events
              onTap: widget.onChild2Click ?? widget.onClick,
              child: widget.child2,
            ),
          )));
    }
    return children;
  }

  Offset computeChildOffset(
      Alignment alignment, Size childSize, EdgeInsets childMargin) {
    Offset childOffset = Offset.zero;
    Size size = containerSize;
    if (alignment == Alignment.topLeft) {
      childOffset = Offset(0, 0);
    } else if (alignment == Alignment.topCenter) {
      childOffset = Offset(size.width / 2 - childSize.width / 2, 0);
    } else if (alignment == Alignment.topRight) {
      childOffset = Offset(size.width - childSize.width, 0);
    } else if (alignment == Alignment.centerRight) {
      childOffset = Offset(
          size.width - childSize.width, size.height / 2 - childSize.height / 2);
    } else if (alignment == Alignment.bottomRight) {
      childOffset =
          Offset(size.width - childSize.width, size.height - childSize.height);
    } else if (alignment == Alignment.bottomCenter) {
      childOffset = Offset(
          size.width / 2 - childSize.width / 2, size.height - childSize.height);
    } else if (alignment == Alignment.bottomLeft) {
      childOffset = Offset(0, size.height - childSize.height);
    } else if (alignment == Alignment.centerLeft) {
      childOffset = Offset(0, size.height / 2 - childSize.height / 2);
    } else {
      childOffset = Offset(size.width / 2 - childSize.width / 2,
          size.height / 2 - childSize.height / 2);
    }
    if (childMargin != null) {
      childOffset = childOffset.translate(childMargin.left - childMargin.right,
          childMargin.top - childMargin.bottom);
    }
    if(widget.margin != null){
      childOffset = childOffset.translate(widget.margin.left, widget.margin.top);
    }
    return childOffset;
  }

  Widget buildRedPoint() {
    bool redPointTextEmpty =
        widget.redPointText == null || widget.redPointText == "";
    Color redPointTextColor = widget.redPointTextStyle?.color ?? Colors.white;
    double redPointTextSize =
        redPointTextEmpty ? 0.0 : (widget.redPointTextStyle?.fontSize ?? 0.0);
    var offset = widget.redPointOffset ??
        Offset(widget.redPointSize / 2.0, widget.redPointSize / 2.0);
    var redPointPart = Positioned(
      right: -offset.dx,
      top: -offset.dy,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            redPointTextSize / 2.0, 0, redPointTextSize / 2.0, 0),
        constraints: BoxConstraints(
          minWidth: widget.redPointSize,
          maxHeight: widget.redPointSize,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.redPointColor,
          borderRadius:
              BorderRadius.all(Radius.circular(widget.redPointSize / 2.0)),
        ),
        child: redPointTextEmpty
            ? null
            : Text(
                widget.redPointText ?? "",
                style: widget.redPointTextStyle.copyWith(
                    color: redPointTextColor, fontSize: redPointTextSize),
              ),
      ),
    );
    return redPointPart;
  }
}

typedef void _OnChildSizeChange(Size size);

class _MeasureSize extends StatefulWidget {
  final Widget child;
  final _OnChildSizeChange onChange;

  const _MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  GlobalKey key = GlobalKey();
  Size oldSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: key,
      child: widget.child,
    );
  }

  void postFrameCallback(_) {
    var context = key.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

class _Stack extends MultiChildRenderObjectWidget {
  /// Creates a stack layout widget.
  ///
  /// By default, the non-positioned children of the stack are aligned by their
  /// top left corners.
  _Stack({
    Key key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
    this.overflow = Overflow.clip,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  ///
  /// The non-positioned children are placed relative to each other such that
  /// the points determined by [alignment] are co-located. For example, if the
  /// [alignment] is [Alignment.topLeft], then the top left corner of
  /// each non-positioned child will be located at the same global coordinate.
  ///
  /// Partially-positioned children, those that do not specify an alignment in a
  /// particular axis (e.g. that have neither `top` nor `bottom` set), use the
  /// alignment to determine how they should be positioned in that
  /// under-specified axis.
  ///
  /// Defaults to [AlignmentDirectional.topStart].
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry alignment;

  /// The text direction with which to resolve [alignment].
  ///
  /// Defaults to the ambient [Directionality].
  final TextDirection textDirection;

  /// How to size the non-positioned children in the stack.
  ///
  /// The constraints passed into the [Stack] from its parent are either
  /// loosened ([StackFit.loose]) or tightened to their biggest size
  /// ([StackFit.expand]).
  final StackFit fit;

  /// Whether overflowing children should be clipped. See [Overflow].
  ///
  /// Some children in a stack might overflow its box. When this flag is set to
  /// [Overflow.clip], children cannot paint outside of the stack's box.
  final Overflow overflow;

  @override
  _RenderStack createRenderObject(BuildContext context) {
    return _RenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
      overflow: overflow,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderStack renderObject) {
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..fit = fit
      ..overflow = overflow;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties.add(EnumProperty<StackFit>('fit', fit));
    properties.add(EnumProperty<Overflow>('overflow', overflow));
  }
}

class _RenderStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, StackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, StackParentData> {
  /// Creates a stack render object.
  ///
  /// By default, the non-positioned children of the stack are aligned by their
  /// top left corners.
  _RenderStack({
    List<RenderBox> children,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection textDirection,
    StackFit fit = StackFit.loose,
    Overflow overflow = Overflow.clip,
  })  : assert(alignment != null),
        assert(fit != null),
        assert(overflow != null),
        _alignment = alignment,
        _textDirection = textDirection,
        _fit = fit,
        _overflow = overflow {
    addAll(children);
  }

  bool _hasVisualOverflow = false;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! StackParentData)
      child.parentData = StackParentData();
  }

  Alignment _resolvedAlignment;

  void _resolve() {
    if (_resolvedAlignment != null) return;
    _resolvedAlignment = alignment.resolve(textDirection);
  }

  void _markNeedResolution() {
    _resolvedAlignment = null;
    markNeedsLayout();
  }

  /// How to align the non-positioned or partially-positioned children in the
  /// stack.
  ///
  /// The non-positioned children are placed relative to each other such that
  /// the points determined by [alignment] are co-located. For example, if the
  /// [alignment] is [Alignment.topLeft], then the top left corner of
  /// each non-positioned child will be located at the same global coordinate.
  ///
  /// Partially-positioned children, those that do not specify an alignment in a
  /// particular axis (e.g. that have neither `top` nor `bottom` set), use the
  /// alignment to determine how they should be positioned in that
  /// under-specified axis.
  ///
  /// If this is set to an [AlignmentDirectional] object, then [textDirection]
  /// must not be null.
  AlignmentGeometry get alignment => _alignment;
  AlignmentGeometry _alignment;

  set alignment(AlignmentGeometry value) {
    assert(value != null);
    if (_alignment == value) return;
    _alignment = value;
    _markNeedResolution();
  }

  /// The text direction with which to resolve [alignment].
  ///
  /// This may be changed to null, but only after the [alignment] has been changed
  /// to a value that does not depend on the direction.
  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    _markNeedResolution();
  }

  /// How to size the non-positioned children in the stack.
  ///
  /// The constraints passed into the [RenderStack] from its parent are either
  /// loosened ([StackFit.loose]) or tightened to their biggest size
  /// ([StackFit.expand]).
  StackFit get fit => _fit;
  StackFit _fit;

  set fit(StackFit value) {
    assert(value != null);
    if (_fit != value) {
      _fit = value;
      markNeedsLayout();
    }
  }

  /// Whether overflowing children should be clipped. See [Overflow].
  ///
  /// Some children in a stack might overflow its box. When this flag is set to
  /// [Overflow.clip], children cannot paint outside of the stack's box.
  Overflow get overflow => _overflow;
  Overflow _overflow;

  set overflow(Overflow value) {
    assert(value != null);
    if (_overflow != value) {
      _overflow = value;
      markNeedsPaint();
    }
  }

  /// Helper function for calculating the intrinsics metrics of a Stack.
  static double getIntrinsicDimension(
      RenderBox firstChild, double mainChildSizeGetter(RenderBox child)) {
    double extent = 0.0;
    RenderBox child = firstChild;
    while (child != null) {
      final StackParentData childParentData =
          child.parentData as StackParentData;
      if (!childParentData.isPositioned)
        extent = math.max(extent, mainChildSizeGetter(child));
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    return extent;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return getIntrinsicDimension(
        firstChild, (RenderBox child) => child.getMinIntrinsicWidth(height));
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return getIntrinsicDimension(
        firstChild, (RenderBox child) => child.getMaxIntrinsicWidth(height));
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return getIntrinsicDimension(
        firstChild, (RenderBox child) => child.getMinIntrinsicHeight(width));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getIntrinsicDimension(
        firstChild, (RenderBox child) => child.getMaxIntrinsicHeight(width));
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  /// Lays out the positioned `child` according to `alignment` within a Stack of `size`.
  ///
  /// Returns true when the child has visual overflow.
  static bool layoutPositionedChild(RenderBox child,
      StackParentData childParentData, Size size, Alignment alignment) {
    assert(childParentData.isPositioned);
    assert(child.parentData == childParentData);

    bool hasVisualOverflow = false;
    BoxConstraints childConstraints = const BoxConstraints();

    if (childParentData.left != null && childParentData.right != null)
      childConstraints = childConstraints.tighten(
          width: size.width - childParentData.right - childParentData.left);
    else if (childParentData.width != null)
      childConstraints = childConstraints.tighten(width: childParentData.width);

    if (childParentData.top != null && childParentData.bottom != null)
      childConstraints = childConstraints.tighten(
          height: size.height - childParentData.bottom - childParentData.top);
    else if (childParentData.height != null)
      childConstraints =
          childConstraints.tighten(height: childParentData.height);

    child.layout(childConstraints, parentUsesSize: true);

    double x;
    if (childParentData.left != null) {
      x = childParentData.left;
    } else if (childParentData.right != null) {
      x = size.width - childParentData.right - child.size.width;
    } else {
      x = alignment.alongOffset(size - child.size as Offset).dx;
    }

    if (x < 0.0 || x + child.size.width > size.width) hasVisualOverflow = true;

    double y;
    if (childParentData.top != null) {
      y = childParentData.top;
    } else if (childParentData.bottom != null) {
      y = size.height - childParentData.bottom - child.size.height;
    } else {
      y = alignment.alongOffset(size - child.size as Offset).dy;
    }

    if (y < 0.0 || y + child.size.height > size.height)
      hasVisualOverflow = true;

    childParentData.offset = Offset(x, y);

    return hasVisualOverflow;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    _resolve();
    assert(_resolvedAlignment != null);
    _hasVisualOverflow = false;
    bool hasNonPositionedChildren = false;
    if (childCount == 0) {
      size = constraints.biggest;
      assert(size.isFinite);
      return;
    }

    double width = constraints.minWidth;
    double height = constraints.minHeight;

    BoxConstraints nonPositionedConstraints;
    assert(fit != null);
    switch (fit) {
      case StackFit.loose:
        nonPositionedConstraints = constraints.loosen();
        break;
      case StackFit.expand:
        nonPositionedConstraints = BoxConstraints.tight(constraints.biggest);
        break;
      case StackFit.passthrough:
        nonPositionedConstraints = constraints;
        break;
    }
    assert(nonPositionedConstraints != null);

    RenderBox child = firstChild;
    while (child != null) {
      final StackParentData childParentData =
          child.parentData as StackParentData;

      if (!childParentData.isPositioned) {
        hasNonPositionedChildren = true;

        child.layout(nonPositionedConstraints, parentUsesSize: true);

        final Size childSize = child.size;
        width = math.max(width, childSize.width);
        height = math.max(height, childSize.height);
      }

      child = childParentData.nextSibling;
    }

    if (hasNonPositionedChildren) {
      size = Size(width, height);
      assert(size.width == constraints.constrainWidth(width));
      assert(size.height == constraints.constrainHeight(height));
    } else {
      size = constraints.biggest;
    }

    assert(size.isFinite);

    child = firstChild;
    while (child != null) {
      final StackParentData childParentData =
          child.parentData as StackParentData;

      if (!childParentData.isPositioned) {
        childParentData.offset =
            _resolvedAlignment.alongOffset(size - child.size as Offset);
      } else {
        _hasVisualOverflow = layoutPositionedChild(
                child, childParentData, size, _resolvedAlignment) ||
            _hasVisualOverflow;
      }

      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  /// Override in subclasses to customize how the stack paints.
  ///
  /// By default, the stack uses [defaultPaint]. This function is called by
  /// [paint] after potentially applying a clip to contain visual overflow.
  @protected
  void paintStack(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_overflow == Overflow.clip && _hasVisualOverflow) {
      context.pushClipRect(
          needsCompositing, offset, Offset.zero & size, paintStack);
    } else {
      paintStack(context, offset);
    }
  }

  @override
  Rect describeApproximatePaintClip(RenderObject child) =>
      _hasVisualOverflow ? Offset.zero & size : null;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection));
    properties.add(EnumProperty<StackFit>('fit', fit));
    properties.add(EnumProperty<Overflow>('overflow', overflow));
  }

  bool hitTest(BoxHitTestResult result, {@required Offset position}) {
    if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
