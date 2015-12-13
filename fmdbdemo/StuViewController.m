//
//  StuViewController.m
//  fmdbdemo
//
//  Created by enoughpower on 15/12/13.
//  Copyright © 2015年 enoughpower. All rights reserved.
//

#import "StuViewController.h"
#import "ViewController.h"
@interface StuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation StuViewController
- (IBAction)editButton:(UIButton *)sender {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *editStuVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"newStu"];
    editStuVC.student = self.student;
    editStuVC.passStu = ^(Student *student){
        self.student = student;
    };
    [self presentViewController:editStuVC animated:YES completion:nil];
    
}
- (IBAction)endButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)loadData
{
    self.IDLabel.text = [NSString stringWithFormat:@"%ld",(long)self.student.ID];
    self.nameLabel.text = self.student.name;
    self.sexLabel.text = self.student.sex;
    self.ageLabel.text = [NSString stringWithFormat:@"%ld",self.student.age];
    self.scoreLabel.text = [NSString stringWithFormat:@"%.2f",self.student.score];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
