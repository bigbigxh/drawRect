//
//  ViewController.m
//  drawRect
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import "ViewController.h"
#import "ChatCell.h"
#import "InputView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)InputView *inputView;

@end

@implementation ViewController

static NSString * const Identifier = @"ChatCell";

- (UITableView *)tableView{
    if (!_tableView) {
        NSInteger widht = self.view.bounds.size.width;
        NSInteger height = self.view.bounds.size.height;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, widht, height - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ChatCell class] forCellReuseIdentifier:Identifier];
        [_tableView setShowsVerticalScrollIndicator:NO];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _tableView.rowHeight = 80;
    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        NSArray *arr = @[@{@"img":@"1.jpg",@"msg":@"我不知道啊"},
                     @{@"img":@"1.jpg",@"msg":@"输了不知道就是不知道。再比比直接弄死你信不信。不管你信不信，反正我是信了。我要写很多很多的东西，看看到底有没有用"},
                     @{@"img":@"1.jpg",@"msg":@"输了不知道就是不知道。再"},
                     @{@"img":@"1.jpg",@"msg":@"我不知道啊道就是不知道。再就是不知道。再"},
                     @{@"img":@"1.jpg",@"msg":@"我不知道啊"}];
        _dataArr = [NSMutableArray arrayWithArray:arr];
        
    }
    return _dataArr;
}

- (InputView *)inputView{
    if (!_inputView) {
        
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil];
        NSInteger widht = self.view.bounds.size.width;
        NSInteger height = self.view.bounds.size.height;
        
        _inputView = [nibViews objectAtIndex:0];
        _inputView.frame = CGRectMake(0, height - 44, widht, 44);
        _inputView.inputTextField.delegate = self;
        
        [_inputView.sendBtn addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inputView;
}

//发送消息
- (void)sendMsg{
    
    NSString *msg = self.inputView.inputTextField.text;
    
    if (msg.length < 1) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"发送有误" message:@"发送消息不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSDictionary *dic = @{@"img":@"1.jpg",@"msg":msg};
        
        [self.dataArr addObject:dic];
        
        self.inputView.inputTextField.text = nil;
        
        [self.inputView.inputTextField resignFirstResponder];
        [self.tableView reloadData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义ChatCell";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputView];
    
}


#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    
    NSString *content = [dic valueForKey:@"msg"];
    NSString *imgName = [dic valueForKey:@"img"];
    UIImage *img = [UIImage imageNamed:imgName];
    cell.contentStr = content;
    cell.IconImage = img;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    NSString *content = [dic valueForKey:@"msg"];
    
    NSInteger height = [self MaxheightForRowWithText:content AndFont:13 maskSize:CGSizeMake(180, MAXFLOAT)];
    
    NSInteger ReallyHeight = height + 30; //height只是纯文本的高度，所以此处必须要加上灰色label的高度和label距离cell上下的高度。30正好合适
    
    return ReallyHeight;
}

#pragma mark - 计算文本的高度
- (NSInteger)MaxheightForRowWithText:(NSString *)rowText AndFont:(NSInteger)font maskSize:(CGSize)size{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    
    //计算出label刚刚好自适应rowText的frame
    //size:宽高限制，在一定的区域内文本的高度。这里给出宽度就可以了，而高度是自适应的，所以高度要给出一个永远到不了的高度
    CGRect frame = [rowText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = frame.size.height;//文本的高度
    
    return height;
}

#pragma mark - 监听键盘弹起和收起
//向通知中心添加观察者
- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
//在界面隐藏时，取消键盘的监听
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
//将输入框架弹起
- (void)openKeyboard:(NSNotification *)notification
{
    NSInteger kheight = self.view.bounds.size.height;
    NSInteger kwidth = self.view.bounds.size.width;
    //如果是手动布局就计算输入框架的frame,如果是自动布局,那就添加或修改约束
    //键盘有多高
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //键盘升起动画的时长
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //动画选项
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    
    //修改约束,让输入框架距离父视图的下边正好和键盘一样高
    
    CGRect tableViewframe = self.tableView.frame;
    tableViewframe.size.height = kheight - 44 - keyboardFrame.size.height;
    self.tableView.frame = tableViewframe;
    
    CGRect inputViewframe = self.inputView.frame;
    inputViewframe = CGRectMake(0, kheight - 44 -keyboardFrame.size.height, kwidth, 44);
    self.inputView.frame = inputViewframe;
    
    //让tableView滚动到最下方的那条消息
//    NSInteger lastRow = self.dataArr.count;
//    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:(lastRow - 1)];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    //让输入框架和键盘做完全一样的动画效果
    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{
                         //让修改后的约束起作用
                         [self.view layoutIfNeeded];
                         
                     } completion:nil];
}

//让输入框回到下边
- (void)closeKeyboard:(NSNotification *)notification
{
    
    NSInteger kheight = self.view.bounds.size.height;
    NSInteger kwidth = self.view.bounds.size.width;
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    
    //修改约束，让输入框收起，tableView也跟着放下
    CGRect tableViewframe = self.tableView.frame;
    tableViewframe.size.height = kheight - 44;
    self.tableView.frame = tableViewframe;
    
    CGRect inputViewframe = self.inputView.frame;
    inputViewframe = CGRectMake(0, kheight - 44, kwidth, 44);
    self.inputView.frame = inputViewframe;
    
    
    //让tableView滚动到最下方的那条消息
//    NSInteger lastRow = self.dataArr.count;
//    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:(lastRow - 1)];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
        
    } completion:nil];
}

@end
