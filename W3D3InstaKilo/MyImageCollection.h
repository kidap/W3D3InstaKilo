//
//  MyImageCollection.h
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/24/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface MyImageCollection : NSObject
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *imageArrayHeader; //cheating, quick fix// change to dictionary in the future
@property (assign, nonatomic) NSInteger groupingSelected;

//-(void)setSegment:(NSInteger)segment;
-(void)addImage:(UIImage *)newImage;
-(void)deleteImage:(NSIndexPath *)indexPath;
@end
