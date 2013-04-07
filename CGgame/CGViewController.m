//
//  iCarouselExampleViewController.m
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import "CGViewController.h"
#import "UIView+Genie.h"
#import "MainViewController.h"


@interface CGViewController ()
{
    int a ,b;
    bool x,y;
}
@property (nonatomic,strong) NSArray *ClubNames;


@end


@implementation CGViewController

@synthesize carousel1;
@synthesize carousel2;
@synthesize ClubNames;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
     [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //configure carousel
    carousel1.type = iCarouselTypeCoverFlow2;
    carousel2.type = iCarouselTypeCoverFlow2;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    a = 100;
    b = 100;
    x = false;
    y = false;
    ClubNames = [NSArray arrayWithObjects:@"FCB",@"Madrid",@"Bayern",@"ManU",@"Chelsea",@"Arsenal",@"Everton",@"ManCity",@"Liverpool",@"ACM", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel1 = nil;
    self.carousel2 = nil;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 11;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220.0f, 220.0f)] ;
        ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png",index]];
        view.contentMode = UIViewContentModeCenter;

    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionSpacing:
        {
            if (carousel == carousel2)
            {
                //add a bit of spacing between the item views
                return value * 1.05f;
            }
        }
        default:
        {
            return value;
        }
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (carousel == carousel1)
    {
        CGRect endRect = CGRectMake(160, -10, 0, 1);
        [carousel1 genieInTransitionWithDuration:0.7
                        destinationRect:endRect
                        destinationEdge:BCRectEdgeBottom
                             completion:^{
                                 a = index;
                                 x = true;
                                 if (y == true) {
                                     [self performSegueWithIdentifier:@"MainSegue" sender:nil];
                                 }
                             }];
                        [carousel1 removeFromSuperview];

    }
    else
    {
        CGRect endRectTwo = CGRectMake(160, self.view.bounds.size.height+10, 0, 50);
        [carousel2 genieInTransitionWithDuration:0.7
                        destinationRect:endRectTwo
                        destinationEdge:BCRectEdgeTop
                             completion:^{
                                 b = index;
                                 y = true;
                                 if (x==true) {
                                     [self performSegueWithIdentifier:@"MainSegue" sender:nil];

                                 }

                             }];
        [carousel2 removeFromSuperview];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainSegue"] ) {
        MainViewController *m = segue.destinationViewController;
        m.Club1 = [ClubNames objectAtIndex:a];
        m.Club2 = [ClubNames objectAtIndex:b];
        
    }
}

@end
