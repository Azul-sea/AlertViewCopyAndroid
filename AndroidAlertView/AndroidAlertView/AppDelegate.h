//
//  AppDelegate.h
//  AndroidAlertView
//
//  Created by 四季游玩 on 2016/12/8.
//  Copyright © 2016年 wk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

