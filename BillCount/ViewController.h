//
//  ViewController.h
//  BillCount
//
//  Created by chiuyifan on 2025/9/10.
//

#import <UIKit/UIKit.h>                         //讓 ViewController 遵守 UITextFieldDelegate 協定。
//@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource>
@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

// 儲存記帳資料的陣列 => table view
@property (strong, nonatomic) NSMutableArray *transactions;

//// 沒用到，但連都連了 => 建立你需要修改的約束屬性
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewLeadingConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTrailingConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
    

///---------------------------------------------------
// 這不是必需的，但如果你想在程式碼中修改按鈕的標題或樣式，它會很有用
@property (weak, nonatomic) IBOutlet UIButton *incomeExpenseButton;
@property (weak, nonatomic) IBOutlet UIButton *classifyExpenseButton;
// YES 代表「收入」，NO 代表「支出」
@property (assign, nonatomic) BOOL isIncome;
///---------------------------------------------------
//7.顯示資料表
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//1.時間 UI 元件屬性
@property (weak, nonatomic) IBOutlet UIDatePicker *DateTime;
//2.收支選項  IBAction 方法
- (IBAction)InputOrOutpub:(id)sender;
//3.分類選項  IBAction 方法
- (IBAction)Classify:(id)sender;
//4.金額  UI 元件屬性
@property (weak, nonatomic) IBOutlet UITextField *Money;
//5.備註  UI 元件屬性
@property (weak, nonatomic) IBOutlet UITextField *Notes;
//6.新增button  IBAction 方法
- (IBAction)InsertData:(id)sender;


//宣告dataArray  chatgpt叫我刪除
//@property (strong,nonatomic) NSMutableArray *dataArray;

@end

