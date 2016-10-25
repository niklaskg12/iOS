//
//  PopupListView.h
//  MyCustomTableViewForSelected
//
//  Created by Zhu Shouyu on 6/2/13.
//  Copyright (c) 2013 zhu shouyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PopupListViewButtonBlock)();

@class PopupListView;
@protocol PopupListDatasource <NSObject>

- (NSInteger)popupListView:(PopupListView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)popupListView:(PopupListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol PopupListDelegate <NSObject>
- (void)popupListView:(PopupListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)popupListView:(PopupListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
@end

@interface PopupListView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <PopupListDelegate>delegate;
@property (nonatomic, retain) id <PopupListDatasource>datasource;

@property (nonatomic, retain) UILabel *titleName;

//展示界面
- (void)show;

//消失界面
- (void)dismiss;

//列表cell的重用
- (id)dequeueReusablePopupCellWithIdentifier:(NSString *)identifier;

- (UITableViewCell *)popupCellForRowAtIndexPath:(NSIndexPath *)indexPath;            // returns nil if cell is not visible or index path is out of

//设置确定按钮的标题，如果不设置的话，不显示确定按钮
- (void)setDoneButtonWithTitle:(NSString *)aTitle block:(PopupListViewButtonBlock)block;

//设置取消按钮的标题，不设置，按钮不显示
- (void)setCancelButtonTitle:(NSString *)aTitle block:(PopupListViewButtonBlock)block;

//选中的列表元素
- (NSIndexPath *)indexPathForSelectedRow;
@end

