//
//  DataBaseTool.h
//  fmdbdemo
//
//  Created by enoughpower on 15/12/8.
//  Copyright © 2015年 enoughpower. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;
@interface DataBaseTool : NSObject
+ (instancetype)shareData;
- (BOOL)createTable;
- (BOOL)addStudent:(Student *)student;
- (BOOL)updateStudent:(Student *)student;
- (BOOL)deleteStudent:(Student *)student;
- (NSArray *)getStudent:(NSString *)search;


@end
