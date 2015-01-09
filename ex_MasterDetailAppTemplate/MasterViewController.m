//
//  MasterViewController.m
//  ex_MasterDetailAppTemplate
//
//  Created by yoshiyuki oshige on 2013/09/06.
//  Copyright (c) 2013年 yoshiyuki. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    //セルのデータの配列
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //ナビゲーションバーの左側にEditボタンを設定する
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //+ボタンを作る
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(insertNewObject:)];
    //ナビゲーションバーの右側に+ボタンを設定する
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// +ボタンでセルを追加する
- (void)insertNewObject:(id)sender
{
    //セルのデータを入れる配列の準備
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    //日付オブジェクトを配列objectsの先頭に挿入する
    [_objects insertObject:[NSDate date] atIndex:0];
    //テーブルビューのセクション0に先頭行を挿入する
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

//テーブルビューのセクション数を返す
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //セクションを1個にする
    return 1;
}

//テーブルビューの指定セクションの行数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列objectsの要素の個数を行数として返す
    return _objects.count;
}

//テーブルビューの指定indexPath（タップされた行）のセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //配列objectsから指定行のデータを取り出す
    NSDate *object = _objects[indexPath.row];
    //セルのラベルに日付を表示する
    cell.textLabel.text = [object description];
    return cell;
}

//テーブルビューの指定indexPathが編集（挿入削除）可能かどうか返す
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//テーブルビューの指定indexPathの削除または挿入
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //削除の時
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //挿入の時
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 //行を移動させる
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 //行を移動可能にする
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

//セグエで詳細シーンへの移動する前に詳細シーンを設定する
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //選択されている行のデータを取り出す
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        //詳細シーンのビューコントローラにタップされた行のデータを渡す
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
