//
//  ViewController.swift
//  BRBubbles.Swift
//
//  Created by feiin on 14-10-15.
//  Copyright (c) 2014年 swiftmi. All rights reserved.
//

import UIKit
import QuartzCore

let notAnimating = 0
let isAnimating = 1

class ViewController: UIViewController,UIScrollViewDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var imagesArray:[UIImageView]?
    
    private var imageNameArray:[String]?
    
    private var viewBarrierOuter:UIView?
    
    private var viewBarrierInner:UIView?
    
    private var bigSize:CGSize?
    
    private var smallSize:CGSize?
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.imageNameArray=["icon_one.png","icon_two.png","icon_three.png","icon_four.png","icon_five.png","icon_six.png","icon_eight.png","icon_nine.png","icon_ten.png"]
        
        
        self.bigSize = CGSizeMake(60, 60);
        self.smallSize = CGSizeMake(30, 30);
        var gutter:CGFloat = 20.0;
        
        self.imagesArray = [UIImageView]()
        
        
        self.scrollView.backgroundColor=UIColor.blackColor()
        var width = self.view.frame.size.width*2+(gutter*2)
        var height = self.view.frame.size.height*2+(gutter*3)
        self.scrollView.contentSize=CGSizeMake(width, height)
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width/2-self.view.frame.size.width/2, self.scrollView.contentSize.height/2-self.view.frame.size.height/2)
        
        self.scrollView.delegate = self
        var gap:CGFloat = 5;
        var xValue:CGFloat = gutter
        var yValue:CGFloat = gutter
        var rowNumber = 1
        
        
        for (var zz:Int = 0; zz < 162; zz++)
        {
            var imageOne:UIImageView = UIImageView(frame: CGRectMake(xValue, yValue, 60, 60))
            
            
            self.addImageToScrollView(imageOne)
            
            xValue += (60+gap+gap);
            
            if xValue > (self.scrollView.contentSize.width-(gutter*3))
            {
                if rowNumber % 2 == 0
                {
                    xValue = 30 + gutter;
                }else{
                    xValue = 0 + gutter;
                }
                yValue += (60+gap);
                rowNumber += 1;
            }
        }
        
        
        self.viewBarrierOuter = UIView(frame: CGRectMake(self.view.frame.size.width/8,self.view.frame.size.height/8, self.view.frame.size.width-self.view.frame.size.width/4, self.view.frame.size.height-self.view.frame.size.height/4))
        
        
        self.viewBarrierOuter!.backgroundColor = UIColor.redColor()
        self.viewBarrierOuter!.alpha = 0.3
        self.viewBarrierOuter!.hidden = true
        
        self.viewBarrierOuter!.userInteractionEnabled = false
        self.view.addSubview(self.viewBarrierOuter!)
        
        
        self.viewBarrierInner = UIView(frame: CGRectMake(self.view.frame.size.width/4,self.view.frame.size.height/4, self.view.frame.size.width-self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/2))
        
        self.viewBarrierInner!.backgroundColor = UIColor.redColor()
        
        self.viewBarrierInner!.alpha = 0.3;
        self.viewBarrierInner!.hidden = true;
        self.viewBarrierInner!.userInteractionEnabled = false
        self.view.addSubview(self.viewBarrierInner!)
        
        self.initImageScale()
        
    }
    
    func addImageToScrollView(image:UIImageView){
        
        image.image=UIImage(named: self.imageNameArray![(Int)(arc4random()%9)])
        image.layer.cornerRadius=12
        image.layer.masksToBounds=true
        image.layer.anchorPoint = CGPointMake(0.5, 0.5)
        image.contentMode = UIViewContentMode.ScaleAspectFill
        self.scrollView.addSubview(image)
        self.imagesArray!.append(image)
        
    }
    
   
   func scrollViewDidScroll(scrollView: UIScrollView)
   {
   
    var container = CGRectMake(scrollView.contentOffset.x+(self.viewBarrierOuter!.frame.size.width/8), scrollView.contentOffset.y+(self.viewBarrierOuter!.frame.size.height/8), self.viewBarrierOuter!.frame.size.width, self.viewBarrierOuter!.frame.size.height)
    var containerTwo = CGRectMake(scrollView.contentOffset.x+(self.viewBarrierInner!.frame.size.width/2), scrollView.contentOffset.y+(self.viewBarrierInner!.frame.size.height/2), self.viewBarrierInner!.frame.size.width, self.viewBarrierInner!.frame.size.height)
    
    var fetchQ:dispatch_queue_t = dispatch_queue_create("BubbleQueue", nil)
    
    dispatch_async(fetchQ,{
        
        for imageView in self.imagesArray!
        {
            var thePosition:CGRect =  imageView.frame;
            
            
            
            if(CGRectIntersectsRect(containerTwo, thePosition))
            {
                if (imageView.tag == notAnimating)
                {
                    imageView.tag = isAnimating;
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        UIView.animateWithDuration(0.5, animations: {
                            imageView.transform = CGAffineTransformMakeScale(1.0,1.0)
                            }, completion: {(finished:Bool) in
                                
                                imageView.tag = notAnimating;
                        })
                        
                    })
                }
            }else if(CGRectIntersectsRect(container, thePosition))
            {
                if (imageView.tag == notAnimating)
                {
                    imageView.tag = isAnimating;
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        UIView.animateWithDuration(0.5, animations: {
                            imageView.transform = CGAffineTransformMakeScale(0.7,0.7)
                            }, completion: { (finished:Bool) in
                                
                                imageView.tag = notAnimating;
                        })
                        
                    })
                    
                    
                }
            }else{
                if (imageView.tag == notAnimating)
                {
                    imageView.tag = isAnimating;
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        UIView.animateWithDuration(0.5, animations: {
                            imageView.transform = CGAffineTransformMakeScale(0.5,0.5)
                            }, completion: {(finished:Bool) in
                                
                                imageView.tag = notAnimating;
                        })
                        
                    })
                    
                    
                }
            }
        }
        
    })

    }
    
    
    func initImageScale()
    {
        
        var container = CGRectMake(scrollView.contentOffset.x+(self.viewBarrierOuter!.frame.size.width/8), scrollView.contentOffset.y+(self.viewBarrierOuter!.frame.size.height/8), self.viewBarrierOuter!.frame.size.width, self.viewBarrierOuter!.frame.size.height)
        var containerTwo = CGRectMake(scrollView.contentOffset.x+(self.viewBarrierInner!.frame.size.width/2), scrollView.contentOffset.y+(self.viewBarrierInner!.frame.size.height/2), self.viewBarrierInner!.frame.size.width, self.viewBarrierInner!.frame.size.height)
        
        for imageView in self.imagesArray!
        {
            var thePosition:CGRect =  imageView.frame;
            if(CGRectIntersectsRect(containerTwo, thePosition))
            {
                imageView.transform = CGAffineTransformMakeScale(1.0,1.0)
                
            }else if(CGRectIntersectsRect(container, thePosition))
            {
                imageView.transform = CGAffineTransformMakeScale(0.7,0.7)
                
            }else{
                
                imageView.transform = CGAffineTransformMakeScale(0.5,0.5)
                
            }
            
            
        }
        
    }
    
 
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

