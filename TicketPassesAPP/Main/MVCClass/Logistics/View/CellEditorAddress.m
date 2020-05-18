//
//  CellEditorAddress.m
//  TicketPassesAPP
//
//  Created by macbook on 2019/6/28.
//  Copyright © 2019年 macbook. All rights reserved.
//

#import "CellEditorAddress.h"
#import "ContactObj.h"

@implementation CellEditorAddress

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.bianjibut setTitle:NSBundleLocalizedString(@"编辑") forState:UIControlStateNormal];
    [self.shanchubut setTitle:NSBundleLocalizedString(@"删除") forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id)model{
    
    if ([model isKindOfClass:[ContactObj class]]) {
        _model = model;
        ContactObj *co = _model;
        self.nameLabel.text = co.name;
        self.iphoneLabel.text = co.phone;
        self.addressLabel.text = co.email;
    }
    
    if ([model isKindOfClass:[AddressModel class]]) {
        _model = model;
        AddressModel *am = _model;
        self.nameLabel.text = am.ad_consignee;
        self.iphoneLabel.text = am.ad_consignee_phone;
        self.addressLabel.text = am.ad_get_address;
    }
}


- (IBAction)editorClick:(id)sender {
    if(self.editorClickBlock){
        self.editorClickBlock(self.model);
    }
    
}
- (IBAction)removeClick:(id)sender {
    if(self.removeClickBlock){
        self.removeClickBlock(self.model,self);
    }
}

@end
