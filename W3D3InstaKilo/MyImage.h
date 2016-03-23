//
//  MyImage.h
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/23/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyImage : NSObject

@property (strong, nonatomic) UIImage *image;
@property (copy,nonatomic) NSString *location;
@property (copy,nonatomic) NSString *group;

- (instancetype)initWithImage:(UIImage *)image
                 withLocation:(NSString*)location
                    withGroup:(NSString *)group;
@end


