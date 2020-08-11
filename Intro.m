//
//  Intro.m
//  Factory Fall
//
//  Created by Willie on 6/26/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "Intro.h"


@interface Intro ()

@property (strong, nonatomic) SKNode *gameLayer;
@property (nonatomic, strong) SKSpriteNode *background;
@property (strong, nonatomic) SKNode *spriteLayer;

@end

@implementation Intro

-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"FactroryFallIntroIP60001"];
        [_background setName:@"Background"];
        [self addChild:_background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointZero;
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = layerPosition;
        
        [self.gameLayer addChild:self.spriteLayer];
        
        NSLog(@"SceneView Open");
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        [self showIntro];
        
    }
    return self;
}
-(void)showIntro {
    
    intro = [SKSpriteNode spriteNodeWithImageNamed:@"FactroryFallIntroIP60001"];
    intro.position = CGPointZero;
    intro.zPosition = 2;
    [self.spriteLayer addChild:intro];
    
    NSArray * introSprites = @[[SKTexture textureWithImageNamed:@"FactroryFallIntroIP60001"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60002"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60003"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60004"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60005"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60006"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60007"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60008"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60009"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60010"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60011"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60012"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60013"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60014"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60015"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60016"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60017"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60018"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60019"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60020"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60021"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60022"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60023"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60024"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60025"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60026"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60027"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60028"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60029"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60030"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60031"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60032"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60033"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60034"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60035"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60036"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60037"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60038"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60039"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60040"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60041"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60042"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60043"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60044"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60045"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60046"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60047"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60048"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60049"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60050"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60051"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60052"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60053"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60054"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60055"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60056"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60057"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60058"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60059"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60060"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60061"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60062"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60063"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60064"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60065"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60066"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60067"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60068"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60069"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60070"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60071"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60072"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60073"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60074"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60075"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60076"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60077"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60078"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60079"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60080"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60081"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60082"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60083"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60084"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60085"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60086"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60087"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60088"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60089"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60090"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60091"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60092"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60093"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60094"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60095"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60096"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60097"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60098"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60099"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60100"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60101"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60102"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60103"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60104"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60105"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60106"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60107"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60108"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60109"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60110"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60111"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60112"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60113"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60114"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60115"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60116"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60117"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60118"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60119"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60120"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60121"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60123"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60124"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60125"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60126"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60127"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60128"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60129"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60130"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60131"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60132"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60133"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60134"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60135"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60136"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60137"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60138"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60139"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60140"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60141"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60142"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60143"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60144"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60145"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60146"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60147"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60148"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60149"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60150"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60151"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60152"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60153"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60154"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60155"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60156"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60157"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60158"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60159"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60160"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60161"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60162"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60163"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60164"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60165"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60166"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60167"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60168"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60169"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60170"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60171"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60172"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60173"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60174"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60175"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60176"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60177"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60178"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60179"],
                               [SKTexture textureWithImageNamed:@"FactroryFallIntroIP60180"]];
    SKAction *introPause = [SKAction waitForDuration:3];
    SKAction *introAnimate = [SKAction animateWithTextures:introSprites timePerFrame:0.1];
    SKAction *introSequence1 = [SKAction sequence:@[introPause,introAnimate]];
    [intro runAction:introSequence1];
    
    SKAction *wait = [SKAction waitForDuration:21];
    SKAction *perform = [SKAction performSelector:@selector(introAnimations) onTarget:self];
    SKAction *sequence = [SKAction sequence:@[wait,perform]];
    [self runAction:sequence];
    
}
-(void)introAnimations {
    
    factoryShadow = [SKSpriteNode spriteNodeWithImageNamed:@"FactoryShadow"];
    factoryShadow.position = CGPointMake(0, -280);
    factoryShadow.zPosition = 3;
    [self.spriteLayer addChild:factoryShadow];
    
    SKAction *tiny = [SKAction scaleTo:0.1 duration:0];
    SKAction *big = [SKAction scaleTo:1 duration:4];
    SKAction *small = [SKAction scaleTo:0.8 duration:0.2];
    SKAction *huge = [SKAction scaleTo:1 duration:0.2];
    SKAction *seq = [SKAction sequence:@[tiny,big,small,huge]];
    [factoryShadow runAction:seq];
    
    factory = [SKSpriteNode spriteNodeWithImageNamed:@"FactoryOpen0001"];
    factory.position = CGPointMake(0, 2320);
    factory.zPosition = 3;
    [self.spriteLayer addChild:factory];
    
    SKAction *moveFactory = [SKAction moveTo:CGPointZero duration:4];
    SKAction *factoryBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
    SKAction *factoryFall = [SKAction moveTo:CGPointZero duration:0.2];
    SKAction *factorySequence = [SKAction sequence:@[moveFactory,factoryBounce,factoryFall]];
    [factory runAction:factorySequence];
    
    NSArray * factorySprites = @[[SKTexture textureWithImageNamed:@"FactoryOpen0001"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0002"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0003"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0004"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0005"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0006"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0007"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0008"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0009"],
                                 [SKTexture textureWithImageNamed:@"FactoryOpen0010"]];
    SKAction *factorypause = [SKAction waitForDuration:10];
    SKAction *factoryAnimate = [SKAction animateWithTextures:factorySprites timePerFrame:0.1];
    SKAction *facSequence = [SKAction sequence:@[factorypause,factoryAnimate]];
    [factory runAction:facSequence];
    
    title = [SKSpriteNode spriteNodeWithImageNamed:@"Title"];
    title.position = CGPointMake(0, 500);
    title.zPosition = 3;
    [self.spriteLayer addChild:title];
    
    SKAction *titleWait = [SKAction waitForDuration:7];
    SKAction *moveTitle = [SKAction moveTo:CGPointZero duration:1];
    SKAction *titleBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
    SKAction *titleFall = [SKAction moveTo:CGPointZero duration:0.2];
    SKAction *titleSequence = [SKAction sequence:@[titleWait,moveTitle,titleBounce,titleFall]];
    [title runAction:titleSequence];
    SKAction *titleSizeWait = [SKAction waitForDuration:5];
    SKAction *titlePop = [SKAction scaleBy:1.02 duration:0.5];
    SKAction *titleShribble = [SKAction scaleTo:1 duration:0.5];
    SKAction *titleWait1 = [SKAction waitForDuration:2];
    SKAction *titleSizeSequence1 = [SKAction sequence:@[titlePop,titleWait1,titleShribble,titleWait1]];
    SKAction *repeatSequence1 = [SKAction repeatActionForever:titleSizeSequence1];
    SKAction *titleSizeSequence = [SKAction sequence:@[titleSizeWait,repeatSequence1]];
    
    [title runAction:titleSizeSequence];
    
    NSArray * titleSprites = @[[SKTexture textureWithImageNamed:@"Title1"],
                               [SKTexture textureWithImageNamed:@"Title2"],
                               [SKTexture textureWithImageNamed:@"Title3"],
                               [SKTexture textureWithImageNamed:@"Title4"],
                               [SKTexture textureWithImageNamed:@"Title5"]];
    SKAction *titlePause = [SKAction waitForDuration:3];
    SKAction *titleAnimate = [SKAction animateWithTextures:titleSprites timePerFrame:0.1];
    SKAction *repeatTitleAnimateForever = [SKAction repeatActionForever:titleAnimate];
    SKAction *titleSequence1 = [SKAction sequence:@[titlePause,repeatTitleAnimateForever]];
    [title runAction:titleSequence1];
    
    bushes = [SKSpriteNode spriteNodeWithImageNamed:@"IntroBushes"];
    bushes.position = CGPointMake(0, 700);
    bushes.zPosition = 3.1;
    [self.spriteLayer addChild:bushes];
    SKAction *bushWait = [SKAction waitForDuration:5.5];
    SKAction *moveBush = [SKAction moveTo:CGPointZero duration:1];
    SKAction *bushBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
    SKAction *bushFall = [SKAction moveTo:CGPointZero duration:0.2];
    SKAction *bushSequence = [SKAction sequence:@[bushWait,moveBush,bushBounce,bushFall]];
    [bushes runAction:bushSequence];
    
    SKAction *wait4 = [SKAction waitForDuration:11];
    SKAction *does = [SKAction performSelector:@selector(zoomAni) onTarget:self];
    SKAction *seq1 = [SKAction sequence:@[wait4,does]];
    [self runAction:seq1];
    
}
-(void)remove {
    
    [factory removeFromParent];
    [intro removeFromParent];
    [factoryShadow removeFromParent];
    [title removeFromParent];
    [bushes removeFromParent];
    
}
-(void)zoomAni {
    [self remove];
    
    zoom = [SKSpriteNode spriteNodeWithImageNamed:@"IntroZoom0001"];
    zoom.position = CGPointZero;
    zoom.zPosition = 2;
    [self.spriteLayer addChild:zoom];
    
    NSArray * zoomSprites = @[[SKTexture textureWithImageNamed:@"IntroZoom0001"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0002"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0003"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0004"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0005"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0006"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0007"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0008"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0009"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0010"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0011"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0012"],
                              [SKTexture textureWithImageNamed:@"IntroZoom0013"],];
    SKAction *zoomAnimate = [SKAction animateWithTextures:zoomSprites timePerFrame:0.1];
    SKAction *zoomSequence1 = [SKAction sequence:@[zoomAnimate]];
    [zoom runAction:zoomSequence1];
    
    [self performSelector:@selector(showAni) withObject:self afterDelay:1.4];
}
-(void)showAni {
    
    bg = [SKSpriteNode spriteNodeWithImageNamed:@"BigBoom0001"];
    bg.position = CGPointZero;
    bg.zPosition = 5;
    [self.spriteLayer addChild:bg];
    
    NSArray * bgseq = @[[SKTexture textureWithImageNamed:@"BigBoom0001"],
                        [SKTexture textureWithImageNamed:@"BigBoom0002"],
                        [SKTexture textureWithImageNamed:@"BigBoom0003"],
                        [SKTexture textureWithImageNamed:@"BigBoom0004"],
                        [SKTexture textureWithImageNamed:@"BigBoom0005"],
                        [SKTexture textureWithImageNamed:@"BigBoom0006"],
                        [SKTexture textureWithImageNamed:@"BigBoom0007"],
                        [SKTexture textureWithImageNamed:@"BigBoom0008"],
                        [SKTexture textureWithImageNamed:@"BigBoom0009"],
                        [SKTexture textureWithImageNamed:@"BigBoom0010"],
                        [SKTexture textureWithImageNamed:@"BigBoom0011"],
                        [SKTexture textureWithImageNamed:@"BigBoom0012"],
                        [SKTexture textureWithImageNamed:@"BigBoom0013"],
                        [SKTexture textureWithImageNamed:@"BigBoom0014"]];
    
    SKAction *bgwait = [SKAction waitForDuration:3];
    SKAction *anibg = [SKAction animateWithTextures:bgseq timePerFrame:0.143];
    SKAction *seqbg = [SKAction sequence:@[bgwait,anibg]];
    [bg runAction:seqbg];
    
    
    
}





@end
