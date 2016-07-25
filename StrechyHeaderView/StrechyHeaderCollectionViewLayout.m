//
//  StrechyHeaderCollectionViewLayout.m
//  StrechyHeaderView
//
//  Created by Roman Salazar on 7/23/16.
//  Copyright © 2016 Roman Salazar. All rights reserved.
//

#import "StrechyHeaderCollectionViewLayout.h"

@implementation StrechyHeaderCollectionViewLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    // This will schedule calls to layoutAttributesForElementsInRect: as the
    // collectionView is scrolling.
    return YES;
}

-(UICollectionViewScrollDirection)scrollDirection {
    //This subclass only supports vertical scroll..
    return UICollectionViewScrollDirectionVertical;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = -insets.top;
    
    // Superclass attributes
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    //check if you pull bellow past the lowest point
    if (offset.y < minY) {
        //Figure out how much we pulled down.
        CGFloat deltaY = fabsf(offset.y - minY);
        
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            // Locate the header attributes
            NSString *kind = [attrs representedElementKind];
            if (kind == UICollectionElementKindSectionHeader) {
                // Adjust the header's height and Y based on how much the user pulls down.
                CGSize headerSize = [self headerReferenceSize];
                CGRect headerRect = [attrs frame];
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                [attrs setFrame:headerRect];
                break;
            }
        }
    }
    return attributes;
}


@end
