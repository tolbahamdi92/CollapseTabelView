//
//  ViewController.m
//  CollapseTabelView
//
//  Created by Tolba Hamdy on 19/06/1445 AH.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize section data
    NSArray *originalArray = @[@{@"sectionName": @"Section 1", @"collapsed": @YES, @"data": @[@"Row 1", @"Row 2"]},
                          @{@"sectionName": @"Section 2", @"collapsed": @YES, @"data": @[@"Row 1", @"Row 2", @"Row 3"]},
                          // Add more sections as needed
                         ];
    
    self.sectionsData = [originalArray mutableCopy];

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionInfo = self.sectionsData[section];
    return [sectionInfo[@"collapsed"] boolValue] ? 0 : [sectionInfo[@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    NSDictionary *sectionInfo = self.sectionsData[indexPath.section];
    NSArray *rowData = sectionInfo[@"data"];
    cell.textLabel.text = rowData[indexPath.row];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionsData[section][@"sectionName"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ button.titleLabel setTextAlignment: NSTextAlignmentLeft];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeading;

    [button setBackgroundColor:UIColor.systemOrangeColor];
   [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal ];
    [button setTitle:self.sectionsData[section][@"sectionName"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toggleSection:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section;
    return button;
}

- (void)toggleSection:(UIButton *)sender {
    NSInteger section = sender.tag;
    NSMutableDictionary *sectionInfo = [self.sectionsData[section] mutableCopy]; // Ensure it's mutable
    BOOL collapsed = [sectionInfo[@"collapsed"] boolValue];
    sectionInfo[@"collapsed"] = @(!collapsed);
    self.sectionsData[section] = sectionInfo;

    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [((UITableView *)self.view.subviews.firstObject) reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
