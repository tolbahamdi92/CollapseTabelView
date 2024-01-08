//
//  ViewController.h
//  CollapseTabelView
//
//  Created by Tolba Hamdy on 19/06/1445 AH.
//
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sectionsData; // Array to store section information

@end
