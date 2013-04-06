//
//  ViewController.m
//  TB_3DPlanes
//
//  Created by Yari Dareglia on 3/6/13.
//  Copyright (c) 2013 Yari Dareglia. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define degToRad(x) (M_PI * x / 180.0)

@interface ViewController (){
    CATransformLayer *transformLayer;
    
    float XPanOffset;
    float angle;
    
}
@end
 

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize the TransformLayer
    transformLayer = [CATransformLayer layer];
    transformLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:transformLayer];
    
    angle = 0;
    XPanOffset = 0;
    
    //Create 5 planes
    [self addPlane];
    [self addPlane];
    [self addPlane];
    [self addPlane];
    [self addPlane];
    
    //Force the first animation to set the planes in place
    [self animate];
    
    //Initialize the Pan gesture recognizer
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];
    
}


/** This function performs the transformation on each plane **/
-(void)animate{
    
    //Define the degrees needed for each plane to create a circle
    float degForPlane = 360 / [[transformLayer sublayers] count];
    
    //The current angle offset (initially it is 0... it will change through the pan function)
    float degX = angle;
    
    
    for (CALayer *layer in [transformLayer sublayers]) {
        //Create the Matrix identity
        CATransform3D t = CATransform3DIdentity;
        //Setup the perspective modifying the matrix elementat [3][4]
        t.m34 = 1.0f / - 1000.0f;
        
        //Perform rotate on the matrix identity
        t = CATransform3DRotate(t, degToRad(degX), 0.0f, 1.0f, 0.0f);
        
        //Perform translate on the current transform matrix (identity + rotate)
        t = CATransform3DTranslate(t, 0.0f, 0.0f,  250.0f);
        
        //Avoid animations
        [CATransaction setAnimationDuration:0.0];
        
        //apply the transoform on the current layer
        layer.transform = t;
        
        //Add the degree needed for the next plane
        degX += degForPlane;
    }
}


-(void)pan:(UIPanGestureRecognizer*)gesture{
    
    //Get the current translation on the X
    float xOffset = [gesture translationInView:self.view].x;
    
    //When gesture begin, reset the offset
    if(gesture.state == UIGestureRecognizerStateBegan){
        XPanOffset = 0;
    }
    
    //the distance covered since the last gesture event (I slow down a bit the final rotation multiplying by 0.5)
    float movedBy = xOffset * 0.5 - XPanOffset;
    
    //Calculate the offset from the previous gesture event
    XPanOffset += movedBy;
    
    //Add the offset to the current angle
    angle += movedBy;
    
    //Update the plane
    [self animate];
    
}


/** A simple function to create a CAGradientLayer **/
-(void)addPlane{
    
    CGSize planeSize = CGSizeMake(250, 150);
    
    //Initialize the layer
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    //Set the frame and the anchorPoint
    layer.frame = CGRectMake(480/2 - planeSize.width/2, 320/2 - planeSize.height/2 -20, planeSize.width, planeSize.height);
    layer.anchorPoint = CGPointMake(0.5, 0.5);

    //Set borders and cornerRadius
    layer.borderColor = [[UIColor colorWithWhite:1.0 alpha:0.3]CGColor];
    layer.cornerRadius = 10;
    layer.borderWidth = 4;
    
    //Set the gradient color for the plane background
    layer.colors = [NSArray arrayWithObjects:
                    (id)[UIColor purpleColor].CGColor,
                    (id)[UIColor redColor].CGColor,
                    nil];
    layer.locations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0.0f],
                       [NSNumber numberWithFloat:1.0f],
                       nil];
        
    //Set the shadow
    layer.shadowColor = [[UIColor blackColor]CGColor];
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20;
    
    //The double side has to be setted if we want to see the plane when its face is turned back
    layer.doubleSided = YES;
    
    //Add the plane to the transformLayer
    [transformLayer addSublayer:layer];
}



@end

