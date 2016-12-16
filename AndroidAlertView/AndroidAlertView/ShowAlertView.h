//
//  ShowAlertView.h
//  Enginner
//
//  Created by 王凯 on 15/10/9.
//  Copyright © 2015年 wk-iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Screen_Width  [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height

@interface ShowAlertView : UIView

/**
    frame ： Set the width of the pop-up box
    message： display the content
    custom： unuse
    class： the superview of pop-up box（default：window）
 */
+ (id)initializeAlertViewWithFrame:(CGRect)frame Message:(NSString *)pMessage customType:(NSUInteger)pType Class:(id)objectClass;

//show
- (void)addAlertView;

@end
