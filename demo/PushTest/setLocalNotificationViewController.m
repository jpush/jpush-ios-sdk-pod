//	            __    __                ________
//	| |    | |  \ \  / /  | |    | |   / _______|
//	| |____| |   \ \/ /   | |____| |  / /
//	| |____| |    \  /    | |____| |  | |   _____
//	| |    | |    /  \    | |    | |  | |  |____ |
//  | |    | |   / /\ \   | |    | |  \ \______| |
//  | |    | |  /_/  \_\  | |    | |   \_________|
//
//	Copyright (c) 2012年 HXHG. All rights reserved.
//	http://www.jpush.cn
//  Created by Zhanghao
//

#import "setLocalNotificationViewController.h"
#import "JPUSHService.h"

@interface setLocalNotificationViewController () {
  CGRect _frame;
}
@end

@implementation setLocalNotificationViewController {
  UILocalNotification *_notification;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  int fixLength;
#ifdef __IPHONE_7_0
  if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
    fixLength = 0;
  } else {
    fixLength = 20;
  }
#else
  fixLength = 20;
#endif
  _frame =
      CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - fixLength,
                 self.view.frame.size.width, self.view.frame.size.height);
  // Do any additional setup after loading the view from its nib.
}
- (IBAction)setNotification:(id)sender {
  _notification = [JPUSHService
      setLocalNotification:_notificationDatePicker.date
                 alertBody:_notificationBodyTextField.text
                     badge:[_notificationBadgeTextField.text intValue]
               alertAction:_notificationButtonTextField.text
             identifierKey:_notificationIdentifierTextField.text
                  userInfo:nil
                 soundName:nil];
  //  [self clearAllInput];
  NSString *result;
  if (_notification) {
    result = @"设置本地通知成功";
  } else {
    result = @"设置本地通知失败";
  }
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置"
                                                  message:result
                                                 delegate:self
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil, nil];
  [alert show];
}

- (void)clearAllInput {
  _notificationBadgeTextField.text = nil;
  _notificationBodyTextField.text = @"";
  _notificationButtonTextField.text = @"";
  _notificationDatePicker.date = [[NSDate new] dateByAddingTimeInterval:0];
  _notificationIdentifierTextField.text = @"";
}

- (IBAction)clearAllNotification:(id)sender {
  //[JPFService deleteLocalNotificationWithIdentifierKey:@"test"];
  //  [APService deleteLocalNotification:_notification];
  [JPUSHService clearAllLocalNotifications];
  UIAlertView *alert =
      [[UIAlertView alloc] initWithTitle:@"设置"
                                 message:@"取消所有本地通知成功"
                                delegate:self
                       cancelButtonTitle:@"确定"
                       otherButtonTitles:nil, nil];
  [alert show];
}

- (IBAction)clearLastNotification {
  NSString *alertMessage;
  if (_notification) {
    [JPUSHService deleteLocalNotification:_notification];
    _notification = nil;
    alertMessage = @"取消上一个通知成功";
  } else {
    alertMessage = @"不存在上一个设置通知";
  }
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置"
                                                  message:alertMessage
                                                 delegate:self
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil, nil];
  [alert show];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  _backgroundView.frame = CGRectMake(_frame.origin.x, _frame.origin.y - 110,
                                     _frame.size.width, _frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  _backgroundView.frame = _frame;
  return YES;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  if (textField.tag != 10) {
    return YES;
  }
  return YES;
}

- (IBAction)View_TouchDown:(id)sender {
  // 发送resignFirstResponder.
  [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                             to:nil
                                           from:nil
                                       forEvent:nil];
  _backgroundView.frame = _frame;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
