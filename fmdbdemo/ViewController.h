//
//  ViewController.h
//  fmdbdemo
//
//  Created by enoughpower on 15/12/8.
//  Copyright © 2015年 enoughpower. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;
typedef void(^passStudent)(Student *student);
@interface ViewController : UIViewController
@property (nonatomic, strong)Student *student;
@property (nonatomic ,copy)passStudent passStu;

@end

