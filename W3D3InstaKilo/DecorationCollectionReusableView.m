//
//  DecorationCollectionReusableView.m
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/23/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "DecorationCollectionReusableView.h"

@implementation DecorationCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = backgroundImage;
    [self addSubview:imageView];
  }
  return self;
}
@end
