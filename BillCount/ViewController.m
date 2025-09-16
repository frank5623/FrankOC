//
//  ViewController.m
//  BillCount
//
//  Created by chiuyifan on 2025/9/10.
//

#import "ViewController.h"

@interface ViewController ()

// 將分類名稱儲存在私有屬性中 因為有點多，所以簡短程式比較好看
@property (strong, nonatomic) NSArray *incomeCategories;
@property (strong, nonatomic) NSArray *expenseCategories;

@end

@implementation ViewController

- (void)viewDidLoad { //初始化
    [super viewDidLoad];
    
    
    // 初始化收入和支出的分類陣列 以後只需要在這裡改了
    self.incomeCategories = @[@"薪資", @"獎金", @"投資收入", @"其他收入"];
    self.expenseCategories = @[@"餐飲", @"交通", @"娛樂", @"購物", @"居家", @"其他支出"];
    
    // 初始化資料陣列
    //self.transactions *class=[transactions now];
    self.transactions = [[NSMutableArray alloc] init];
    
    // 設定代理 =>chatgpt叫我加的
    self.Money.delegate=self;
    self.Notes.delegate=self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self; // 建議加上，以處理未來使用者互動
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 在這裡設定字型，確保它在所有佈局完成後執行
    self.incomeExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
    self.classifyExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
}

//分類_已完成
- (IBAction)Classify:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"請選擇分類"
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];

    // 決定要使用哪個陣列
    NSArray *categoriesToUse;
    if (self.isIncome) {
        categoriesToUse = self.incomeCategories;
    } else {
        categoriesToUse = self.expenseCategories;
    }

    // 透過迴圈動態建立並新增選項
    for (NSString *categoryName in categoriesToUse) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:categoryName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 在這裡處理選擇的分類
            // 設定按鈕的文字
            [self.classifyExpenseButton setTitle:categoryName forState:UIControlStateNormal];

            // 設定按鈕文字的字型為 Helvetica Neue Bold，大小為 35.0
            self.classifyExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
            //NSLog(@"使用者選擇了：%@", categoryName);
        }];
        [alertController addAction:action];
    }

    // 新增取消選項
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    // 解決 iPad 上的錯誤：為 Popover 設定來源
    // 檢查裝置是否為 iPad，因為在 iPhone 上不需要這段程式碼
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alertController.popoverPresentationController.sourceView = sender;
        alertController.popoverPresentationController.sourceRect = [sender bounds];
    }
    
    // 顯示 Alert Controller
    [self presentViewController:alertController animated:YES completion:nil];
}
///------------------------------------------------------------------------------------------------------------------
//收入或分支_已完成
- (IBAction)InputOrOutpub:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"請選擇收入或支出"
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 建立「支出」選項
    UIAlertAction *expenseAction = [UIAlertAction actionWithTitle:@"支出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 設定按鈕的文字
        [self.incomeExpenseButton setTitle:@"支出" forState:UIControlStateNormal];

        // 設定按鈕文字的字型為 Helvetica Neue Bold，大小為 35.0
        self.incomeExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
        self.isIncome = 0;
        // --- 新增以下程式碼：自動設定分類按鈕 ---
        // 取得支出分類的第一個選項並設定按鈕標題
        if (self.expenseCategories.count > 0) {
            NSString *firstExpenseCategory = self.expenseCategories[0];
            [self.classifyExpenseButton setTitle:firstExpenseCategory forState:UIControlStateNormal];
            self.classifyExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
        }
    }];
    [alertController addAction:expenseAction];
    
    // 建立「收入」選項
    UIAlertAction *incomeAction = [UIAlertAction actionWithTitle:@"收入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 設定按鈕的文字
        [self.incomeExpenseButton setTitle:@"收入" forState:UIControlStateNormal];

        // 設定按鈕文字的字型為 Helvetica Neue Bold，大小為 35.0
        self.incomeExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
        self.isIncome = 1;
        // 自動設定分類按鈕
        // 取得收入分類的第一個選項並設定按鈕標題
        if (self.incomeCategories.count > 0) { // <--- 這裡已經修正為 incomeCategories
            NSString *firstIncomeCategory = self.incomeCategories[0];
            [self.classifyExpenseButton setTitle:firstIncomeCategory forState:UIControlStateNormal];
            self.classifyExpenseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
        }
        
        //原本字型寫下來
        //self.incomeExpenseButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    }];
    [alertController addAction:incomeAction];
    
    // 建立「取消」選項
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    // 解決 iPad 上的錯誤：為 Popover 設定來源
    // 檢查裝置是否為 iPad，因為在 iPhone 上不需要這段程式碼
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        alertController.popoverPresentationController.sourceView = sender;
        alertController.popoverPresentationController.sourceRect = [sender bounds];
    }
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//輸入規則
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.Money) {
        // 取得輸入後完整的字串
           NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];

           // ----------------------
           // 檢查 1: 只允許輸入數字
           // ----------------------
           NSCharacterSet *numbersOnly = [NSCharacterSet decimalDigitCharacterSet];
           NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:string];
           if (![numbersOnly isSupersetOfSet:stringSet]) {
               return NO; // 如果有非數字字元，拒絕輸入
           }

           // ----------------------
           // 檢查 2: 限制在 int 的範圍內
           // ----------------------
           if ([newString length] > 0) {
               // 將字串轉為 long long 來檢查是否超出 int 的最大值
               long long intValue = [newString longLongValue];
               if (intValue > INT_MAX) {
                   return NO; // 如果超過 int 最大值，拒絕輸入
               }
           }
            
           return YES; // 如果通過所有檢查，允許輸入
    }else{ //剩下self.note
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(newString.length>7){
            return  NO;
        }
        return YES;
    }
}
//新增資料
- (IBAction)InsertData:(id)sender {
    
    
    
    if (self.Money.text.length > 0) {
        // 從 UI 元件取得資料
        NSString *category = [self.classifyExpenseButton titleForState:UIControlStateNormal];
        NSString *notes = self.Notes.text.length > 0 ? self.Notes.text : @"無備註";
        NSString *type = self.isIncome ? @"收入" : @"支出";
        
        // 組合新資料字串
        NSString *newData = [NSString stringWithFormat:@"%@ - %@ - %@: %@", type, category, self.Money.text, notes];
        
        // 將新資料添加到陣列中
        [self.transactions addObject:newData];
        
        // 通知 UITableView 重新載入資料
        [self.tableView reloadData];
        
        // ------------------
        // 新增以下程式碼：顯示「新增成功」提示
        // ------------------
                
        // 1. 創建一個 UIAlertController
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功"
                                                                             message:@"您的記帳資料已成功新增！"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
                
                // 2. 創建一個「確定」按鈕
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:nil]; // handler 為 nil 表示點擊後不做任何事，只關閉視窗
                
                // 3. 將按鈕加入到 Alert Controller
        [alert addAction:okAction];
                
                // 4. 顯示 Alert Controller
        [self presentViewController:alert animated:YES completion:nil];
        // 清空輸入框
        self.Money.text = @"";
        self.Notes.text = @"";
    }
}

// 根據資料陣列的數量回傳行數
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.transactions.count;
}

// 建立並設定每個單元格的內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row < self.transactions.count) {
        NSString *rowData = self.transactions[indexPath.row];
        cell.textLabel.text = rowData;
    }
    
    return cell;
}




@end
