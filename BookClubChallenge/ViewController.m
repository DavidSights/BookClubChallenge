//
//  ViewController.m
//  BookClubChallenge
//
//  Created by David Seitz Jr on 6/3/15.
//  Copyright (c) 2015 DavidSights. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AddFriendsTableViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSArray *friends;
@property NSArray *selectedFriends;
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;
}

- (void)loadFriends {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Friend"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor1];
    self.friends = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

- (void) saveFriend:(NSString *)friendName {
    NSManagedObject *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext: self.moc];
    [friend setValue:friendName forKey:@"name"];
    [self.moc save:nil];
    [self loadFriends];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];

    return cell;
}

- (IBAction)unwindToMe:(UIStoryboardSegue *)segue {
    if ([segue.identifier  isEqual: @"addFriends"]) {
        AddFriendsTableViewController *dvc = segue.destinationViewController;
        self.selectedFriends = dvc.selectedFriends;
        [segue.destinationViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddFriendsTableViewController *dvc = segue.destinationViewController;
    dvc.moc = self.moc;
}


@end
