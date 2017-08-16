

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  x值
 */
@property(nonatomic,assign)CGFloat x;
/**
 *  y值
 */
@property(nonatomic,assign)CGFloat y;
/**
 *  中心x值
 */
@property(nonatomic,assign)CGFloat centerX;
/**
 *  中心y值
 */
@property(nonatomic,assign)CGFloat centerY;
/**
 *  宽
 */
@property(nonatomic,assign)CGFloat width;
/**
 *  高
 */
@property(nonatomic,assign)CGFloat height;

/**
 *  最大x
 */

@property(nonatomic,assign)CGFloat maxX;
/**
 *  最大Y
 */

@property(nonatomic,assign)CGFloat maxY;


@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint origin;
@end
