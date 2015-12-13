//
//  DataBaseTool.m
//  fmdbdemo
//
//  Created by enoughpower on 15/12/8.
//  Copyright © 2015年 enoughpower. All rights reserved.
//

#import "DataBaseTool.h"
#import "FMDB.h"
#import "Student.h"
static DataBaseTool *databasetoll = nil;
@implementation DataBaseTool
+ (instancetype)shareData
{
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        databasetoll = [[DataBaseTool alloc]init];
    });
    return databasetoll;
    
}

- (BOOL)createTable
{
    __block BOOL createRes = NO;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"student.db"];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:path];
    [db open];
    createRes = [db executeUpdate:@"create table if not exists STUDENT (ID INTEGER PRIMARY KEY AUTOINCREMENT,name NSString, age NSNumber, sex NSString, score NSNumber)"];
    [db close];
    return createRes;
}

- (BOOL)addStudent:(Student *)student;
{
    [self createTable];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"student.db"];
    __block BOOL inserRes = NO;
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db2) {
        inserRes = [db2 executeUpdate:
                    @"insert into 'STUDENT' ('name', 'age', 'sex', 'score') values (?,?,?,?)",
                    student.name,
                    [NSNumber numberWithInteger:student.age],
                    student.sex,
                    [NSNumber numberWithFloat:student.score]
                    ];
        
        if (inserRes) {
            NSLog(@"---- insert a data");
        }else{
            NSLog(@"---- error insert");
        }
    }];
    return inserRes;
    
    
}
- (BOOL)updateStudent:(Student *)student
{
    [self createTable];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"student.db"];
    __block BOOL updateRes = NO;
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db2) {
        updateRes = [db2 executeUpdate:
                     @"update 'STUDENT' set name=?,age=?,sex=?,score=? where ID=?",
                     student.name,
                     [NSNumber numberWithInteger:student.age],
                     student.sex,
                     [NSNumber numberWithFloat:student.score],
                     [NSNumber numberWithInteger:student.ID]
                     ];
        
        
        if (updateRes) {
            NSLog(@"---- updateRes a data");
            NSLog(@"%@",path);
        }else{
            NSLog(@"---- updateRes error insert");
        }
    }];
    return updateRes;
    
}
- (BOOL)deleteStudent:(Student *)student
{
    [self createTable];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"student.db"];
    __block BOOL deleteRes = NO;
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase *db2) {
        deleteRes = [db2 executeUpdate:@"delete from 'STUDENT' where ID=?",[NSNumber numberWithInteger:student.ID]];
        if (deleteRes) {
            NSLog(@"---- deleteRes a data");
            NSLog(@"%@",path);
        }else{
            NSLog(@"---- deleteRes error insert");
        }
    }];
    return deleteRes;
}
- (NSArray *)getStudent:(NSString *)search
{
    [self createTable];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"student.db"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSMutableArray *fuelsArray = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db2) {
        FMResultSet *fuels = nil;
        if (search) {
            NSString *sql = [NSString stringWithFormat:@"select * from 'STUDENT' where %@ order by ID",search];
            fuels = [db2 executeQuery:sql];
        }else {
            fuels = [db2 executeQuery:@"select * from 'STUDENT' order by ID"];
        }
        while ([fuels next]) {
            Student *student = [[Student alloc]init];
            student.ID = [fuels intForColumn:@"ID"];
            student.name = [fuels stringForColumn:@"name"];
            student.age = [[fuels objectForColumnName:@"age"] integerValue];
            student.sex = [fuels stringForColumn:@"sex"];
            student.score = [[fuels objectForColumnName:@"score"] floatValue];
            [fuelsArray addObject:student];
        }
    }];
    return fuelsArray;
}



@end
