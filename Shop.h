//
//  Shop.h
//  Factory Fall
//
//  Created by Willie on 2/22/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

BOOL elScreen;
BOOL fbScreen;
BOOL pmScreen;
BOOL hsScreen;
BOOL srScreen;


@interface Shop : SKScene <AVAudioPlayerDelegate> {
    
    //SKSpriteNode *boost;
    SKTexture *backgroundTexture;
    SKSpriteNode *background;
    SKTexture *homeTexture;
    SKSpriteNode *home;
    SKTexture *sideFBTexture;
    SKSpriteNode *sideFB;
    SKTexture *shopBoardTexture;
    SKSpriteNode *shopBoard;
    SKTexture *sideCSTexture;
    SKSpriteNode *sideCS;
    SKTexture *sidePMTexture;
    SKSpriteNode *sidePM;
    SKTexture *sideELTexture;
    SKSpriteNode *sideEL;
    SKTexture *sideHSTexture;
    SKSpriteNode *sideHS;
    SKTexture *sideSRTexture;
    SKSpriteNode *sideSR;
    SKTexture *filterTexture;
    SKSpriteNode *filter;
    
    SKTexture *shopELBoardTexture;
    SKSpriteNode *shopELBoard;
    SKTexture *shopHSBoardTexture;
    SKSpriteNode *shopHSBoard;
    SKTexture *shopMoneyBoardTexture;
    SKSpriteNode *shopMoneyBoard;
    SKTexture *shopPMBoardTexture;
    SKSpriteNode *shopPMBoard;
    SKTexture *shopSRBoardTexture;
    SKSpriteNode *shopSRBoard;
    SKTexture *shopPDBoardTexture;
    SKSpriteNode *shopPDBoard;
    
    SKTexture *buyDoublePointsTexture;
    SKSpriteNode *buyDoublePoints;
    SKTexture *buyTriplePointsTexture;
    SKSpriteNode *buyTriplePoints;
    SKTexture *buyQuadPointsTexture;
    SKSpriteNode *buyQuadPoints;
    SKTexture *buy1ExtraLifeTexture;
    SKSpriteNode *buy1ExtraLife;
    SKTexture *buy2ExtraLivesTexture;
    SKSpriteNode *buy2ExtraLives;
    SKTexture *buy3ExtraLivesTexture;
    SKSpriteNode *buy3ExtraLives;
    SKTexture *buySpeedReduction10Texture;
    SKSpriteNode *buySpeedReduction10;
    SKTexture *buySpeedReduction20Texture;
    SKSpriteNode *buySpeedReduction20;
    SKTexture *buySpeedReduction30Texture;
    SKSpriteNode *buySpeedReduction30;
    SKTexture *buyHeadStart10Texture;
    SKSpriteNode *buyHeadStart10;
    SKTexture *buyHeadStart20Texture;
    SKSpriteNode *buyHeadStart20;
    SKTexture *buyHeadStart30Texture;
    SKSpriteNode *buyHeadStart30;
    SKTexture *buySafePackTexture;
    SKSpriteNode *buySafePack;
    SKTexture *buyInvisiblePackTexture;
    SKSpriteNode *buyInvisiblePack;
    SKTexture *buyGodPackTexture;
    SKSpriteNode *buyGodPack;
    
    SKTexture *buy9KButtonTexture;
    SKSpriteNode *buy9KButton;
    SKTexture *buy30KButtonTexture;
    SKSpriteNode *buy30KButton;
    SKTexture *buy45KButtonTexture;
    SKSpriteNode *buy45KButton;
    SKTexture *buy75KButtonTexture;
    SKSpriteNode *buy75KButton;
    SKTexture *buy150KButtonTexture;
    SKSpriteNode *buy150KButton;
    SKTexture *buy300KButtonTexture;
    SKSpriteNode *buy300KButton;
    SKTexture *factoryBucks3KTexture;
    SKSpriteNode *factoryBucks3K;
    SKTexture *factoryBucks6KTexture;
    SKSpriteNode *factoryBucks6K;
    SKTexture *factoryBucks9KTexture;
    SKSpriteNode *factoryBucks9K;
    SKTexture *factoryBucks10KTexture;
    SKSpriteNode *factoryBucks10K;
    SKTexture *factoryBucks20KTexture;
    SKSpriteNode *factoryBucks20K;
    
    SKTexture *robotHeadTexture;
    SKSpriteNode *robotHead;
    SKTexture *sidePHTexture;
    SKSpriteNode *sidePH;
    AVAudioPlayer *clickSound;
    
    SKTextureAtlas *shopSprites;
    
    
}

-(void)increment9000;
-(void)increment30000;
-(void)increment45000;
-(void)increment75000;
-(void)increment150000;
-(void)increment300000;

@property (nonatomic, weak) SKView *skView;

@end
