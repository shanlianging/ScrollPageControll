# ScrollPageControll
一个横向和竖向排布的视图


## 介绍
> * 此demo能够实现横向和纵向排序
> * 具有点击功能
> * 方便实用

```
@protocol SLScrollViewHorizontalItemDelegate <NSObject>

@required;

/**
item的个数

@param view 视图
@return item的个数
*/
- (NSInteger)numberOfItemsInView:(UIView *)view;


/**
item视图

@param view 视图
@param index item的位置
@return item视图
*/
- (UIView *)itemForView:(UIView *)view index:(NSInteger)index;

@optional

/**
几行

@param view 视图
@return 行数
*/
- (NSInteger)lineNumberOfItemsInView:(UIView *)view;

/**
几列

@param view 视图
@return 列数
*/
- (NSInteger)columnNumberOfItemsInView:(UIView *)view;

/**
item边缘距离

@param view 视图
@return item的边缘距离
*/
- (UIEdgeInsets)edgeInsetsOfItemsInView:(UIView *)view;

/**
item视图之间的行高

@param view 视图
@return 行高
*/
- (CGFloat)lineSpaceOfItemsInView:(UIView *)view;

/**
item视图之间的列宽

@param view 视图
@return 列宽
*/
- (CGFloat)columnSpaceOfItemsInView:(UIView *)view;

/**
选中的item

@param item 选中的item视图
@param index item的下标
*/
- (void)item:(UIView *)item didSelectItemAtIndex:(NSInteger)index;


/**
排布方向

@param view 视图
@return 方向
*/
- (SLDistributionDirection)distributionDirectionAtView:(UIView *)view;

```


![横向排布][1]

![纵向排布][2]


[1]: https://github.com/shanlianging/ScrollPageControll/blob/master/image/horizontal.gif?raw=true
[2]: https://github.com/shanlianging/ScrollPageControll/blob/master/image/vertical.gif?raw=true
