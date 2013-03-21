//
//  JanggiViewController.h
//  SPjanggi
//
//  Created by  on 12. 3. 9..
//  Copyright (c) 2012년 SPARROWAPPS. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SPSoundEffect.h"

#ifdef FREE_APP
//#import <iAd/iAd.h>
#import "CaulyViewController.h"
#endif

#define IPHONE_BOARD_WIDTH      (320)
#define IPAD_BOARD_WIDTH        (IPHONE_BOARD_WIDTH * 2)

#define IPHONE_WIDTH            (320)
#define IPAD_WIDTH              (768)

#ifdef FREE_APP
#define IPHONE_HEIGHT           (480 - 50)
#define IPAD_HEIGHT             (1024 - 50)
#else
#define IPHONE_HEIGHT           (480)
#define IPAD_HEIGHT             (1024)
#endif

#define GET_DEVICE_WIDTH        ([self getDeviceWidth])
#define GET_DEVICE_HEIGHT       ([self getDeviceHeight])


#define IPHONE_BOARD_START_X    (0)
#define IPHONE_BOARD_START_Y    ((IPHONE_HEIGHT-IPHONE_BOARD_WIDTH) / 2) //30
#define IPAD_BOARD_START_X      (64)
#define IPAD_BOARD_START_Y      ((IPAD_HEIGHT - IPAD_BOARD_WIDTH) / 2) //152

#define AL_X_STEP_IPAD          (70)
#define AL_Y_STEP_IPAD          (60)
#define AL_X_STEP_IPHONE        (35)
#define AL_Y_STEP_IPHONE        (30)

#define AL_X_STEP               ([self getAlStepX])
#define AL_Y_STEP               ([self getAlStepY])


#define AL_SIZE_X_IPAD          (60)
#define AL_SIZE_Y_IPAD          (60)
#define AL_SIZE_X_IPHONE        (30)
#define AL_SIZE_Y_IPHONE        (30)

#define AL_SIZE_X               ([self getAlSizeX])
#define AL_SIZE_Y               ([self getAlSizeY])


#define BOARD_CONNER_X_SPACING  (40)
#define BOARD_CONNER_Y_SPACING  (40)
#define BOARD_CONNER_X_SPACING_IPHONE (BOARD_CONNER_X_SPACING / 2)
#define BOARD_CONNER_Y_SPACING_IPHONE (BOARD_CONNER_Y_SPACING / 2)

#define AL_FIRSTX_IPHONE        (IPHONE_BOARD_START_X + BOARD_CONNER_X_SPACING_IPHONE - (AL_SIZE_X_IPHONE / 2) )
#define AL_FIRSTY_IPHONE        (IPHONE_BOARD_START_Y + BOARD_CONNER_Y_SPACING_IPHONE - (AL_SIZE_Y_IPHONE / 2) +5)
#define AL_FIRSTX_IPAD          (IPAD_BOARD_START_X + BOARD_CONNER_X_SPACING - (AL_SIZE_X_IPAD / 2) )
#define AL_FIRSTY_IPAD          (IPAD_BOARD_START_Y + BOARD_CONNER_Y_SPACING - (AL_SIZE_Y_IPAD / 2) +5 )

#define AL_FIRST_X              ([self getAlFirstX])
#define AL_FIRST_Y              ([self getAlFirstY])

#define IPHONE_GREEN_INVENTORY_Y  ( GET_DEVICE_HEIGHT - (36) )
#define IPHONE_RED_INVENTORY_Y    ( 8 )

#define IPAD_GREEN_INVENTORY_Y    ( GET_DEVICE_HEIGHT - (36) )
#define IPAD_RED_INVENTORY_Y      ( 8 )

#define AL_GREEN_INV_Y          ([self getAlGreenInvY])
#define AL_RED_INV_Y            ([self getAlRedInvY])

#define DEAD_AL_POS_X           (-1)
#define DEAD_AL_POS_Y           (-1)

//점수 계산
#define VALUE_CHA               (13)
#define VALUE_PO                (7)
#define VALUE_MA                (5)
#define VALUE_SANG              (3)
#define VALUE_SA                (3)
#define VALUE_ZOL               (2)
#define VALUE_WANG              (VALUE_SA)
#define VALUE_AFTER             (1.5) //후수

typedef enum dev_type {
    IPHONE,
    IPAD,
} dev_type;

typedef enum AL_type {AL_NONE,
    GREEN_WANG,
    GREEN_SA,
    GREEN_ZOL,
    GREEN_PO,
    GREEN_CHA,
    GREEN_MA,
    GREEN_SANG,
    GREEN_RED,
    RED_WANG,
    RED_SA,
    RED_BYUNG,
    RED_PO,
    RED_CHA,
    RED_MA,
    RED_SANG,
}AL_type;

typedef enum SIDE_type {
    RED_SIDE = 0,
    GREEN_SIDE = 1,
} SIDE_type;

typedef enum GAME_MODE_type {
    GAME_MODE_READY,
    GAME_MODE_HANDICAP,
    GAME_MODE_STARTED,
}GAME_MODE_type;

typedef enum MENU_TAG_type {
    MENU_TAG_MAIN,
    MENU_TAG_POS,
    MENU_TAG_HANDICAP,
    MENU_TAG_STARTED,
}MENU_TAG_type;

//DEAD_AL_POS_X, DEAD_AL_POS_Y 알이 죽으면 위치를 이걸로 세팅 한다.
typedef struct AL_Data {
    int         board_idx_x;    //장기판 위치
    int         board_idx_y;
    AL_type     al_type;        //알 종류
    bool        selected;       //선택여부
    NSString  * img_file_name;  //알 이미지 파일 이름
    
    //인공지능 관련 자료
    int         value;
    int         score;
}AL_Data;

typedef struct Move_Point {
    int board_idx_x;
    int board_idx_y;
}Move_Point;


//--------------------------------------------------------
#pragma mark - UI History Stack implementation
@interface UIHistory :NSObject {
    int move_btn_index;
    int move_from_x;
    int move_from_y;
    
    int dead_btn_index;
    int dead_from_x;
    int dead_from_y;
}
@property int move_btn_index;
@property int move_from_x;
@property int move_from_y;
@property int dead_btn_index;
@property int dead_from_x;
@property int dead_from_y;

@end


@interface UIHistoryStack : NSObject {
    NSMutableArray *contents;
}

- (void)push:(id)object;
- (id)pop;

@end
//--------------------------------------------------------


@interface JanggiViewController : UIViewController
<
UIActionSheetDelegate
#ifdef FREE_APP
//,ADBannerViewDelegate
#endif
>
{
    //JanggiAI *mJanggiAI;
    
    UIHistory * popHistory;
    UIHistoryStack * mHistoryStack;
    
    
    //UI
    //컨트롤 버튼 어레이
     NSMutableArray * btnCtrlArray;
    
    //장기알 버튼 어레이
     NSMutableArray * btnArray;
    
    //이동표시 버튼 어레이 
     NSMutableArray * btnMoveArray;
    
    //차례 표시 등 어레이
     NSMutableArray * imgArray;
    
    GAME_MODE_type    mGameMode;
    
    SPSoundEffect    *mMoveSound;
    
#ifdef FREE_APP
    BOOL _isBannerVisible;
    //ADBannerView * adBanner;
#endif
}

@property (nonatomic) GAME_MODE_type mGameMode;

- (void) initAlData;
- (void) initGameScreen;
- (void) makeBtnImage:(int)index;
- (void) makeMoveBtnImage:(int)index type:(int)al_type boardx:(int)x boardy:(int)y;
- (void) AlBtnClick:(id)sender;
- (void) movePointGreenZol:(int)x boardy:(int)y;
- (void) movePointRedByung:(int)x boardy:(int)y;
- (void) movePointGreenSa:(int)x boardy:(int)y;
- (void) movePointGreenWang:(int)x boardy:(int)y;
- (void) movePointRedSa:(int)x boardy:(int)y;
- (void) movePointRedWang:(int)x boardy:(int)y;
- (void) movePointCha:(int)x boardy:(int)y type:(int)altype;
- (void) movePointMa:(int)x boardy:(int)y type:(int)altype;
- (void) movePointSang:(int)x boardy:(int)y type:(int)altype;
- (void) movePointPo:(int)x boardy:(int)y type:(int)altype;
- (void) removeAlAnimation:(UIButton *)btn;
- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (int) getAlIndexBoard:(int)x boardy:(int)y;
- (int) getAlTypeBoard:(int)x boardy:(int)y;
- (int) getRedOrGreenBoard:(UIButton *)btn;
- (id)  getAlBtnBoard:(int)x boardy:(int)y;
- (void) AlMoveBtnClick:(id)sender;
- (void) moveAlBtnXY:(UIButton *)btn withX:(int)bx withY:(int)by;
- (void) moveAlBtnNoStackXY:(UIButton *)btn withX:(int)bx withY:(int)by;
- (void) moveFromX:(int)bx fromY:(int)by toX:(int)tox toY:(int)toy optStack:(bool)stackUse;
- (void) makeMovePoint:(int)x boardy:(int)y type:(int)altype;
- (void) removeMoveBtn;
- (void) unselectAlBtn;
- (void) undo;

#pragma mark - IPHONE / IPAD UI size
- (int) getAlSizeX;
- (int) getAlSizeY;
- (int) getAlStepX;
- (int) getAlStepY;
- (int) getAlFirstX;
- (int) getAlFirstY;
- (int) getAlGreenInvY;
- (int) getAlRedInvY;
- (int) getDeviceWidth;
- (int) getDeviceHeight;


#pragma mark - evnet handler
- (void) menuClick:(id)sender;
- (void) undoClick:(id)sender;
- (void) newGame;

#pragma mark - AI

#pragma mark - iAD, Cauly
#ifdef FREE_APP
//- (void) adBannerInit;
- (void) AddCaulyAD;
#endif


@end

