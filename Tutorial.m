//
//  Tutorial.m
//  Factory Fall
//
//  Created by Willie on 4/7/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "Tutorial.h"
#import "NormalLogic.h"
#import "Food.h"
#import "GameViewController.h"
#import "MainMenu.h"

static const CGFloat SpawnWidth = 32.0;
static const CGFloat SpawnHeight = 200;
static NSString * const kAnimalNodeName = @"movable";
@interface Tutorial ()
@property (nonatomic, strong) SKSpriteNode *background;
@property (strong, nonatomic) SKNode *gameLayer;
@property (strong, nonatomic) SKNode *foodsLayer;
@property (strong, nonatomic) SKNode *sensorLayer;
@property (strong, nonatomic) SKNode *spriteLayer;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (strong, nonatomic) MainMenu *Mainscene;
@end

@implementation Tutorial
static const uint32_t foodCategory = 0x1 << 0;
static const uint32_t leftSensorCategory = 0x1 << 12;
static const uint32_t rightSensorCategory = 0x1 << 13;
static const uint32_t bottomSensorCategory = 0x1 << 14;
- (id)initWithSize:(CGSize)size {
    if ((self = [super initWithSize:size])) {
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"StartGameBG"];
        [_background setName:@"background"];
        [self addChild:_background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointMake(-SpawnWidth*NumSpawns/2, SpawnHeight*NumSpawns/2);
        
        self.foodsLayer = [SKNode node];
        self.foodsLayer.position = layerPosition;
        
        [self.gameLayer addChild:self.foodsLayer];
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = CGPointZero;
        
        [self.gameLayer addChild:self.spriteLayer];
        
        CGPoint sensorPosition = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        
        self.sensorLayer = [SKNode node];
        self.sensorLayer.position = sensorPosition;
        
        [self.gameLayer addChild:self.sensorLayer];
        
        tutorial = [SKSpriteNode spriteNodeWithImageNamed:@"Tutorial"];
        tutorial.position = CGPointZero;
        tutorial.name = @"Tutorial";
        tutorial.zPosition = 0.5;
        [self.spriteLayer addChild:tutorial];
        tutorial.hidden = YES;
        [self tutorialAnimation];
        [self sprites];
        //userNameTextField.hidden = NO;
    }
    return self;
}
-(void)didMoveToView:(SKView *)view {
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(Flick:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
    
    
    [self rightSensorLayerSprite];
    [self leftSensorLayerSprite];
    [self bottomSensorLayerSprite];
    
    
    //[self sprites];
    
    
    
    
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == leftSensorCategory && tutorialFruit == YES) {
        
        [self broccoliDropAnimation];
        
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == rightSensorCategory && tutorialFruit == YES) {
        
        [self appleDropAnimation];
        
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == bottomSensorCategory && tutorialFruit == YES) {
        
        [self appleDropAnimation];
        
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == rightSensorCategory && tutorialVeggy == YES) {
        
        [self pizzaDropAnimation];
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == leftSensorCategory && tutorialVeggy == YES) {
        
        [self broccoliDropAnimation];
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == bottomSensorCategory && tutorialVeggy == YES) {
        
        [self broccoliDropAnimation];
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == bottomSensorCategory && tutorialOther == YES) {
        

        [self goToMainMenu];
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == leftSensorCategory && tutorialOther == YES) {
        
        
        
    }
    if (firstBody.categoryBitMask == foodCategory && secondBody.categoryBitMask == leftSensorCategory && tutorialOther == YES) {
        
        
        
    }
}
-(void)goToMainMenu {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"dontShowTutorial"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    self.Mainscene = [MainMenu sceneWithSize:skView.bounds.size];
    self.Mainscene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:self.Mainscene];
}
-(void)sprites {
    
    
    foodCatcher = [SKSpriteNode spriteNodeWithImageNamed:@"FoodCatcher"];
    foodCatcher.position = CGPointMake(0, -55);
    foodCatcher.name = @"FoodCatcher";
    [self.spriteLayer addChild:foodCatcher];
    foodCatcher.zPosition = 3.1;
    
    foodDropper = [SKSpriteNode spriteNodeWithImageNamed:@"FoodDropper"];
    foodDropper.position = CGPointMake(0, 216);
    foodDropper.zPosition = 3.1;
    foodDropper.name = @"FoodDropper";
    [self.spriteLayer addChild:foodDropper];
    
    
}
-(void)tutorialAnimation {
    tutorial.hidden = NO;
    SKAction *hideTutorial = [SKAction fadeAlphaTo:0.0 duration:1];
    SKAction *showTutorial = [SKAction fadeAlphaTo:1.0 duration:1];
    SKAction *tutorialSequence = [SKAction sequence:@[showTutorial, hideTutorial, showTutorial, hideTutorial]];
    SKAction *tutorialRepeat = [SKAction repeatActionForever:tutorialSequence];
    [tutorial runAction:tutorialRepeat];
}
-(void)appleDropAnimation {
    
    [tutorial removeFromParent];
    [self spawnApple];
    SKAction *appleFall = [SKAction performSelector:@selector(gravity1) onTarget:self];
    SKAction *screenDarken = [SKAction performSelector:@selector(darkenScreen) onTarget:self];
    SKAction *stopWait = [SKAction waitForDuration:0.01];
    SKAction *appleStop = [SKAction performSelector:@selector(gravity0) onTarget:self];
    SKAction *group = [SKAction group:@[screenDarken, stopWait]];
    SKAction *sequence = [SKAction sequence:@[appleFall,group,appleStop]];
    [self runAction:sequence];
    
    
    
}
-(void)broccoliDropAnimation {
    [self spawnBroccoli];
    SKAction *broccoliFall = [SKAction performSelector:@selector(gravity1) onTarget:self];
    SKAction *screenDarken = [SKAction performSelector:@selector(darkenScreen) onTarget:self];
    SKAction *stopWait = [SKAction waitForDuration:0.01];
    SKAction *broccoliStop = [SKAction performSelector:@selector(gravity0) onTarget:self];
    SKAction *group = [SKAction group:@[screenDarken, stopWait]];
    SKAction *sequence = [SKAction sequence:@[broccoliFall,group,broccoliStop]];
    [self runAction:sequence];
}
-(void)pizzaDropAnimation {
    [self spawnPizza];
    SKAction *pizzaFall = [SKAction performSelector:@selector(gravity1) onTarget:self];
    SKAction *screenDarken = [SKAction performSelector:@selector(darkenScreen) onTarget:self];
    SKAction *stopWait = [SKAction waitForDuration:0.01];
    SKAction *pizzaStop = [SKAction performSelector:@selector(gravity0) onTarget:self];
    SKAction *waitForDrop = [SKAction waitForDuration:3];
    SKAction *group = [SKAction group:@[screenDarken, stopWait]];
    SKAction *sequence = [SKAction sequence:@[pizzaFall,group,pizzaStop,waitForDrop,pizzaFall]];
    [self runAction:sequence];
}
-(void)darkenScreen {
    blackScreen = [SKSpriteNode spriteNodeWithImageNamed:@"TutBlackScreen"];
    blackScreen.position = CGPointZero;
    blackScreen.zPosition = 0.4;
    [self.spriteLayer addChild:blackScreen];
    
    SKAction *blackScreenHide = [SKAction fadeAlphaTo:0.0 duration:0];
    SKAction *blackScreenShow = [SKAction fadeAlphaTo:1 duration:0.5];
    SKAction *blackScreenSequence = [SKAction sequence:@[blackScreenHide, blackScreenShow]];
    [blackScreen runAction:blackScreenSequence];
    
    
}
-(void)spawnApple{
    [apple removeFromParent];
    [blackScreen removeFromParent];
    apple = [SKSpriteNode spriteNodeWithImageNamed:@"TutApple"];
    apple.position = CGPointMake(-3, 200);
    apple.zPosition = 0.5;
    apple.name = @"TutApple";
    [self.spriteLayer addChild:apple];
    [apple setName:kAnimalNodeName];
    apple.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:apple.size];
    apple.physicsBody.categoryBitMask = foodCategory;
    apple.physicsBody.collisionBitMask = leftSensorCategory | rightSensorCategory | bottomSensorCategory;
    apple.physicsBody.contactTestBitMask = leftSensorCategory | rightSensorCategory | bottomSensorCategory;
    tutorialFruit = YES;
    if (tutorialFruit == YES) {
        tutorialOther = NO;
        tutorialVeggy = NO;
    }
}
-(void)spawnBroccoli{
    [apple removeFromParent];
    [broccoli removeFromParent];
    [blackScreen removeFromParent];
    broccoli = [SKSpriteNode spriteNodeWithImageNamed:@"TutBroccoli"];
    broccoli.position = CGPointMake(-3, 200);
    broccoli.zPosition = 0.5;
    broccoli.name = @"TutBroccoli";
    [self.spriteLayer addChild:broccoli];
    [broccoli setName:kAnimalNodeName];
    broccoli.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:broccoli.size];
    broccoli.physicsBody.categoryBitMask = foodCategory;
    broccoli.physicsBody.collisionBitMask = leftSensorCategory | rightSensorCategory | bottomSensorCategory;
    broccoli.physicsBody.contactTestBitMask = leftSensorCategory | rightSensorCategory | bottomSensorCategory;
    tutorialVeggy = YES;
    if (tutorialVeggy == YES) {
        tutorialOther = NO;
        tutorialFruit = NO;
    }
}
-(void)spawnPizza{
    [broccoli removeFromParent];
    [pizza removeFromParent];
    [blackScreen removeFromParent];
    pizza = [SKSpriteNode spriteNodeWithImageNamed:@"TutPizza"];
    pizza.position = CGPointMake(-3, 200);
    pizza.zPosition = 0.5;
    [self.spriteLayer addChild:pizza];
    [pizza setName:kAnimalNodeName];
    pizza.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pizza.size];
    pizza.physicsBody.categoryBitMask = foodCategory;
    pizza.physicsBody.collisionBitMask = leftSensorCategory | rightSensorCategory | bottomSensorCategory;
    pizza.physicsBody.contactTestBitMask = leftSensorCategory | rightSensorCategory | bottomSensorCategory;
    tutorialOther = YES;
    if (tutorialOther == YES) {
        tutorialVeggy = NO;
        tutorialFruit = NO;
    }
}
-(void)leftSensorLayerSprite {
    
    UIColor *sensorColor = [UIColor redColor];
    double sensorWidth = 10.0;
    
    leftSensor = [SKSpriteNode spriteNodeWithColor:sensorColor size:CGSizeMake(sensorWidth, self.frame.size.height)];
    leftSensor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftSensor.size];
    leftSensor.alpha = 1.0;
    leftSensor.physicsBody.dynamic = NO;
    leftSensor.position = CGPointMake(-self.frame.size.width/2, 0);
    [self.sensorLayer addChild:leftSensor];
    leftSensor.physicsBody.categoryBitMask = leftSensorCategory;
    
    
    
}
-(void)rightSensorLayerSprite {
    
    UIColor *sensorColor = [UIColor redColor];
    double sensorWidth = 10.0;
    
    rightSensor = [SKSpriteNode spriteNodeWithColor:sensorColor size:CGSizeMake(sensorWidth, self.frame.size.height)];
    rightSensor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightSensor.size];
    rightSensor.alpha = 1.0;
    rightSensor.physicsBody.dynamic = NO;
    rightSensor.position = CGPointMake(self.frame.size.width/2, 0);
    [self.sensorLayer addChild:rightSensor];
    rightSensor.physicsBody.categoryBitMask = rightSensorCategory;
    
    
}
-(void)bottomSensorLayerSprite {
    UIColor *sensorColor = [UIColor redColor];
    double sensorWidth = 10.0;
    
    bottomSensor =[SKSpriteNode spriteNodeWithColor:sensorColor size:CGSizeMake(self.frame.size.width, sensorWidth)];
    bottomSensor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomSensor.size];
    bottomSensor.alpha = 1.0;
    bottomSensor.physicsBody.dynamic = NO;
    bottomSensor.position = CGPointMake(0, -self.frame.size.height/2 + 205);
    [self.sensorLayer addChild:bottomSensor];
    bottomSensor.physicsBody.categoryBitMask = bottomSensorCategory;
    
    
}
-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"Tutorial"])
        {
            [self appleDropAnimation];
        }
        else if ([[node name] isEqualToString:@""])
        {
            
            
        }
        
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches)
    {
        CGPoint location = [touch locationInNode:[self spriteLayer]];
        
        [self handleNodesAtLocation:location];
        
    }
    
    [super touchesEnded:touches withEvent:event];
}
- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[_background size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}
- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:kAnimalNodeName]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [_background setPosition:[self boundLayerPos:newPos]];
    }
}
- (CGPoint)pointForFood:(NSInteger)spawn  {
    return CGPointMake(spawn*SpawnWidth + SpawnWidth/2, spawn*SpawnHeight + SpawnHeight/2);
}
- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    //2
    if(![_selectedNode isEqual:touchedNode]) {
        _selectedNode = touchedNode;
        //3
        if([[touchedNode name] isEqualToString:kAnimalNodeName]) {
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad2(-4.0f) duration:0.1],
                                                      [SKAction rotateByAngle:0.0 duration:0.1],
                                                      [SKAction rotateByAngle:degToRad2(4.0f) duration:0.1]]];
            [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
        
    }
}
float degToRad2(float degree) {
    return degree / 180.0f * M_PI;
}
-(void)Flick:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        
        touchLocation = [self convertPointFromView:touchLocation];
        
        [self selectNodeForTouch:touchLocation];
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        /*if (![[_selectedNode name] isEqualToString:kAnimalNodeName]) {
            float scrollDuration = 0.2;
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            CGPoint pos = [_selectedNode position];
            CGPoint p = mult2(velocity, scrollDuration);
            
            CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
            newPos = [self boundLayerPos:newPos];
            [_selectedNode removeAllActions];
            
            SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
            [moveTo setTimingMode:SKActionTimingEaseOut];
            [_selectedNode runAction:moveTo];
        }*/
        
    }
    
}
CGPoint mult2(const CGPoint v, const CGFloat s) {
    return CGPointMake(v.x*s, v.y*s);
}
-(void)gravity0 {
    self.physicsWorld.gravity = CGVectorMake(0, 0);
}
-(void)gravity1 {
        self.physicsWorld.gravity = CGVectorMake(0, -1);
}
-(void)gravity2 {
        self.physicsWorld.gravity = CGVectorMake(0, -2);
}
-(void)gravity3 {
        self.physicsWorld.gravity = CGVectorMake(0, -3);
}
-(void)gravity4 {
        self.physicsWorld.gravity = CGVectorMake(0, -4.0);
}
-(void)gravity5 {
        self.physicsWorld.gravity = CGVectorMake(0, -5);
}
-(void)gravity6 {
        self.physicsWorld.gravity = CGVectorMake(0, -6);
}
-(void)gravity7 {
        self.physicsWorld.gravity = CGVectorMake(0, -7);
}
-(void)gravity8 {
        self.physicsWorld.gravity = CGVectorMake(0, -8);
}
-(void)gravity9 {
        self.physicsWorld.gravity = CGVectorMake(0, -9);
}
-(void)gravity10 {
        self.physicsWorld.gravity = CGVectorMake(0, -10);
}
@end
