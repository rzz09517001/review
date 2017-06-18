//
//  BIDFavoritesList.h
//  Fonts
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDFavoritesList : NSObject

+(instancetype)sharedFavoritesList;

-(NSArray *)favorites;

-(void)addFavorite:(id)item;
-(void)removeFavorite:(id)item;

-(void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end
