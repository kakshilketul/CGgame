//
//  CGViewController.h
//  CGgame
//
//  Created by Ketul Shah on 03/04/13.
//  Copyright (c) 2013 Ketul Shah. All rights reserved.
//
#import "iCarousel.h"
#import <UIKit/UIKit.h>

@interface CGViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) IBOutlet iCarousel *carousel1;
@property (nonatomic, retain) IBOutlet iCarousel *carousel2;

@end
