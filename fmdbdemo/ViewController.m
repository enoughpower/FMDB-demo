//
//  ViewController.m
//  fmdbdemo
//
//  Created by enoughpower on 15/12/8.
//  Copyright © 2015年 enoughpower. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "DataBaseTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *sexText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *scoreText;
@end

@implementation ViewController
- (IBAction)confirm:(UIButton *)sender {
    if (self.student) {
        Student *stu = [[Student alloc]init];
        stu.name = self.nameText.text;
        stu.sex = self.sexText.text;
        stu.score = [self.scoreText.text floatValue];
        stu.age = [self.ageText.text integerValue];
        stu.ID = self.student.ID;
        BOOL response = [[DataBaseTool shareData] updateStudent:stu];
        if (response) {
            _passStu(stu);
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            NSLog(@"error");
        }
    }else {
    Student *stu = [[Student alloc]init];
    stu.name = self.nameText.text;
    stu.sex = self.sexText.text;
    stu.score = [self.scoreText.text floatValue];
    stu.age = [self.ageText.text integerValue];
    if (stu.name&&stu.sex&&stu.score&&stu.age) {
        BOOL response = [[DataBaseTool shareData] addStudent:stu];
        if (response) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            NSLog(@"error");
        }
    }else {
        NSLog(@"没有填数据");
    }
    }

}
- (IBAction)cancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.student) {
        [self loadData];
    }
    // Do any additional setup after loading the view, typically from a nib.
    

}
- (void)loadData
{
    self.nameText.text = self.student.name;
    self.sexText.text = self.student.sex;
    self.ageText.text = [NSString stringWithFormat:@"%ld",self.student.age];
    self.scoreText.text = [NSString stringWithFormat:@"%.2f",self.student.score];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
