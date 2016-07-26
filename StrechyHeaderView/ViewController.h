//
//  ViewController.h
//  StrechyHeaderView
//
//  Created by Roman Salazar on 7/23/16.
//  Copyright © 2016 Roman Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic, readonly) UICollectionReusableView *header;

@end

