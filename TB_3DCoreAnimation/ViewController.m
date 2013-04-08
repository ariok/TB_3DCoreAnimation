//
//  ViewController.m
//  TB_3DIntro
//
//  Created by Yari Dareglia on 3/7/13.
//  Copyright (c) 2013 Yari Dareglia. All rights reserved.
//

#import "ViewController.h"
#define degToRad(x) (x * M_PI / 180.0f)

@interface ViewController (){
    //Get inverted screen size
    CGSize screenSize;
    float screenWidth;
    float screenHeigth;
}
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    screenWidth = screenSize.height;
    screenHeigth = screenSize.width-20;
    
    /* Remove comments from the next rows to be able to follow the tutorial */
    [self A_singlePlane];
    //[self B_singlePlanePerspective];
    //[self C_transformationsChain];
    //[self D_multiplePlanes];
    //[self E_multiplePlanesZAxis];
    //[self F_multiplePlanesZAxis];
    
}

/**
 1. Create a container with a CALayer
 2. Create a plane
 3. Apply a rotation matrix to the plane modifying the matrix perspective
 
 The plane is rotated but it is reppresented in a 2d orthogonal environment
 **/
- (void)A_singlePlane{
    
    //Create the container
    CALayer *container = [CALayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
    //Create a Plane
    CALayer *purplePlane = [self addPlaneToLayer:container
                                            size:CGSizeMake(100, 100)
                                        position:CGPointMake(250, 150)
                                           color:[UIColor purpleColor]];
    
    //Apply transform to the PLANE
    CATransform3D t = CATransform3DIdentity;
    t = CATransform3DRotate(t, 45.0f * M_PI / 180.0f, 0, 1, 0);
    purplePlane.transform = t;
}

/**
 1. Create a container with a CALayer
 2. Create a plane
 3. Apply a rotation matrix to the plane modifying the matrix perspective
 
 The plane is rotated and it is showed with a depth perspective
 **/
- (void)B_singlePlanePerspective{
    
    //Create the container
    CALayer *container = [CALayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
    //Create a Plane
    CALayer *purplePlane = [self addPlaneToLayer:container
                                            size:CGSizeMake(100, 100)
                                        position:CGPointMake(250, 150)
                                           color:[UIColor purpleColor]];
    
    //Apply transform to the PLANE
    CATransform3D t = CATransform3DIdentity;
    //Add perspective!!!
    t.m34 = 1.0/ -100;
    //t.m34 = 1.0/ -500;
    t = CATransform3DRotate(t, degToRad(45.0), 0, 1, 0);
    purplePlane.transform = t;
}

/**
 1. Create a container with a CALayer
 2. Create 2 planes
 3. Apply transformations in different order to the 2 planes
 
 The plane is rotated and it is showed with a depth perspective
 **/
- (void)C_transformationsChain{
    
    
    //Create the container
    CALayer *container = [CALayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
    //Draw X/Y axis
    [self createAxisForContainer:container];
    
    
    //Create a Plane
    CALayer *purplePlane = [self addPlaneToLayer:container
                                            size:CGSizeMake(100, 100)
                                        position:CGPointMake(screenWidth/2, screenHeigth/2)
                                           color:[UIColor purpleColor]];
    
    //Create a Plane
    CALayer *redPlane = [self addPlaneToLayer:container
                                         size:CGSizeMake(100, 100)
                                     position:CGPointMake(screenWidth/2, screenHeigth/2)
                                        color:[UIColor redColor]];
    
    //Apply transform to the PLANES
    CATransform3D t = CATransform3DIdentity;
    
    //Purple plane: Perform a rotation and then a translation
    t = CATransform3DRotate(t, degToRad(45.0), 0, 0, 1);
    t = CATransform3DTranslate(t, 100, 0, 0);
    purplePlane.transform = t;
    
    //reset the transform matrix
    t = CATransform3DIdentity;
    
    
    //Red plane: Perform translation first and then the rotation
    t = CATransform3DTranslate(t, 100, 0, 0);
    t = CATransform3DRotate(t, degToRad(45.0), 0, 0, 1);
    redPlane.transform = t;
}


/**
 1. Create a container with a CALayer
 2. Create four planes
 3. Apply a rotation matrix to container or to each plane
 
 Apply the rotation to the container you see its sublayer rotated too.
 **/
-(void)D_multiplePlanes{
    //Create the container
    CALayer *container = [CALayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
    //Planes data
    CGSize planeSize = CGSizeMake(100, 100);
    
    //Create 4 Planes
    CALayer *purplePlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:CGPointMake(100, 150)
                                           color:[UIColor purpleColor]];
    
    CALayer *redPlane = [self addPlaneToLayer:container
                                         size:planeSize
                                     position:CGPointMake(205, 150)
                                        color:[UIColor redColor]];
    
    CALayer *orangePlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:CGPointMake(310, 150)
                                           color:[UIColor orangeColor]];
    CALayer *yellowPlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:CGPointMake(415, 150)
                                           color:[UIColor yellowColor]];
    
    
    //Transformation
    CATransform3D t = CATransform3DIdentity;
    
    BOOL applyToContainer = NO;
    
    //Apply the transformation to each PLANE
    if(!applyToContainer){
        t.m34 = 1.0 / -500.0;
        t = CATransform3DRotate(t, degToRad(60.0), 0, 1, 0);
        purplePlane.transform = t;
        
        t = CATransform3DIdentity;
        t.m34 = 1.0 / -500.0;
        t = CATransform3DRotate(t, degToRad(60.0), 0, 1, 0);
        redPlane.transform = t;
        
        t = CATransform3DIdentity;
        t.m34 = 1.0 / -500.0;
        t = CATransform3DRotate(t, degToRad(60.0), 0, 1, 0);
        orangePlane.transform = t;
        
        t = CATransform3DIdentity;
        t.m34 = 1.0 / -500.0;
        t = CATransform3DRotate(t, degToRad(60.0), 0, 1, 0);
        yellowPlane.transform = t;
    }
    
    //Apply the transformation to the CONTAINER
    else{
        CATransform3D t = CATransform3DIdentity;
        t.m34 = 1.0/-500;
        t = CATransform3DRotate(t, degToRad(60.0), 0, 1, 0);
        container.transform = t;
    }
    
}

/**
 1. Create a container with a CALayer
 2. Create four planes
 3. Apply a rotation matrix to container
 4. Apply a Z transform to the planes
 You'll find that the container is flatting the planes on the Z axis
 **/
-(void)E_multiplePlanesZAxis{
    
    //Create the container
    CALayer *container = [CALayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
    //Planes data
    CGPoint planesPosition = CGPointMake(290, 150);
    CGSize planeSize = CGSizeMake(100, 100);
    
    //Create 4 Planes
    CALayer *purplePlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:planesPosition
                                           color:[UIColor purpleColor]];
    
    CALayer *redPlane = [self addPlaneToLayer:container
                                         size:planeSize
                                     position:planesPosition
                                        color:[UIColor redColor]];
    
    CALayer *orangePlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:planesPosition
                                           color:[UIColor orangeColor]];
    
    CALayer *yellowPlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:planesPosition
                                           color:[UIColor yellowColor]];
    
    //Apply transform to the CONTAINER
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/-500;
    t = CATransform3DRotate(t, 80.0f * M_PI / 180.0f, 0, 1, 0);
    container.transform = t;
    
    //Apply transforms to the PLANES
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, 0);
    purplePlane.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -40);
    redPlane.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -80);
    orangePlane.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -120);
    yellowPlane.transform = t;
    
}


/**
 1. Create a container with a CATransformLayer
 2. Create four planes
 3. Apply a rotation matrix to container
 4. Apply a Z transform to the planes
 
 You'll find that the container now is able to display the correct 3D scene.
 In fact the planes are translated over the Z axis
 **/
-(void)F_multiplePlanesZAxis{
    
    //Create the container as a CATransformLayer
    CATransformLayer *container = [CATransformLayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
    //Planes data
    CGPoint planesPosition = CGPointMake(290, 150);
    CGSize planeSize = CGSizeMake(100, 100);
    
    //Create 4 Planes
    CALayer *purplePlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:planesPosition
                                           color:[UIColor purpleColor]];
    
    CALayer *redPlane = [self addPlaneToLayer:container
                                         size:planeSize
                                     position:planesPosition
                                        color:[UIColor redColor]];
    
    CALayer *orangePlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:planesPosition
                                           color:[UIColor orangeColor]];
    
    CALayer *yellowPlane = [self addPlaneToLayer:container
                                            size:planeSize
                                        position:planesPosition
                                           color:[UIColor yellowColor]];
    
    //Apply transform to the CONTAINER
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/-500;
    t = CATransform3DRotate(t, 60.0f * M_PI / 180.0f, 0, 1, 0);
    container.transform = t;
    
    //Apply transforms to the PLANES
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, 0);
    purplePlane.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -40);
    redPlane.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -80);
    orangePlane.transform = t;
    
    t = CATransform3DIdentity;
    t = CATransform3DTranslate(t, 0, 0, -120);
    yellowPlane.transform = t;
    
}

-(void)createAxisForContainer:(CALayer*)container{
    
    
    //Define path
    UIBezierPath *graphPath = [UIBezierPath bezierPath];
    //H line
    [graphPath moveToPoint:CGPointMake(0, (screenHeigth/2))];
    [graphPath addLineToPoint:CGPointMake(480, (screenHeigth/2))];
    //V line
    [graphPath moveToPoint:CGPointMake(screenWidth/2, 0)];
    [graphPath addLineToPoint:CGPointMake(screenWidth/2, screenHeigth)];
    
    [graphPath closePath];
    
    //Define the shape Layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setPath: [graphPath CGPath]];
    [shapeLayer setStrokeColor:[[UIColor colorWithWhite:1.0 alpha:0.8] CGColor]];
    [shapeLayer setMasksToBounds:NO];
    [shapeLayer setLineWidth:2.0];
    
    //Attach the shape layer
    [container addSublayer:shapeLayer];
}



/** Simple function to generate a Layer attached to another layer and return it **/
-(CALayer*)addPlaneToLayer:(CALayer*)container size:(CGSize)size position:(CGPoint)point color:(UIColor*)color{
    //Initialize the layer
    CALayer *plane = [CALayer layer];
    //Define position,size and colors
    plane.backgroundColor = [color CGColor];
    plane.opacity = 0.6;
    plane.frame = CGRectMake(0, 0, size.width, size.height);
    plane.position = point;
    plane.anchorPoint = CGPointMake(0.5, 0.5);
    plane.borderColor = [[UIColor colorWithWhite:1.0 alpha:0.5]CGColor];
    plane.borderWidth = 3;
    plane.cornerRadius = 10;
    //Add the layer to the container layer
    [container addSublayer:plane];
    
    return plane;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
