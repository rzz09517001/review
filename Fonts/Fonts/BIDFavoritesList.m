//
//  BIDFavoritesList.m
//  Fonts
//
//  Created by macOs on 2017/6/18.
//  Copyright © 2017年 rzz. All rights reserved.
//

#import "BIDFavoritesList.h"

@interface BIDFavoritesList()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation BIDFavoritesList

+(instancetype)sharedFavoritesList {
    static BIDFavoritesList *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}


-(instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *storedFavorites = [defaults objectForKey:@"favorites"];
        if (storedFavorites) {
            self.favorites = [storedFavorites mutableCopy];
        } else {
            self.favorites = [NSMutableArray array];
        }
    }
    return self;
}

-(void)addFavorite:(id)item {
    [_favorites insertObject:item atIndex:0];
    [self saveFavorites];
}

-(void)removeFavorite:(id)item {
    [_favorites removeObject:item];
    [self saveFavorites];
}

-(void)saveFavorites {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.favorites forKey:@"favorites"];
    [defaults synchronize];
}

/**
 将数组的某个元素从一个位置移动到另外一个位置

 @param from <#from description#>
 @param to <#to description#>
 */
-(void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to {
    id item = _favorites[from];
    [_favorites removeObjectAtIndex:from];
    [_favorites insertObject:item atIndex:to];
    [self saveFavorites];
}
@end
