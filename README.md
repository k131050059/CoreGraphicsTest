# CoreGraphics 学习笔记

###图形上下文
 Core Graphics 使用图形上下文工作，类似一张画布。当我们在画布上画画时，画布外的地方是无法绘制的，core Graphics也一样，在图形上下文之外是无法绘图的，我们可以自己创建一个上下文，但是性能和内存的使用上，效率是非常低的。 我们可以派生一个UIView子类，获得它的上下文。在UIView中调用drawRect:方法时，会自动准备好一个图形上下文，可以通过调用UIGraphicsGetCurrentContext()来获取。 因为它是运行期间绘制图片，我们可以动态的做一些额外的操作。调用setNeedsDisplay来执行绘制方法。
###路径、渐变、文字和图像
UIBezierPath创建路径，
####渐变
线性渐变：沿着一条定义好了起点和重点的直线方向，呈线性变化。如果这条线有一定角度，线性渐变也会沿相同路径变化

放射渐变：颜色顺着两个原型之间的方向线性变化，这两个园为起始圆和终止圆，每隔圆都有自己的圆心和班级
####文字
darwAtPoint

drawInRect

##更多东西请看代码
### 画一个带渐变色的柱状图
例：![exp](http://ww4.sinaimg.cn/large/64d203b1jw1f4vy7vtoe8j20hn0bqdgf.jpg)

