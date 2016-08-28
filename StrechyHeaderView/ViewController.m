//
//  ViewController.m
//  StrechyHeaderView
//
//  Created by Roman Salazar on 7/23/16.
//  Copyright © 2016 Roman Salazar. All rights reserved.
//

#import "ViewController.h"
#import "StrechyHeaderCollectionViewLayout.h"

NSString * const kCellIdent = @"Cell";
NSString * const kHeaderIdent = @"Header";

@interface ViewController ()

@end


@implementation ViewController

@synthesize collectionView, header;

- (void)loadView {
    
    [super loadView];
    
    CGRect bounds;
    bounds = [[self view]bounds];
    
    StrechyHeaderCollectionViewLayout *stretchyLayout;
    stretchyLayout = [[StrechyHeaderCollectionViewLayout alloc]init];
    [stretchyLayout setSectionInset:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [stretchyLayout setItemSize:CGSizeMake(self.view.frame.size.width, 500)];
    [stretchyLayout setHeaderReferenceSize:CGSizeMake(320.0, 160.0)];

    collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:stretchyLayout];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView setAlwaysBounceVertical:YES];
    [collectionView setShowsVerticalScrollIndicator:NO];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [[self view] addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdent];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdent];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!header) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:kHeaderIdent
                                                           forIndexPath:indexPath];
        CGRect bounds;
        bounds = [header bounds];
        
        UIImageView *imageView;
        imageView = [[UIImageView alloc]initWithFrame:bounds];
        [imageView setImage:[UIImage imageNamed:@"header-background"]];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [imageView setClipsToBounds:YES];
        [header addSubview:imageView];
    }
    return header;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdent forIndexPath:indexPath];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:(id)[UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0],
                                NSFontAttributeName,
                                (id)[UIColor lightGrayColor],
                                NSForegroundColorAttributeName,
                                nil];
    NSAttributedString *attributedTxt;
    attributedTxt = [[NSAttributedString alloc]initWithString:@"Roman Salazar" attributes:attributes];
    
    UILabel *label = [[UILabel alloc]init];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setAttributedText:attributedTxt];
    [cell addSubview:label];
    
    CGRect textRect = CGRectZero;
    textRect.size = [label sizeThatFits:[cell bounds].size];
    [label setFrame:textRect];
    
    return cell;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
