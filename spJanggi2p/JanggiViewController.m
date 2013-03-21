//
//  JanggiViewController.m
//  SPjanggi
//
//  Created by  on 12. 3. 9..
//  Copyright (c) 2012년 SPARROWAPPS. All rights reserved.
//

#import "JanggiViewController.h"
//#import "DetailViewController.h"
//#import "SwipeViewController.h"
#import "AppDelegate.h"

@interface JanggiViewController ()

@end

@implementation JanggiViewController

@synthesize mGameMode;

static AL_Data aldata[32];
static Move_Point movepointxy[32];

//죽게 될 장기알
static id gRemoveAl;
static dev_type gDevice;


- (id)init
{
    self = [super init];
    if (self) {
        
        mGameMode = GAME_MODE_READY;
        
        btnArray = [[NSMutableArray alloc]init];
        btnMoveArray = [[NSMutableArray alloc]init];
        imgArray = [[NSMutableArray alloc]init];
        mHistoryStack = [[UIHistoryStack alloc]init];
    
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        gDevice = IPHONE;
    } else {
        gDevice = IPAD;
    }
    
    //장기판 이미지
    UIImageView * boardImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"board"]];
  
    if(gDevice == IPHONE)
    {
        boardImageView.frame = CGRectMake(IPHONE_BOARD_START_X, IPHONE_BOARD_START_Y, 320, 320);
    }
    else
    {
        boardImageView.frame = CGRectMake(IPAD_BOARD_START_X, IPAD_BOARD_START_Y, 640, 640);
    }

    [self.view addSubview:boardImageView];

    [imgArray addObject:boardImageView];

    [boardImageView release];

    [self initAlData];
    [self initGameScreen];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    mMoveSound = [[SPSoundEffect alloc] initWithSoundNameSysSnd:@"move" ofType:@"wav"];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) dealloc
{
    [mMoveSound release];
    mMoveSound = nil;
    
    [btnArray release];
    btnArray = nil;
    [btnMoveArray release];
    btnMoveArray = nil;
    [imgArray release];
    imgArray = nil;
    [mHistoryStack release];
    mHistoryStack = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//        } else {
//            return YES;
//        }
}


#pragma mark - Data init
- (void)initAlData
{
    aldata[0].board_idx_x = 0;
    aldata[0].board_idx_y = 0;
    aldata[0].al_type = RED_CHA;
    aldata[0].selected = NO;
    aldata[0].img_file_name = @"Red_Cha60r";
    aldata[0].value = VALUE_CHA;
    
    aldata[1].board_idx_x = 1;
    aldata[1].board_idx_y = 0;
    aldata[1].al_type = RED_MA;
    aldata[1].selected = NO;
    aldata[1].img_file_name = @"Red_Ma60r";
    aldata[1].value = VALUE_MA;
    
    aldata[2].board_idx_x = 2;
    aldata[2].board_idx_y = 0;
    aldata[2].al_type = RED_SANG;
    aldata[2].selected = NO;
    aldata[2].img_file_name = @"Red_Sang60r";
    aldata[2].value = VALUE_SANG;
    
    aldata[3].board_idx_x = 3;
    aldata[3].board_idx_y = 0;
    aldata[3].al_type = RED_SA;
    aldata[3].selected = NO;
    aldata[3].img_file_name = @"Red_Sa60r";
    aldata[3].value = VALUE_SA;
    
    aldata[4].board_idx_x = 4;
    aldata[4].board_idx_y = 1;
    aldata[4].al_type = RED_WANG;
    aldata[4].selected = NO;
    aldata[4].img_file_name = @"Red_King60r";
    aldata[4].value = VALUE_WANG;
    
    aldata[5].board_idx_x = 5;
    aldata[5].board_idx_y = 0;
    aldata[5].al_type = RED_SA;
    aldata[5].selected = NO;
    aldata[5].img_file_name = @"Red_Sa60r";
    aldata[5].value = VALUE_SA;
    
    aldata[6].board_idx_x = 6;
    aldata[6].board_idx_y = 0;
    aldata[6].al_type = RED_SANG;
    aldata[6].selected = NO;
    aldata[6].img_file_name = @"Red_Sang60r";
    aldata[6].value = VALUE_SANG;
    
    aldata[7].board_idx_x = 7;
    aldata[7].board_idx_y = 0;
    aldata[7].al_type = RED_MA;
    aldata[7].selected = NO;
    aldata[7].img_file_name = @"Red_Ma60r";
    aldata[7].value = VALUE_MA;
    
    aldata[8].board_idx_x = 8;
    aldata[8].board_idx_y = 0;
    aldata[8].al_type = RED_CHA;
    aldata[8].selected = NO;
    aldata[8].img_file_name = @"Red_Cha60r";
    aldata[8].value = VALUE_CHA;
    
    aldata[9].board_idx_x = 1;
    aldata[9].board_idx_y = 2;
    aldata[9].al_type = RED_PO;
    aldata[9].selected = NO;
    aldata[9].img_file_name = @"Red_Po60r";
    aldata[9].value = VALUE_PO;
    
    aldata[10].board_idx_x = 7;
    aldata[10].board_idx_y = 2;
    aldata[10].al_type = RED_PO;
    aldata[10].selected = NO;
    aldata[10].img_file_name = @"Red_Po60r";
    aldata[10].value = VALUE_PO;
    
    aldata[11].board_idx_x = 0;
    aldata[11].board_idx_y = 3;
    aldata[11].al_type = RED_BYUNG;
    aldata[11].selected = NO;
    aldata[11].img_file_name = @"Red_Byung60r";
    aldata[11].value = VALUE_ZOL;
    
    aldata[12].board_idx_x = 2;
    aldata[12].board_idx_y = 3;
    aldata[12].al_type = RED_BYUNG;
    aldata[12].selected = NO;
    aldata[12].img_file_name = @"Red_Byung60r";    
    aldata[12].value = VALUE_ZOL;
    
    aldata[13].board_idx_x = 4;
    aldata[13].board_idx_y = 3;
    aldata[13].al_type = RED_BYUNG;
    aldata[13].selected = NO;
    aldata[13].img_file_name = @"Red_Byung60r";    
    aldata[13].value = VALUE_ZOL;
    
    aldata[14].board_idx_x = 6;
    aldata[14].board_idx_y = 3;
    aldata[14].al_type = RED_BYUNG;
    aldata[14].selected = NO;
    aldata[14].img_file_name = @"Red_Byung60r";    
    aldata[14].value = VALUE_ZOL;
    
    aldata[15].board_idx_x = 8;
    aldata[15].board_idx_y = 3;
    aldata[15].al_type = RED_BYUNG;
    aldata[15].selected = NO;
    aldata[15].img_file_name = @"Red_Byung60r";
    aldata[15].value = VALUE_ZOL;
    //-----------------------------------------------------    
    aldata[16].board_idx_x = 0;
    aldata[16].board_idx_y = 9;
    aldata[16].al_type = GREEN_CHA;
    aldata[16].selected = NO;
    aldata[16].img_file_name = @"Green_Cha60";
    aldata[16].value = VALUE_CHA;
    
    aldata[17].board_idx_x = 1;
    aldata[17].board_idx_y = 9;
    aldata[17].al_type = GREEN_MA;
    aldata[17].selected = NO;
    aldata[17].img_file_name = @"Green_Ma60";
    aldata[17].value = VALUE_MA;
    
    aldata[18].board_idx_x = 2;
    aldata[18].board_idx_y = 9;
    aldata[18].al_type = GREEN_SANG;
    aldata[18].selected = NO;
    aldata[18].img_file_name = @"Green_Sang60";
    aldata[18].value = VALUE_SANG;
    
    aldata[19].board_idx_x = 3;
    aldata[19].board_idx_y = 9;
    aldata[19].al_type = GREEN_SA;
    aldata[19].selected = NO;
    aldata[19].img_file_name = @"Green_Sa60";
    aldata[19].value = VALUE_SA;
    
    aldata[20].board_idx_x = 4;
    aldata[20].board_idx_y = 8;
    aldata[20].al_type = GREEN_WANG;
    aldata[20].selected = NO;
    aldata[20].img_file_name = @"Green_King60";
    aldata[20].value = VALUE_WANG;
    
    aldata[21].board_idx_x = 5;
    aldata[21].board_idx_y = 9;
    aldata[21].al_type = GREEN_SA;
    aldata[21].selected = NO;
    aldata[21].img_file_name = @"Green_Sa60";
    aldata[21].value = VALUE_SA;
    
    aldata[22].board_idx_x = 6;
    aldata[22].board_idx_y = 9;
    aldata[22].al_type = GREEN_SANG;
    aldata[22].selected = NO;
    aldata[22].img_file_name = @"Green_Sang60";
    aldata[22].value = VALUE_SANG;
    
    aldata[23].board_idx_x = 7;
    aldata[23].board_idx_y = 9;
    aldata[23].al_type = GREEN_MA;
    aldata[23].selected = NO;
    aldata[23].img_file_name = @"Green_Ma60";
    aldata[23].value = VALUE_MA;
    
    aldata[24].board_idx_x = 8;
    aldata[24].board_idx_y = 9;
    aldata[24].al_type = GREEN_CHA;
    aldata[24].selected = NO;
    aldata[24].img_file_name = @"Green_Cha60";
    aldata[24].value = VALUE_CHA;
    
    aldata[25].board_idx_x = 1;
    aldata[25].board_idx_y = 7;
    aldata[25].al_type = GREEN_PO;
    aldata[25].selected = NO;
    aldata[25].img_file_name = @"Green_Po60";
    aldata[25].value = VALUE_PO;
    
    aldata[26].board_idx_x = 7;
    aldata[26].board_idx_y = 7;
    aldata[26].al_type = GREEN_PO;
    aldata[26].selected = NO;
    aldata[26].img_file_name = @"Green_Po60";
    aldata[26].value = VALUE_PO;
    
    aldata[27].board_idx_x = 0;
    aldata[27].board_idx_y = 6;
    aldata[27].al_type = GREEN_ZOL;
    aldata[27].selected = NO;
    aldata[27].img_file_name = @"Green_Zol60";
    aldata[27].value = VALUE_ZOL;
    
    aldata[28].board_idx_x = 2;
    aldata[28].board_idx_y = 6;
    aldata[28].al_type = GREEN_ZOL;
    aldata[28].selected = NO;
    aldata[28].img_file_name = @"Green_Zol60";    
    aldata[28].value = VALUE_ZOL;
    
    aldata[29].board_idx_x = 4;
    aldata[29].board_idx_y = 6;
    aldata[29].al_type = GREEN_ZOL;
    aldata[29].selected = NO;
    aldata[29].img_file_name = @"Green_Zol60";    
    aldata[29].value = VALUE_ZOL;
    
    aldata[30].board_idx_x = 6;
    aldata[30].board_idx_y = 6;
    aldata[30].al_type = GREEN_ZOL;
    aldata[30].selected = NO;
    aldata[30].img_file_name = @"Green_Zol60";    
    aldata[30].value = VALUE_ZOL;
    
    aldata[31].board_idx_x = 8;
    aldata[31].board_idx_y = 6;
    aldata[31].al_type = GREEN_ZOL;
    aldata[31].selected = NO;
    aldata[31].img_file_name = @"Green_Zol60";
    aldata[31].value = VALUE_ZOL;
    
}

#pragma mark - UI Componenet
- (void)initGameScreen
{
    for(int i=0; i<32; i++)
        [self makeBtnImage:i];
    //toolbar
    UIImage * img;
    UIBarButtonItem * barBtn;
    UIBarButtonItem * barBtn2;
    
    UIToolbar * toolbar = [[UIToolbar alloc]init]; //하단
    UIToolbar * toolbar2 = [[UIToolbar alloc]init]; //상단
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar2.barStyle = UIBarStyleBlackTranslucent;
    
    [toolbar sizeToFit];
    [toolbar2 sizeToFit];
    
    NSMutableArray *items = [[NSMutableArray alloc]init ];
    NSMutableArray *items2 = [[NSMutableArray alloc]init ];
    
    
    toolbar.frame = CGRectMake(0, GET_DEVICE_HEIGHT - (44), GET_DEVICE_WIDTH, 44);
    toolbar2.frame = CGRectMake(0,0,GET_DEVICE_WIDTH,44);
    toolbar2.transform = CGAffineTransformMakeRotation(3.141592);

    img = [UIImage imageNamed:@"icon_document"];

    barBtn = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(menuClick:)];
    barBtn.tag = 0;

    barBtn2 = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(menuClick:)];
    barBtn2.tag = 1;
    
    [items addObject:barBtn];
    [items2 addObject:barBtn2];
    [barBtn release];
    
    img = [UIImage imageNamed:@"icon_arrow_left"];
    barBtn = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain  target:self action:@selector(undoClick:)];
    
    barBtn2 = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain  target:self action:@selector(undoClick:)]; 
    
    [items addObject:barBtn];
    [items2 addObject:barBtn2];
    [barBtn release];
    
    toolbar.items = items;
    toolbar2.items = items2;
    [items release];
    
    [self.view addSubview:toolbar];
    [self.view addSubview:toolbar2];
    [toolbar release];
}

- (void) makeBtnImage:(int)index 
{
    int x;
    int y;
    NSString * select_img_file_name;
    
    UIImage * img = [UIImage imageNamed:aldata[index].img_file_name];
    UIButton * btn = [[UIButton alloc]init];
    [img drawInRect:CGRectMake(0, 0, AL_SIZE_X, AL_SIZE_Y)];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:img forState:UIControlStateDisabled];
    
    select_img_file_name = [aldata[index].img_file_name stringByAppendingString:@"s"];
    
    img = [UIImage imageNamed:select_img_file_name];
    
    [img drawInRect:CGRectMake(0,0, AL_SIZE_X, AL_SIZE_Y)];
    [btn setImage:img forState:UIControlStateSelected];
    
    btn.tag = index;
    x = AL_FIRST_X + aldata[index].board_idx_x * AL_X_STEP;
    y = AL_FIRST_Y + aldata[index].board_idx_y * AL_Y_STEP;
    
    btn.frame = CGRectMake(x, y, AL_SIZE_X, AL_SIZE_Y);
    
    [btn addTarget:self action:@selector(AlBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btn];
    [btnArray addObject:btn];
    [btn release];
}

- (void) makeMoveBtnImage:(int)index type:(int)al_type boardx:(int)bx boardy:(int)by
{
    int x, y;
    
    UIImage * img;
    if(al_type < GREEN_RED )
    {
        img = [UIImage imageNamed:@"movepoint2"];
    }
    else
    {
        img = [UIImage imageNamed:@"movepoint"];
    }
    
    UIButton * btn = [[UIButton alloc]init];
    [img drawInRect:CGRectMake(0, 0, AL_SIZE_X, AL_SIZE_Y)];
    [btn setImage:img forState:UIControlStateNormal];
    btn.tag = index;
    x = AL_FIRST_X + bx * AL_X_STEP;
    y = AL_FIRST_Y + by * AL_Y_STEP;
    
    btn.frame = CGRectMake(x, y, AL_SIZE_X, AL_SIZE_Y);
    
    [btn addTarget:self action:@selector(AlMoveBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    [btnMoveArray addObject:btn];
    [btn release];
}

#pragma mark - UI Move
//장기알을 누르면 선택표시와 함께 이동 가능 표시를 한다. 
- (void) AlBtnClick:(id)sender
{
    //이동 가능 표시
    int boardx;
    int boardy;
    int index;
    AL_type altype;
    
    [self removeMoveBtn];
    [self unselectAlBtn];
    
    //띠구 두기    
    if(mGameMode == GAME_MODE_HANDICAP)
    {
        UIButton * btn = (UIButton *)sender;
        if(aldata[btn.tag].al_type == RED_WANG || 
           aldata[btn.tag].al_type == GREEN_WANG)
        {
            return;
        }
        [self removeAlAnimation:btn];
        aldata[btn.tag].board_idx_x = DEAD_AL_POS_X;
        aldata[btn.tag].board_idx_y = DEAD_AL_POS_Y;
        return;
    }
    
    UIButton * btn = (UIButton *)sender;
    index = btn.tag;
    boardx = aldata[index].board_idx_x;
    boardy = aldata[index].board_idx_y;
    if(boardx == -1)
        return;
    
    altype = aldata[index].al_type;
    aldata[index].selected = YES;
    
    btn.selected = YES;
    [self.view bringSubviewToFront:btn];

    switch ( altype )
    {
        case GREEN_ZOL:
            [self movePointGreenZol:boardx boardy:boardy];
            break;
            
        case GREEN_SA:
            [self movePointGreenSa:boardx boardy:boardy];
            break;
            
        case GREEN_WANG:
            [self movePointGreenWang:boardx boardy:boardy];
            break;
            
        case GREEN_CHA:
        case RED_CHA:    
            [self movePointCha:boardx boardy:boardy type:altype];
            break;
            
        case GREEN_MA:
        case RED_MA:
            [self movePointMa:boardx boardy:boardy type:altype];
            break;
            
        case GREEN_SANG:
        case RED_SANG:
            [self movePointSang:boardx boardy:boardy type:altype];
            break;
            
        case GREEN_PO:
        case RED_PO:
            [self movePointPo:boardx boardy:boardy type:altype];
            break;      
            
        case RED_BYUNG:
            [self movePointRedByung:boardx boardy:boardy];
            break;
            
        case RED_SA:
            [self movePointRedSa:boardx boardy:boardy];
            break;
            
        case RED_WANG:
            [self movePointRedWang:boardx boardy:boardy];
            break;            
        default:
            break;
    }
}

- (void) movePointGreenZol:(int)x boardy:(int)y
{
    [self makeMovePoint:x - 1 boardy:y type:GREEN_ZOL];
    [self makeMovePoint:x + 1 boardy:y type:GREEN_ZOL];
    [self makeMovePoint:x boardy:y - 1 type:GREEN_ZOL];
    
    if((x == 3 && y == 2) || (x == 5 && y ==2))
    {
        [self makeMovePoint:4 boardy:1 type:GREEN_ZOL];
    }
    
    if(x == 4 && y == 1)
    {
        [self makeMovePoint:3 boardy:0 type:GREEN_ZOL];
        [self makeMovePoint:5 boardy:0 type:GREEN_ZOL];
    }
}

- (void) movePointRedByung:(int)x boardy:(int)y
{
    [self makeMovePoint:x - 1 boardy:y type:RED_BYUNG];
    [self makeMovePoint:x + 1 boardy:y type:RED_BYUNG];
    [self makeMovePoint:x boardy:y + 1 type:RED_BYUNG];
    
    if((x == 3 && y == 7) || (x == 5 && y ==7))
    {
        [self makeMovePoint:4 boardy:8 type:RED_BYUNG];
    }
    
    if(x == 4 && y == 8)
    {
        [self makeMovePoint:3 boardy:9 type:RED_BYUNG];
        [self makeMovePoint:5 boardy:9 type:RED_BYUNG];
    }
}

- (void) movePointGreenSa:(int)x boardy:(int)y
{
    [self makeMovePoint:x - 1 boardy:y type:GREEN_SA];
    [self makeMovePoint:x + 1 boardy:y type:GREEN_SA];
    [self makeMovePoint:x boardy:y + 1 type:GREEN_SA];
    [self makeMovePoint:x boardy:y - 1 type:GREEN_SA];
    
    if((x == 3 && y == 9) || (x == 5 && y ==9) || (x == 3 && y == 7) || (x==5 && y ==7))
    {
        [self makeMovePoint:4 boardy:8 type:GREEN_SA];
    }
    
    if(x == 4 && y == 8)
    {
        [self makeMovePoint:3 boardy:9 type:GREEN_SA];
        [self makeMovePoint:5 boardy:9 type:GREEN_SA];
        [self makeMovePoint:3 boardy:7 type:GREEN_SA];
        [self makeMovePoint:5 boardy:7 type:GREEN_SA];
    }
}

- (void) movePointGreenWang:(int)x boardy:(int)y
{
    [self makeMovePoint:x - 1 boardy:y type:GREEN_WANG];
    [self makeMovePoint:x + 1 boardy:y type:GREEN_WANG];
    [self makeMovePoint:x boardy:y + 1 type:GREEN_WANG];
    [self makeMovePoint:x boardy:y - 1 type:GREEN_WANG];
    
    if((x == 3 && y == 9) || (x == 5 && y ==9) || (x == 3 && y == 7) || (x==5 && y ==7))
    {
        [self makeMovePoint:4 boardy:8 type:GREEN_WANG];
    }
    
    if(x == 4 && y == 8)
    {
        [self makeMovePoint:3 boardy:9 type:GREEN_WANG];
        [self makeMovePoint:5 boardy:9 type:GREEN_WANG];
        [self makeMovePoint:3 boardy:7 type:GREEN_WANG];
        [self makeMovePoint:5 boardy:7 type:GREEN_WANG];
    }
}

- (void) movePointRedSa:(int)x boardy:(int)y
{
    [self makeMovePoint:x - 1 boardy:y type:RED_SA];
    [self makeMovePoint:x + 1 boardy:y type:RED_SA];
    [self makeMovePoint:x boardy:y + 1 type:RED_SA];
    [self makeMovePoint:x boardy:y - 1 type:RED_SA];
    
    if((x == 3 && y == 2) || (x == 5 && y ==2) || (x == 3 && y == 0) || (x==5 && y ==0))
    {
        [self makeMovePoint:4 boardy:1 type:RED_SA];
    }
    
    if(x == 4 && y == 1)
    {
        [self makeMovePoint:3 boardy:2 type:RED_SA];
        [self makeMovePoint:5 boardy:2 type:RED_SA];
        [self makeMovePoint:3 boardy:0 type:RED_SA];
        [self makeMovePoint:5 boardy:0 type:RED_SA];
    }
}

- (void) movePointRedWang:(int)x boardy:(int)y
{
    [self makeMovePoint:x - 1 boardy:y type:RED_WANG];
    [self makeMovePoint:x + 1 boardy:y type:RED_WANG];
    [self makeMovePoint:x boardy:y + 1 type:RED_WANG];
    [self makeMovePoint:x boardy:y - 1 type:RED_WANG];
    
    if((x == 3 && y == 2) || (x == 5 && y ==2) || (x == 3 && y == 0) || (x==5 && y ==0))
    {
        [self makeMovePoint:4 boardy:1 type:RED_WANG];
    }
    
    if(x == 4 && y == 1)
    {
        [self makeMovePoint:3 boardy:2 type:RED_WANG];
        [self makeMovePoint:5 boardy:2 type:RED_WANG];
        [self makeMovePoint:3 boardy:0 type:RED_WANG];
        [self makeMovePoint:5 boardy:0 type:RED_WANG];
    }
}

- (void) movePointCha:(int)x boardy:(int)y type:(int)altype
{
    for(int i = x - 1 ; i >= 0 ; i --) 
    {
        [self makeMovePoint:i boardy:y type:altype];
        if ([self getAlTypeBoard:i boardy:y] != AL_NONE)
            break;
    }
    for(int i = x + 1 ; i < 9 ; i ++ )
    {
        [self makeMovePoint:i boardy:y type:altype];
        if ([self getAlTypeBoard:i boardy:y] != AL_NONE)
            break;
    }
    for(int i = y - 1; i >= 0 ; i --)
    {
        [self makeMovePoint:x boardy:i type:altype];
        if ([self getAlTypeBoard:x boardy:i] != AL_NONE)
            break;
    }
    for(int i = y + 1; i < 10 ; i ++)
    {
        [self makeMovePoint:x boardy:i type:altype];
        if ([self getAlTypeBoard:x boardy:i] != AL_NONE)
            break;
    }
    //궁에 4귀퉁이
    if(x==3 && y== 0)
    {
        [self makeMovePoint:4 boardy:1 type:altype];
        if([self getAlTypeBoard:4 boardy:1] == AL_NONE)
            [self makeMovePoint:5 boardy:2 type:altype];
    }
    if(x==5 && y== 0)
    {
        [self makeMovePoint:4 boardy:1 type:altype];
        if([self getAlTypeBoard:4 boardy:1] == AL_NONE)
            [self makeMovePoint:3 boardy:2 type:altype];   
    }
    if(x==3 && y ==2)
    {
        [self makeMovePoint:4 boardy:1 type:altype];
        if([self getAlTypeBoard:4 boardy:1] == AL_NONE)
            [self makeMovePoint:5 boardy:0 type:altype];
    }
    if(x==5 && y==2)
    {
        [self makeMovePoint:4 boardy:1 type:altype];
        if([self getAlTypeBoard:4 boardy:1] == AL_NONE)
            [self makeMovePoint:3 boardy:0 type:altype];
    }
    //궁에 중심
    if(x==4 && y==1)
    {
        [self makeMovePoint:3 boardy:0 type:altype];
        [self makeMovePoint:5 boardy:0 type:altype];
        [self makeMovePoint:3 boardy:2 type:altype];
        [self makeMovePoint:5 boardy:2 type:altype];
    }
    
    //궁에 4귀퉁이
    if(x==3 && y== 7)
    {
        [self makeMovePoint:4 boardy:8 type:altype];
        if([self getAlTypeBoard:4 boardy:8] == AL_NONE)
            [self makeMovePoint:5 boardy:9 type:altype];
    }
    if(x==5 && y== 7)
    {
        [self makeMovePoint:4 boardy:8 type:altype];
        if([self getAlTypeBoard:4 boardy:8] == AL_NONE)
            [self makeMovePoint:3 boardy:9 type:altype];   
    }
    if(x==3 && y ==9)
    {
        [self makeMovePoint:4 boardy:8 type:altype];
        if([self getAlTypeBoard:4 boardy:8] == AL_NONE)
            [self makeMovePoint:5 boardy:7 type:altype];
    }
    if(x==5 && y==9)
    {
        [self makeMovePoint:4 boardy:8 type:altype];
        if([self getAlTypeBoard:4 boardy:8] == AL_NONE)
            [self makeMovePoint:3 boardy:7 type:altype];
    }
    //궁에 중심
    if(x==4 && y==8)
    {
        [self makeMovePoint:3 boardy:7 type:altype];
        [self makeMovePoint:5 boardy:7 type:altype];
        [self makeMovePoint:3 boardy:9 type:altype];
        [self makeMovePoint:5 boardy:9 type:altype];
    }
}

- (void) movePointMa:(int)x boardy:(int)y type:(int)altype
{
    if([self getAlTypeBoard:x boardy:y-1] == AL_NONE)
    {
        [self makeMovePoint:x-1 boardy:y-2 type:altype];
        [self makeMovePoint:x+1 boardy:y-2 type:altype];
    }
    
    if([self getAlTypeBoard:x boardy:y+1] == AL_NONE)
    {
        [self makeMovePoint:x-1 boardy:y+2 type:altype];
        [self makeMovePoint:x+1 boardy:y+2 type:altype];
    }
    
    if([self getAlTypeBoard:x-1 boardy:y] == AL_NONE)
    {
        [self makeMovePoint:x-2 boardy:y-1 type:altype];
        [self makeMovePoint:x-2 boardy:y+1 type:altype];
    }
    
    if([self getAlTypeBoard:x+1 boardy:y] == AL_NONE)
    {
        [self makeMovePoint:x+2 boardy:y-1 type:altype];
        [self makeMovePoint:x+2 boardy:y+1 type:altype];
    }
}

- (void) movePointSang:(int)x boardy:(int)y type:(int)altype
{
    if([self getAlTypeBoard:x boardy:y-1] == AL_NONE )
    {
        if([self getAlTypeBoard:x-1 boardy:y-2] == AL_NONE)
        {
            [self makeMovePoint:x-2 boardy:y-3 type:altype];
        }
        
        if([self getAlTypeBoard:x+1 boardy:y-2] == AL_NONE)
        {
            [self makeMovePoint:x+2 boardy:y-3 type:altype];
        }
    }
    
    if([self getAlTypeBoard:x boardy:y+1] == AL_NONE)
    {
        if([self getAlTypeBoard:x-1 boardy:y+2] == AL_NONE)
        {
            [self makeMovePoint:x-2 boardy:y+3 type:altype];
        }
        
        if([self getAlTypeBoard:x+1 boardy:y+2] == AL_NONE)
        {
            [self makeMovePoint:x+2 boardy:y+3 type:altype];
        }
    }
    
    if([self getAlTypeBoard:x-1 boardy:y] == AL_NONE)
    {
        if([self getAlTypeBoard:x-2 boardy:y-1] == AL_NONE)
        {
            [self makeMovePoint:x-3 boardy:y-2 type:altype];
        }
        
        if([self getAlTypeBoard:x-2 boardy:y+1] == AL_NONE)
        {
            [self makeMovePoint:x-3 boardy:y+2 type:altype];
        }
    }
    
    if([self getAlTypeBoard:x+1 boardy:y] == AL_NONE)
    {
        if([self getAlTypeBoard:x+2 boardy:y-1] == AL_NONE)
        {
            [self makeMovePoint:x+3 boardy:y-2 type:altype];
        }
        
        if([self getAlTypeBoard:x+2 boardy:y+1] == AL_NONE)
        {
            [self makeMovePoint:x+3 boardy:y+2 type:altype];
        }
    }
}

- (void) movePointPo:(int)x boardy:(int)y type:(int)altype
{
    int al;
    BOOL find = NO;
    //넘어갈놈이 있나 검색
    for(int i = x - 1 ; i >= 0 ; i --) 
    {
        al = [self getAlTypeBoard:i boardy:y];
        if ((al == GREEN_PO || al == RED_PO) && find == NO)
        {
            break;
        }
        if (al != AL_NONE && al != GREEN_PO && al != RED_PO && find == NO )
        {
            find = YES;
            continue;
        }
        if(find == YES)
            [self makeMovePoint:i boardy:y type:altype];
        
        if(find == YES && al != AL_NONE)
        {
            break;
        }
    }
    find = NO;
    for(int i = x + 1 ; i < 9 ; i ++ )
    {
        al = [self getAlTypeBoard:i boardy:y];
        if ((al == GREEN_PO || al == RED_PO) && find == NO)
        {
            break;
        }
        if (al != AL_NONE && al != GREEN_PO && al != RED_PO && find == NO )
        {
            find = YES;
            continue;
        }
        if(find == YES)
            [self makeMovePoint:i boardy:y type:altype];
        
        if(find == YES && al != AL_NONE)
        {
            break;
        }
    }
    find = NO;
    for(int i = y - 1; i >= 0 ; i --)
    {
        al = [self getAlTypeBoard:x boardy:i];
        if ((al == GREEN_PO || al == RED_PO) && find == NO)
        {
            break;
        }
        if (al != AL_NONE && al != GREEN_PO && al != RED_PO && find == NO )
        {
            find = YES;
            continue;
        }
        if(find == YES)
            [self makeMovePoint:x boardy:i type:altype];
        
        if(find == YES && al != AL_NONE)
        {
            break;
        }
    }
    find = NO;
    for(int i = y + 1; i < 10 ; i ++)
    {
        al = [self getAlTypeBoard:x boardy:i];
        if ((al == GREEN_PO || al == RED_PO) && find == NO)
        {
            break;
        }
        if (al != AL_NONE && al != GREEN_PO && al != RED_PO && find == NO )
        {
            find = YES;
            continue;
        }
        if(find == YES)
            [self makeMovePoint:x boardy:i type:altype];
        
        if(find == YES && al != AL_NONE)
        {
            break;
        }
    }
    
    //궁에 4귀퉁이 에 있는 경우
    al = [self getAlTypeBoard:4 boardy:1];
    if(x==3 && y==0)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:5 boardy:2 type:altype];
        }
    }
    if(x==5 && y == 0)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:3 boardy:2 type:altype];
        }
    }
    if(x==3 && y==2)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:5 boardy:0 type:altype];
        }
    }
    if(x==5 && y==2)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:3 boardy:0 type:altype];
        }
    }
    
    al = [self getAlTypeBoard:4 boardy:8];
    if(x==3 && y==7)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:5 boardy:9 type:altype];
        }
    }
    if(x==5 && y == 7)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:3 boardy:9 type:altype];
        }
    }
    if(x==3 && y==9)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:5 boardy:7 type:altype];
        }
    }
    if(x==5 && y==9)
    {
        if(al != AL_NONE && al != RED_PO && al != GREEN_PO)
        {
            [self makeMovePoint:3 boardy:7 type:altype];
        }
    }
}

//보드 x, y 에 알 인덱스를 리턴한다.
- (int) getAlIndexBoard:(int)x boardy:(int)y
{
    int res = -1;
    for (int i=0; i<32; i++)
    {
        if (aldata[i].board_idx_x == x && aldata[i].board_idx_y == y)
        {
            res = i;
            break;
        }
    }
    
    return res;
}

//보드 x, y 에 어떤 알이 잇는지 리턴 한다. 
- (int) getAlTypeBoard:(int)x boardy:(int)y
{
    int res = AL_NONE;
    for (int i=0; i<32; i++)
    {
        if (aldata[i].board_idx_x == x && aldata[i].board_idx_y == y)
        {
            res = aldata[i].al_type;
            break;
        }
    }
    
    return res;
}

//보드에 x, y에 장기알을 리턴 한다. 
- (id) getAlBtnBoard:(int)x boardy:(int)y
{
    id res = nil;
    for (int i=0; i<32; i++)
    {
        if (aldata[i].board_idx_x == x && aldata[i].board_idx_y == y)
        {
            res = [btnArray objectAtIndex:i];
            break;
        }
    }
    
    return res;
}

//초 한 록
- (int) getRedOrGreenBoard:(UIButton *)btn
{
    int res = aldata[btn.tag].al_type;
    if (res < GREEN_RED)
    {
        return GREEN_SIDE;
    }
    else
    {
        return RED_SIDE;
    }
}

//알 이동 표시 버튼을 눌렀을때 알을 이동시키고 사라진다.
//수동으로 움직일때 이용한다.
- (void) AlMoveBtnClick:(id)sender
{   
    int moveBtnIndex;
    int alBtnIndex;
    int x;
    int y;
    
    UIButton * moveBtn = (UIButton *)sender;
    moveBtnIndex = moveBtn.tag;
    x = movepointxy[moveBtnIndex].board_idx_x;
    y = movepointxy[moveBtnIndex].board_idx_y;
    
    UIButton * alBtn;
    for(int i = 0; i<32; i++)
    {
        if(aldata[i].selected == YES)
        {
            alBtnIndex = i;
            break;
        }
    }
    
    alBtn = [btnArray objectAtIndex:alBtnIndex];
    
    if([self getAlTypeBoard:x boardy:y] != AL_NONE)
    {
        gRemoveAl = [self getAlBtnBoard:x boardy:y];
    }
    else
    {
        gRemoveAl = nil;
    }
    
    if (mGameMode != GAME_MODE_STARTED)
    {
        mGameMode = GAME_MODE_STARTED;
    }
    
    //에니메이션 (선택된 알에서 무브 포인트로 이동
    [UIView beginAnimations:@"AlMoveBtn" context:nil];
    [UIView setAnimationDuration:0.7];
    alBtn.frame = CGRectMake(moveBtn.frame.origin.x, moveBtn.frame.origin.y, moveBtn.frame.size.width, moveBtn.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    
    //history
    UIHistory * mCurrHistory = [[UIHistory alloc]init];
    mCurrHistory.move_btn_index = alBtnIndex;
    mCurrHistory.move_from_x = aldata[alBtnIndex].board_idx_x;
    mCurrHistory.move_from_y = aldata[alBtnIndex].board_idx_y;
    
    if(gRemoveAl != nil)
    {
        UIButton * deadBtn = (UIButton *)gRemoveAl;
        mCurrHistory.dead_btn_index = deadBtn.tag;
        mCurrHistory.dead_from_x = aldata[deadBtn.tag].board_idx_x;
        mCurrHistory.dead_from_y = aldata[deadBtn.tag].board_idx_y;
        
    }
    else 
    {
        mCurrHistory.dead_btn_index = -1;
        mCurrHistory.dead_from_x = -1;
        mCurrHistory.dead_from_y = -1;
    }
    [mHistoryStack push:mCurrHistory];
    [mCurrHistory release];
    mCurrHistory = nil;
    
  
    aldata[alBtnIndex].board_idx_x = x;
    aldata[alBtnIndex].board_idx_y = y;
    
    [self removeMoveBtn];
    [self unselectAlBtn];
}

//주어진 보드 좌표로 알을 이동
- (void) moveAlBtnXY:(UIButton *)btn withX:(int)bx withY:(int)by
{
    int index;
    int x,y;
    index = btn.tag;
    x = AL_FIRST_X + bx * AL_X_STEP;
    y = AL_FIRST_Y + by * AL_Y_STEP;
    
    //btn.selected = YES;
    [self.view bringSubviewToFront:btn];
    
    [UIView beginAnimations:@"moveXY" context:nil];
    [UIView setAnimationDuration:0.7];
    btn.frame = CGRectMake(x, y, btn.frame.size.width, btn.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    
    //잡는 말이 있다면..
    if([self getAlTypeBoard:bx boardy:by] != AL_NONE)
    {
        gRemoveAl = [self getAlBtnBoard:bx boardy:by];
    }
    else
    {
        gRemoveAl = nil;
    }
    
    //history
    UIHistory * mCurrHistory = [[UIHistory alloc]init];
    mCurrHistory.move_btn_index = index;
    mCurrHistory.move_from_x = aldata[index].board_idx_x;
    mCurrHistory.move_from_y = aldata[index].board_idx_y;
    
    if(gRemoveAl != nil)
    {
        UIButton * deadBtn = (UIButton *)gRemoveAl;
        mCurrHistory.dead_btn_index = deadBtn.tag;
        mCurrHistory.dead_from_x = aldata[deadBtn.tag].board_idx_x;
        mCurrHistory.dead_from_y = aldata[deadBtn.tag].board_idx_y;
    }
    else 
    {
        mCurrHistory.dead_btn_index = -1;
        mCurrHistory.dead_from_x = -1;
        mCurrHistory.dead_from_y = -1;
    }
    [mHistoryStack push:mCurrHistory];
    [mCurrHistory release];
    mCurrHistory = nil;

    aldata[index].board_idx_x = bx;
    aldata[index].board_idx_y = by;
}

//포지션 변경, 등에 사용된다.
- (void) moveAlBtnNoStackXY:(UIButton *)btn withX:(int)bx withY:(int)by
{
    int index;
    int x,y;
    index = btn.tag;
    x = AL_FIRST_X + bx * AL_X_STEP;
    y = AL_FIRST_Y + by * AL_Y_STEP;
    
    //btn.selected = YES;
    [self.view bringSubviewToFront:btn];
    
    [UIView beginAnimations:@"moveXYNostack" context:nil];
    [UIView setAnimationDuration:0.7];
    btn.frame = CGRectMake(x, y, btn.frame.size.width, btn.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    
    aldata[index].board_idx_x = bx;
    aldata[index].board_idx_y = by;
}

- (void) moveFromX:(int)bx fromY:(int)by toX:(int)tox toY:(int)toy optStack:(bool)stackUse
{
    int index;
    BOOL find = NO;
    for(int i=0;i<32;i++)
    {
        if(aldata[i].board_idx_x == bx && aldata[i].board_idx_y == by)
        {
            index = i;
            find = YES;
            break;
        }
    }
    
    if (find == NO)
    {
        return;
    }
    else 
    {
        if(stackUse == YES)
        {
            [self moveAlBtnXY:[btnArray objectAtIndex:index] withX:tox withY:toy];    
        }
        else 
        {
            [self moveAlBtnNoStackXY:[btnArray objectAtIndex:index] withX:tox withY:toy];
        }
        
    }
}

//알 죽음 에니메이션
- (void) removeAlAnimation:(UIButton *)btn
{
    int x;
    int y;
    [self.view bringSubviewToFront:btn];
    [UIView beginAnimations:@"deadAl" context:nil];
    [UIView setAnimationDuration:0.7];
    
    if ([self getRedOrGreenBoard:btn] == GREEN_SIDE )
    {
        x = 0;
        y = AL_RED_INV_Y;
    }
    
    if( [self getRedOrGreenBoard:btn] == RED_SIDE )
    {
        x = GET_DEVICE_WIDTH - AL_SIZE_X;
        y = AL_GREEN_INV_Y;
    }
    
    btn.frame = CGRectMake(x, y, btn.frame.size.width, btn.frame.size.height);
    [UIView commitAnimations];    
}

//에니메이션의 종료를 이리로 집중시킨다.
- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
    //알이 이동 에니메이션 끝 장기알 먹기
    if ([animationID isEqualToString:@"AlMoveBtn"])
    {
        
        if(gRemoveAl != nil)
        {
            UIButton * btn = (UIButton *)gRemoveAl;
            
            [self removeAlAnimation:btn];
            aldata[btn.tag].board_idx_x = DEAD_AL_POS_X;
            aldata[btn.tag].board_idx_y = DEAD_AL_POS_Y;
        }
        else
        {
            // Nothing to do.
        }        

        [mMoveSound play];
    }
    
    //알이 이동 에니메이션 끝 장기알 먹기
    if ([animationID isEqualToString:@"moveXY"])
    {
        
        if(gRemoveAl != nil)
        {
            UIButton * btn = (UIButton *)gRemoveAl;
            
            [self removeAlAnimation:btn];

            aldata[btn.tag].board_idx_x = DEAD_AL_POS_X;
            aldata[btn.tag].board_idx_y = DEAD_AL_POS_Y;
        }
        else
        {
            //Nothing to do.
        }
    }
}

//이동표시 버튼및 자료구조를 생성한다.
- (void) makeMovePoint:(int)x boardy:(int)y type:(int)altype
{
    int index;
    int board_al = [self getAlTypeBoard:x boardy:y];
    
    if(x <0 || x > 8 || y < 0 || y > 9)
        return;
    
    //같은 편끼리 먹지 못함 : 그 대상이 되면 디펜스를 받는 것이므로 AI측정 점수가 오른다.
    if((altype < GREEN_RED) && (board_al < GREEN_RED) && (board_al != AL_NONE))
    {
        index = [self getAlIndexBoard:x boardy:y];
        //aldata[index].score += (VALUE_CHA - aldata[index].value);
        
        return;
    }
    
    if((altype > GREEN_RED) && (board_al > GREEN_RED) && (board_al != AL_NONE))
    {        
        index = [self getAlIndexBoard:x boardy:y];
        //aldata[index].score += (VALUE_CHA - aldata[index].value);
        
        return;
    }
    
    //궁에 있는 기물은 궁을 벗어나지 못함
    if(altype == GREEN_SA || altype == GREEN_WANG)
    {
        if( x < 3 || x > 5 || y < 7 || y > 9)
            return;
    }
    
    if(altype == RED_SA || altype == RED_WANG)
    {
        if (x < 3 || x > 5 || y < 0 || y > 2)
            return;
    }
    
    //포가 포를 먹지 못함
    if( (altype == RED_PO && board_al == GREEN_PO) || (altype == GREEN_PO && board_al == RED_PO))
        return;
    
    index = [btnMoveArray count];
    [self makeMoveBtnImage:index type:altype boardx:x boardy:y];
    movepointxy[index].board_idx_x = x;
    movepointxy[index].board_idx_y = y;
}

//이동표시 버튼을 제거 한다.
- (void) removeMoveBtn
{
    //이동 버튼 리소스 제거 
    if (btnMoveArray != nil)
    {
        for (int i=0; i< [btnMoveArray count]; i++)
        {
            UIButton * btn = [btnMoveArray objectAtIndex:i];
            [btn removeFromSuperview];
        }
        [btnMoveArray removeAllObjects];
    }    
}

//장기알 선택을 제거 한다.
- (void) unselectAlBtn
{
    for(int i=0; i<32; i++)
    {
        if (aldata[i].selected == YES)
        {
            aldata[i].selected = NO;
            UIButton * btn = [btnArray objectAtIndex:i];
            
            btn.selected = NO;
        }
    }
}


- (void) undo
{
    int x,y;
    int index;
    
    popHistory = (UIHistory *)[mHistoryStack pop];
    if (popHistory == nil)
    {
        return;
    }
        
    index = popHistory.move_btn_index;
    UIButton * btn = [btnArray objectAtIndex:index];

    x = AL_FIRST_X + popHistory.move_from_x * AL_X_STEP;
    y = AL_FIRST_Y + popHistory.move_from_y * AL_Y_STEP;
    aldata[index].board_idx_x = popHistory.move_from_x;
    aldata[index].board_idx_y = popHistory.move_from_y;
     
    //에니메이션 
    [UIView beginAnimations:@"undoxx" context:nil];
    [UIView setAnimationDuration:0.3];
    btn.frame = CGRectMake(x, y, btn.frame.size.width, btn.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    
    //죽은알 되돌리기..
    index = popHistory.dead_btn_index;
    if (index == -1)
        return;
    btn = [btnArray objectAtIndex:index];
    x = AL_FIRST_X + popHistory.dead_from_x * AL_X_STEP;
    y = AL_FIRST_Y + popHistory.dead_from_y * AL_Y_STEP;
    aldata[index].board_idx_x = popHistory.dead_from_x;
    aldata[index].board_idx_y = popHistory.dead_from_y;
    
    //에니메이션 
    [UIView beginAnimations:@"undoDead" context:nil];
    [UIView setAnimationDuration:0.3];
    btn.frame = CGRectMake(x, y, btn.frame.size.width, btn.frame.size.height);
    
    [UIView commitAnimations];
    
}

#pragma mark - evnet handler


- (void) menuClick:(id)sender
{
    UIBarButtonItem * barbtn = (UIBarButtonItem  *)sender;
    
    UIAlertView *alert;
    [self removeMoveBtn];
    [self unselectAlBtn];
    
    if (mGameMode == GAME_MODE_READY)
    {
        alert = [[UIAlertView alloc]initWithTitle:@"장기판"
                                          message:@"메뉴"
                                         delegate:self 
                                cancelButtonTitle:@"되돌아가기" 
                                otherButtonTitles:@"새 대국",@"차림설정", @"접장기 설정",nil];

        alert.tag= MENU_TAG_MAIN;
    }
    else if (mGameMode == GAME_MODE_HANDICAP )
    {
        alert = [[UIAlertView alloc]initWithTitle:@"장기판"
                                          message:@"메뉴"
                                         delegate:self 
                                cancelButtonTitle:@"되돌아가기" 
                                otherButtonTitles:@"새 대국",@"대국 시작", nil];
        alert.tag = MENU_TAG_HANDICAP;
    }
    else if (mGameMode == GAME_MODE_STARTED )
    {
        alert = [[UIAlertView alloc]initWithTitle:@"장기판"
                                          message:@"메뉴"
                                         delegate:self 
                                cancelButtonTitle:@"되돌아가기" 
                                otherButtonTitles:@"새 대국",nil];
        
        alert.tag= MENU_TAG_STARTED;
        
    }
    else
    {
        //nothing to do.
    }
    
    if (barbtn.tag == 0)
    {
        [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
        
    }
    else
        
    {
        [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortraitUpsideDown;
        
    }

    [alert show];
    [alert release];
}

- (void) setPositionMenu 
{
    [self removeMoveBtn];
    [self unselectAlBtn];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"차림설정"
                                                   message:@"메뉴"
                                                  delegate:self 
                                         cancelButtonTitle:@"되돌아가기" 
                                         otherButtonTitles:@"마상상마",@"마상마상", @"상마상마",@"상마마상",nil];
    
    alert.tag= MENU_TAG_POS;
    [alert show];
    [alert release];
}



//alert view 처리
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //새대국
    if ( (buttonIndex == 1 && alertView.tag == MENU_TAG_MAIN) ||
         (buttonIndex == 1 && alertView.tag == MENU_TAG_HANDICAP) ||
         (buttonIndex == 1 && alertView.tag == MENU_TAG_STARTED) )
    {
        [self newGame];
    }
    
    if (buttonIndex == 2 && alertView.tag == MENU_TAG_HANDICAP) 
    {
        mGameMode = GAME_MODE_STARTED;
    }
    
    //포지션 설정
    if (buttonIndex == 2 && alertView.tag == MENU_TAG_MAIN)
    {
        [self setPositionMenu];
    }
    
    //접장기 설정
    if (buttonIndex ==3 && alertView.tag == MENU_TAG_MAIN)
    {
        mGameMode = GAME_MODE_HANDICAP;
    }
    
    //포지션 변경 
    if (alertView.tag == MENU_TAG_POS) {
        [self setPosition:buttonIndex];
    }
   
}

- (void) setPosition:(int)idx
{
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait ) //하단 팀
    {
        switch (idx)
        {
            case 1:  //마상상마
                if([self getAlTypeBoard:1 boardy:9] == GREEN_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:1 fromY:9 toX:2 toY:8 optStack:NO];
                    [self moveFromX:2 fromY:9 toX:1 toY:9 optStack:NO];
                    [self moveFromX:2 fromY:8 toX:2 toY:9 optStack:NO];
                }
                
                if([self getAlTypeBoard:6 boardy:9] == GREEN_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:6 fromY:9 toX:7 toY:8 optStack:NO];
                    [self moveFromX:7 fromY:9 toX:6 toY:9 optStack:NO];
                    [self moveFromX:7 fromY:8 toX:7 toY:9 optStack:NO];
                }
                
                break;
                
            case 2: //마상마상
                if([self getAlTypeBoard:1 boardy:9] == GREEN_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:1 fromY:9 toX:2 toY:8 optStack:NO];
                    [self moveFromX:2 fromY:9 toX:1 toY:9 optStack:NO];
                    [self moveFromX:2 fromY:8 toX:2 toY:9 optStack:NO];

                }
                
                if([self getAlTypeBoard:6 boardy:9] == GREEN_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:6 fromY:9 toX:7 toY:8 optStack:NO];
                    [self moveFromX:7 fromY:9 toX:6 toY:9 optStack:NO];
                    [self moveFromX:7 fromY:8 toX:7 toY:9 optStack:NO];
                }

                break;
                
            case 3: //상마상마
                if([self getAlTypeBoard:1 boardy:9] == GREEN_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:1 fromY:9 toX:2 toY:8 optStack:NO];
                    [self moveFromX:2 fromY:9 toX:1 toY:9 optStack:NO];
                    [self moveFromX:2 fromY:8 toX:2 toY:9 optStack:NO];

                }
                
                if([self getAlTypeBoard:6 boardy:9] == GREEN_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:6 fromY:9 toX:7 toY:8 optStack:NO];
                    [self moveFromX:7 fromY:9 toX:6 toY:9 optStack:NO];
                    [self moveFromX:7 fromY:8 toX:7 toY:9 optStack:NO];
                }
                break;
            case 4: //상마마상
                if([self getAlTypeBoard:1 boardy:9] == GREEN_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:1 fromY:9 toX:2 toY:8 optStack:NO];
                    [self moveFromX:2 fromY:9 toX:1 toY:9 optStack:NO];
                    [self moveFromX:2 fromY:8 toX:2 toY:9 optStack:NO];

                }
                
                if([self getAlTypeBoard:6 boardy:9] == GREEN_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:6 fromY:9 toX:7 toY:8 optStack:NO];
                    [self moveFromX:7 fromY:9 toX:6 toY:9 optStack:NO];
                    [self moveFromX:7 fromY:8 toX:7 toY:9 optStack:NO];
                }
                break;
        }
        
    }
    else 
    {
        switch (idx)
        {
            case 1:  //마상상마
                if([self getAlTypeBoard:1 boardy:0] == RED_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:2 fromY:0 toX:2 toY:1 optStack:NO];
                    [self moveFromX:1 fromY:0 toX:2 toY:0 optStack:NO];
                    [self moveFromX:2 fromY:1 toX:1 toY:0 optStack:NO];
                }
                
                if([self getAlTypeBoard:7 boardy:0] == RED_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:7 fromY:0 toX:7 toY:1 optStack:NO];
                    [self moveFromX:6 fromY:0 toX:7 toY:0 optStack:NO];
                    [self moveFromX:7 fromY:1 toX:6 toY:0 optStack:NO];
                }
                
                break;
                
            case 2: //마상마상
                if([self getAlTypeBoard:1 boardy:0] == RED_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:2 fromY:0 toX:2 toY:1 optStack:NO];
                    [self moveFromX:1 fromY:0 toX:2 toY:0 optStack:NO];
                    [self moveFromX:2 fromY:1 toX:1 toY:0 optStack:NO];
                    
                }
                
                if([self getAlTypeBoard:7 boardy:0] == RED_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:7 fromY:0 toX:7 toY:1 optStack:NO];
                    [self moveFromX:6 fromY:0 toX:7 toY:0 optStack:NO];
                    [self moveFromX:7 fromY:1 toX:6 toY:0 optStack:NO];
                }
                
                break;
                
            case 3: //상마상마
                if([self getAlTypeBoard:1 boardy:0] == RED_MA)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:2 fromY:0 toX:2 toY:1 optStack:NO];
                    [self moveFromX:1 fromY:0 toX:2 toY:0 optStack:NO];
                    [self moveFromX:2 fromY:1 toX:1 toY:0 optStack:NO];
                    
                }
                
                if([self getAlTypeBoard:7 boardy:0] == RED_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:7 fromY:0 toX:7 toY:1 optStack:NO];
                    [self moveFromX:6 fromY:0 toX:7 toY:0 optStack:NO];
                    [self moveFromX:7 fromY:1 toX:6 toY:0 optStack:NO];
                }
                break;
            case 4: //상마마상
                if([self getAlTypeBoard:1 boardy:0] == RED_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:2 fromY:0 toX:2 toY:1 optStack:NO];
                    [self moveFromX:1 fromY:0 toX:2 toY:0 optStack:NO];
                    [self moveFromX:2 fromY:1 toX:1 toY:0 optStack:NO];
                    
                }
                
                if([self getAlTypeBoard:7 boardy:0] == RED_SANG)
                {
                    //nothing to do
                }
                else 
                {
                    //마상 교환
                    [self moveFromX:7 fromY:0 toX:7 toY:1 optStack:NO];
                    [self moveFromX:6 fromY:0 toX:7 toY:0 optStack:NO];
                    [self moveFromX:7 fromY:1 toX:6 toY:0 optStack:NO];
                }
                break;  
        }

    }
}


- (void) undoClick:(id)sender
{
    [self removeMoveBtn];
    [self unselectAlBtn];

    [self undo];

}

//새 대국
- (void) newGame
{
    mGameMode = GAME_MODE_READY;
    [self initAlData];
    
    while ((UIHistory *)[mHistoryStack pop] != nil)
    {
    };
    
    
    for (int i=0; i<32; i++)
    {
        [self moveAlBtnNoStackXY:[btnArray objectAtIndex:i] withX:aldata[i].board_idx_x withY:aldata[i].board_idx_y];
    }
}


#pragma mark - IPHONE / IPAD UI size
- (int) getAlSizeX
{
    int res;
    if(gDevice == IPHONE)
    {
        res = AL_SIZE_X_IPHONE;
    }
    else if (gDevice == IPAD)
    {
        res = AL_SIZE_X_IPAD;
    }
    return res;
}

- (int) getAlSizeY
{
    int res;
    if(gDevice == IPHONE)
    {
        res = AL_SIZE_Y_IPHONE;
    }
    else if (gDevice == IPAD)
    {
        res = AL_SIZE_Y_IPAD;
    }
    return res;
}

- (int) getAlStepX
{
    int res;
    if(gDevice == IPHONE)
    {
        res = AL_X_STEP_IPHONE;
    }
    else if (gDevice == IPAD)
    {
        res = AL_X_STEP_IPAD;
    }
    return res;
}

- (int) getAlStepY
{
    int res;
    if(gDevice == IPHONE)
    {
        res = AL_Y_STEP_IPHONE;
    }
    else if (gDevice == IPAD)
    {
        res = AL_Y_STEP_IPAD;
    }
    return res;
}

- (int) getAlFirstX
{
    int res;
    if(gDevice == IPHONE)
    {
        res = AL_FIRSTX_IPHONE;
    }
    else if (gDevice == IPAD)
    {
        res = AL_FIRSTX_IPAD;
    }
    return res;
}

- (int) getAlFirstY
{
    int res;
    if(gDevice == IPHONE)
    {
        res = AL_FIRSTY_IPHONE;
    }
    else if (gDevice == IPAD)
    {
        res = AL_FIRSTY_IPAD;
    }
    return res;
}

- (int) getAlGreenInvY
{
    int res;
    if(gDevice == IPHONE)
    {
        res = IPHONE_GREEN_INVENTORY_Y;
    }
    else if (gDevice == IPAD)
    {
        res = IPAD_GREEN_INVENTORY_Y;
    }
    return res;
}

- (int) getAlRedInvY
{
    int res;
    if(gDevice == IPHONE)
    {
        res = IPHONE_RED_INVENTORY_Y;
    }
    else if (gDevice == IPAD)
    {
        res = IPAD_RED_INVENTORY_Y;
    }
    return res;
}

- (int) getDeviceWidth
{
    int res;
    if(gDevice == IPHONE)
    {
        res = IPHONE_WIDTH;
    }
    else if (gDevice == IPAD)
    {
        res = IPAD_WIDTH;
    }
    return res;
}

- (int) getDeviceHeight
{
    int res;
    if(gDevice == IPHONE)
    {
        res = IPHONE_HEIGHT;
    }
    else if (gDevice == IPAD)
    {
        res = IPAD_HEIGHT;
    }
    return res;
}

#pragma mark - AI


#pragma mark - UIBarButtonItem selector


#ifdef FREE_APP
#pragma mark iAD Delegate

#pragma mark - CaulyAD

- (void)AddCaulyAD {
    
    float yPos = (self.view.frame.size.height - 48);
    
    if( [CaulyViewController moveBannerAD:self caulyParentview:nil xPos:0 yPos:yPos] == FALSE ) {
        NSLog(@"requestBannerAD failed");
    }
}
#endif


@end

#pragma mark - UI History Stack implementation

@implementation UIHistory

@synthesize move_btn_index, move_from_x, move_from_y, dead_from_x, dead_from_y, dead_btn_index;


@end

@implementation UIHistoryStack

- (id)init {
    if (self = [super init]) {
        contents = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [contents release];
    [super dealloc];
}

// Stack methods

- (void)push:(id)object {
    [contents addObject:object];
}

- (id)pop {
    NSUInteger count = [contents count];
    if (count > 0) {
        id returnObject = [[contents objectAtIndex:count - 1] retain];
        [contents removeLastObject];
        return [returnObject autorelease];
    }
    else {
        return nil;
    }
}

@end
