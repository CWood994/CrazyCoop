//
//  GameScene.h
//  Sunflower
//
//  Created by Benjamin Stammen on 10/24/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScene : SKScene

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@end
