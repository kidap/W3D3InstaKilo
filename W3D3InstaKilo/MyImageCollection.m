//
//  MyImageCollection.m
//  W3D3InstaKilo
//
//  Created by Karlo Pagtakhan on 03/24/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "MyImageCollection.h"
#import "MyImage.h"

@interface MyImageCollection(){
}
@property (nonatomic, strong)NSSet *allObjects;
@end
@implementation MyImageCollection

-(instancetype)init{
  if (self = [super init]){
    [self addAllObjectsToSet];
    [self dataByLocation];
    
    _imageArrayHeader = [NSMutableArray arrayWithArray:@[@[@"Earth",@"Star Wars"],@[@"Mars",@"Dogs"]]];
  }
  return self;
}

-(void)addAllObjectsToSet{
  self.allObjects = [[NSSet alloc] initWithArray:@[ [[MyImage alloc] initWithImage:[UIImage imageNamed:@"fin"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"hansolo"] withLocation:@"2" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"kyloren"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"leia"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"luke"] withLocation:@"2" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"poe"] withLocation:@"1" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"rey"] withLocation:@"2" withGroup:@"1"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog1"] withLocation:@"1" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog2"] withLocation:@"2" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog3"] withLocation:@"1" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog4"] withLocation:@"2" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog5"] withLocation:@"1" withGroup:@"2"],
                                                    [[MyImage alloc] initWithImage:[UIImage imageNamed:@"dog6"] withLocation:@"1" withGroup:@"2"] ]];
}
-(void)deleteImage:(NSIndexPath *)indexPath{
  NSMutableArray *section = (NSMutableArray *)self.imageArray[indexPath.section];
  [section removeObjectAtIndex:indexPath.item];
  
  NSLog(@"Deleting Item:%ld, Section:%ld", indexPath.item, indexPath.section);
}
-(void)SetGroupingSelected:(NSInteger)segment{
  _groupingSelected = segment;
  switch (segment) {
    case 0:{
      [self dataByLocation];
      break;
    }
    case 1: {
      [self dataByGroup];
      break;
    }
    default:
      break;
  }
}
-(void)dataByLocation{
  
  self.imageArray = [[NSMutableArray alloc] init];
  
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  
  for (MyImage *object in self.allObjects){
    if ([object.location isEqualToString:@"1"]) {
      [tmp addObject:object];
    } else{
      [tmp2 addObject:object];
    }
  }
  
  [self.imageArray addObject:tmp];
  [self.imageArray addObject:tmp2];
}
-(void)dataByGroup{
  self.imageArray = [[NSMutableArray alloc] init];
  
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  
  for (MyImage *object in self.allObjects){
    if ([object.group isEqualToString:@"1"]) {
      [tmp addObject:object];
    } else{
      [tmp2 addObject:object];
    }
  }
  
  [self.imageArray addObject:tmp];
  [self.imageArray addObject:tmp2];
}
@end
