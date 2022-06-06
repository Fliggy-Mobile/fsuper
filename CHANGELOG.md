## 2.1.0
- Support null-safety

## 2.0.2

- fix `maxWidth` not work

## 2.0.1

- optimization

## 2.0.0

- Remove the following parameters and use the `style` parameter instead:
    -`textColor`
    -`textSize`
    -`textStyle`
    -`textWeight`
    -`fontHeight`

- Remove the following parameters and use the `redPointTextStyle` parameter instead:
    -`redPointTextColor`
    -`redPointTextSize`

-`corner` parameter type changed from **Corner** to **FCorner**

-`cornerStyle` parameter type changed from **CornerStyle** to **FCornerStyle**

- Optimize the layout of Child

- Add Neumorphism style support.
    - Neumorphism style support can be turned on/off through the `isSupportNeumorphism` parameter
    - The `highlightShadowColor` parameter can configure the bright shadow color after enabling the Neumorphism style  
    - Through the `float` parameter, you can configure the Neumorphism effect to float / reduce the visual effect
    - The `lightOrientation` parameter can adjust the direction of the light source

- Now, under certain scenarios, even child child can respond to events normally even if it exceeds the range of **FSuper**

## 0.1.5

- Optimize fsuper.dart

## 0.1.4

- Rich **corner** effect

- Exquisite **border** decoration

- Naturally supports wonderful **rich text**

- **Gradient effect**

- More sense of space **Shadow**

- Not simple **Red Point**

- Flexible and powerful **relative layout**

