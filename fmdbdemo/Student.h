//
//  Student.h
//  fmdbdemo
//
//  Created by enoughpower on 15/12/13.
//  Copyright © 2015年 enoughpower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Student : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *sex;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, assign)CGFloat score;
@property (nonatomic, assign)NSInteger ID;
@end
