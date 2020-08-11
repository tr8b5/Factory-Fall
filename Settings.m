//
//  Settings.m
//  Factory Fall
//
//  Created by Willie on 6/9/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "Settings.h"
#import "MainMenu.h"
#import "GameViewController.h"

#define IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

@class GameViewController;

@interface Settings ()

@property (strong, nonatomic) SKNode *gameLayer;
@property (nonatomic, strong) SKSpriteNode *background;
@property (strong, nonatomic) SKNode *spriteLayer;

@property (weak) GameViewController *gameViewController;
@end

@implementation Settings


-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        mainMenuSprites = [self textureAtlasNamed:@"MainMenuSprites"];
        
        settingsSprites = [self textureAtlasNamed:@"SettingsSprites"];
        
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"SettingsBackground"];
        [_background setName:@"SettingsBackground"];
        _background.size = CGSizeMake(_background.frame.size.width/s, _background.frame.size.height / s);
        [self addChild:_background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointZero;
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = layerPosition;
        
        [self.gameLayer addChild:self.spriteLayer];
        
       // [self addChild:themeMus];
        
        NSLog(@"SceneView Open");
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
    }
    return self;
}
- (SKTextureAtlas *)textureAtlasNamed:(NSString *)fileName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] )
        {
            if (IPHONE_4) {
                s = 2;
                fileName = [NSString stringWithFormat:@"%@", fileName];
                
            }
            if (IPHONE_5) {
                s = 2;
                fileName = [NSString stringWithFormat:@"%@-568", fileName];
                
            }else if (IPHONE_6) {
                s = 2;
                fileName = [NSString stringWithFormat:@"%@-667", fileName];
                
            } else if (IPHONE_6_PLUS) {
                s = 3;
                fileName = [NSString stringWithFormat:@"%@-736", fileName];
                
            } else {
                
                fileName = fileName;
                
            }
            
        } else {
            fileName = [NSString stringWithFormat:@"%@-ipad", fileName];
        }
    }
    SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:fileName];
    
    return textureAtlas;
}
-(void)didMoveToView:(SKView *)view {
    [self sprites];
    [self loadSoundOnOrOff];
}
-(void)sprites {
    
    homeButtonTexture = [settingsSprites textureNamed:@"SettingsHomsButton"];
    
    homeButton = [SKSpriteNode spriteNodeWithTexture:homeButtonTexture];
    homeButton.position = CGPointMake(-71, 119);
    homeButton.size = CGSizeMake(homeButton.frame.size.width/s, homeButton.frame.size.height / s);
    homeButton.zPosition = 2;
    homeButton.name = @"home";
    [self.spriteLayer addChild:homeButton];
    
}
-(void) loadSoundOnOrOff {
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"soundOn"]) {
        soundOn = NO;
        
        
        [self offButtonPressed];
    } else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"soundOn"]){
        soundOn = YES;
        
        
        [self onButtonPressed];
    }
    
}
-(void)onButtonPressed {
    
    [onButton removeFromParent];
    [onButtonPressed removeFromParent];
    [offButton removeFromParent];
    [offButtonPressed removeFromParent];
    
    onButtonPressedTexture = [settingsSprites textureNamed:@"SettingOnButtonPressed"];
    
    onButtonPressed = [SKSpriteNode spriteNodeWithTexture:onButtonPressedTexture];
    onButtonPressed.position = CGPointMake(80, -92);
    onButtonPressed.size = CGSizeMake(onButtonPressed.frame.size.width/s, onButtonPressed.frame.size.height / s);
    onButtonPressed.zPosition = 2;
    [self.spriteLayer addChild:onButtonPressed];
    
    offButtonTexture = [settingsSprites textureNamed:@"SettingOffButton"];
    
    offButton = [SKSpriteNode spriteNodeWithTexture:offButtonTexture];
    offButton.position = CGPointMake(20, -90);
    offButton.size = CGSizeMake(offButton.frame.size.width/s, offButton.frame.size.height / s);
    offButton.zPosition = 2;
    offButton.name = @"off";
    [self.spriteLayer addChild:offButton];
    
}
-(void)offButtonPressed {
    
    [offButton removeFromParent];
    [offButtonPressed removeFromParent];
    [onButton removeFromParent];
    [onButtonPressed removeFromParent];
    
    offButtonTexture = [settingsSprites textureNamed:@"SettingOffButtonPressed"];
    
    offButtonPressed = [SKSpriteNode spriteNodeWithTexture:offButtonTexture];
    offButtonPressed.position = CGPointMake(20, -92);
    offButtonPressed.size = CGSizeMake(offButtonPressed.frame.size.width/s, offButtonPressed.frame.size.height / s);
    offButtonPressed.zPosition = 2;
    [self.spriteLayer addChild:offButtonPressed];
    
    onButtonTexture = [settingsSprites textureNamed:@"SettingOnButton"];
    
    onButton = [SKSpriteNode spriteNodeWithTexture:onButtonTexture];
    onButton.position = CGPointMake(80, -90);
    onButton.size = CGSizeMake(onButton.frame.size.width/s, onButton.frame.size.height / s);
    onButton.zPosition = 2;
    onButton.name = @"on";
    [self.spriteLayer addChild:onButton];
    
}
-(void)goToMainMenu {
    
    self.skView = (SKView *)self.view;
    
    // Create and configure the scene.
    MainMenu *Mainscene = [MainMenu sceneWithSize:self.skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:Mainscene];
    
}
-(void)clickSound {
    
    NSString *clak = [[NSBundle mainBundle]pathForResource:@"click" ofType:@"wav"];
    click = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:clak]  error:NULL];
    click.delegate = self;
    [click play];
    
}
-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"home"])
        {
            [self goToMainMenu];
        }
        if ([[node name] isEqualToString:@"on"])
        {
            soundOn = YES;
            on = [NSUserDefaults standardUserDefaults];
            [on setBool:soundOn forKey:@"soundOn"];
            [on synchronize];
            
            //[themeMus runAction:[SKAction play]];
            GameViewController *test = [[GameViewController alloc] init];
            [test musicValue];
            
            //[self playTheme];
            
            [self clickSound];
            [self onButtonPressed];
        }
        if ([[node name] isEqualToString:@"off"])
        {
            soundOn = NO;
            on = [NSUserDefaults standardUserDefaults];
            [on setBool:soundOn forKey:@"soundOn"];
            [on synchronize];
            
            GameViewController *test = [[GameViewController alloc] init];
            [test musicValue];
            //[themeMus runAction:[SKAction stop]];
            //if(audioPlayer1 && audioPlayer1.isPlaying) {
                //[audioPlayer1 stop];
            //}
        
            [self playTheme];
            
            [self offButtonPressed];
        }
    }
}
-(void)playTheme {
    
    /*music = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"WilliamCelebration" ofType:@"mp3"]];
    audioPlayer1 = [[AVAudioPlayer alloc]initWithContentsOfURL:music  error:nil];
    audioPlayer1.delegate = self;
    audioPlayer1.numberOfLoops =- 1;*/
    
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

@end
