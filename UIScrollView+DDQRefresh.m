//
//  UIScrollView+DDQRefresh.m
//  DDQKitDemo
//
//  Created by 我叫咚咚枪 on 2018/12/24.
//  Copyright © 2018 我叫咚咚枪. All rights reserved.
//

#import "UIScrollView+DDQRefresh.h"

#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (DDQRefresh)

+ (instancetype)ddq_refreshHeaderStyle:(DDQRefreshHeaderStyle)hs headerAction:(void (^)(void))hAction footerStyle:(DDQRefreshFooterStyle)fs footerAction:(void (^)(void))fAction delegate:(id)delegate dataSource:(id)dataSource {
    
    id scrollView = nil;
    if ([self.class isSubclassOfClass:[UITableView class]]) {
        
        scrollView = [UITableView ddq_tableViewWithDeletegate:delegate dataSource:dataSource];
        
    } else if ([self.class isSubclassOfClass:[UICollectionView class]]) {
        
        scrollView = [UICollectionView ddq_collectionViewWithDeletegate:delegate dataSource:dataSource];
        
    } else {
     
        scrollView = [UIScrollView ddq_control];
        
    }
    
    if (delegate && [scrollView respondsToSelector:@selector(setDelegate:)]) {
        
        [scrollView setDelegate:delegate];
        
    }
    
    if (dataSource && [scrollView respondsToSelector:@selector(setDataSource:)]) {
        
        [scrollView setDataSource:dataSource];
        
    }
    
    [self.class ddq_handleResfreshWithView:scrollView headerStyle:hs hAction:hAction footerStyle:fs fAction:fAction];
    return scrollView;

}

+ (void)ddq_handleResfreshWithView:(__kindof UIScrollView *)view headerStyle:(DDQRefreshHeaderStyle)hs hAction:(void(^)(void))h footerStyle:(DDQRefreshFooterStyle)fs fAction:(void(^)(void))f {
    
    Class headerClass = nil;
    switch (hs) {
        case DDQRefreshHeaderStyleNone:
            break;
            
        case DDQRefreshHeaderStyleGif:
            headerClass = [MJRefreshGifHeader class];
            break;
            
        case DDQRefreshHeaderStyleState:
            headerClass = [MJRefreshStateHeader class];
            break;
            
        case DDQRefreshHeaderStyleNormal:
            headerClass = [MJRefreshNormalHeader class];
            break;
            
        default:
            break;
    }
    
    if (headerClass) {
        
        view = [headerClass headerWithRefreshingBlock:^{
            
            if (h) {
                h();
            }
        }];
    }
    
    Class footerClass = nil;
    switch (fs) {
            
        case DDQRefreshFooterStyleNone:
            break;
            
        case DDQRefreshFooterStyleAuto:
            footerClass = [MJRefreshAutoFooter class];
            break;
            
        case DDQRefreshFooterStyleBack:
            footerClass = [MJRefreshBackFooter class];
            break;
            
        case DDQRefreshFooterStyleAutoGif:
            footerClass = [MJRefreshAutoGifFooter class];
            break;
            
        case DDQRefreshFooterStyleBackGif:
            footerClass = [MJRefreshBackGifFooter class];
            break;
            
        case DDQRefreshFooterStyleAutoState:
            footerClass = [MJRefreshAutoStateFooter class];
            break;
            
        case DDQRefreshFooterStyleBackState:
            footerClass = [MJRefreshBackStateFooter class];
            break;
            
        case DDQRefreshFooterStyleAutoNormal:
            footerClass = [MJRefreshAutoNormalFooter class];
            break;
            
        case DDQRefreshFooterStyleBackNormal:
            footerClass = [MJRefreshBackNormalFooter class];
            break;
            
        default:
            break;
    }
    
    if (footerClass) {
        
        view = [footerClass headerWithRefreshingBlock:^{
            
            if (f) {
                f();
            }
        }];
    }
}

- (void)ddq_endRefreshIsNormalData:(BOOL)is {
    
    if (self.mj_header) {
        
        if (self.mj_header.isRefreshing) {
            
            [self.mj_header endRefreshing];
            
        }
        
        if (self.mj_footer) {
            
            [self.mj_footer resetNoMoreData];
            
        }
    }
    
    if (self.mj_footer) {
        
        if (self.mj_footer.isRefreshing) {
            
            [self.mj_footer endRefreshing];
        }
        
        if (is) {
            
            [self.mj_footer endRefreshingWithNoMoreData];
            
        }
    }
}

@end

