//
//  MyImage.m
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/23/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "MyImage.h"

@implementation MyImage
- (instancetype)initWithImage:(UIImage *)image
                 withLocation:(NSString*)location
                    withGroup:(NSString *)group{
  self = [super init];
  if (self) {
    _image = image;
    _location = location;
    _group = group;
  }
  return self;
}
@end
