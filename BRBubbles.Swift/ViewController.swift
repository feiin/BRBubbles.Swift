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
    
    fileprivate var imagesArray:[UIImageView]?
    
    fileprivate var imageNameArray:[String]?
    
    fileprivate var viewBarrierOuter:UIView?
    
    fileprivate var viewBarrierInner:UIView?
    
    fileprivate var bigSize:CGSize?
    
    fileprivate var smallSize:CGSize?
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.imageNameArray=["icon_one.png","icon_two.png","icon_three.png","icon_four.png","icon_five.png","icon_six.png","icon_eight.png","icon_nine.png","icon_ten.png"]
        
        
        self.bigSize = CGSize(width: 60, height: 60);
        self.smallSize = CGSize(width: 30, height: 30);
        let gutter:CGFloat = 20.0;
        
        self.imagesArray = [UIImageView]()
        
        
        self.scrollView.backgroundColor=UIColor.black
        let width = self.view.frame.size.width*2+(gutter*2)
        let height = self.view.frame.size.height*2+(gutter*3)
        self.scrollView.contentSize=CGSize(width: width, height: height)
        self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentSize.width/2-self.view.frame.size.width/2, y: self.scrollView.contentSize.height/2-self.view.frame.size.height/2)
        
        self.scrollView.delegate = self
        let gap:CGFloat = 5;
        var xValue:CGFloat = gutter
        var yValue:CGFloat = gutter
        var rowNumber = 1
        
        
        for _ in 0 ..< 162
        {
            let imageOne:UIImageView = UIImageView(frame: CGRect(x: xValue, y: yValue, width: 60, height: 60))
            
            
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
        
        
        self.viewBarrierOuter = UIView(frame: CGRect(x: self.view.frame.size.width/8,y: self.view.frame.size.height/8, width: self.view.frame.size.width-self.view.frame.size.width/4, height: self.view.frame.size.height-self.view.frame.size.height/4))
        
        
        self.viewBarrierOuter!.backgroundColor = UIColor.red
        self.viewBarrierOuter!.alpha = 0.3
        self.viewBarrierOuter!.isHidden = true
        
        self.viewBarrierOuter!.isUserInteractionEnabled = false
        self.view.addSubview(self.viewBarrierOuter!)
        
        
        self.viewBarrierInner = UIView(frame: CGRect(x: self.view.frame.size.width/4,y: self.view.frame.size.height/4, width: self.view.frame.size.width-self.view.frame.size.width/2, height: self.view.frame.size.height-self.view.frame.size.height/2))
        
        self.viewBarrierInner!.backgroundColor = UIColor.red
        
        self.viewBarrierInner!.alpha = 0.3;
        self.viewBarrierInner!.isHidden = true;
        self.viewBarrierInner!.isUserInteractionEnabled = false
        self.view.addSubview(self.viewBarrierInner!)
        
        self.initImageScale()
        
    }
    
    func addImageToScrollView(_ image:UIImageView){
        
        image.image=UIImage(named: self.imageNameArray![(Int)(arc4random()%9)])
        image.layer.cornerRadius=12
        image.layer.masksToBounds=true
        image.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        image.contentMode = UIViewContentMode.scaleAspectFill
        self.scrollView.addSubview(image)
        self.imagesArray!.append(image)
        
    }
    
   
   func scrollViewDidScroll(_ scrollView: UIScrollView)
   {
   
    let container = CGRect(x: scrollView.contentOffset.x+(self.viewBarrierOuter!.frame.size.width/8), y: scrollView.contentOffset.y+(self.viewBarrierOuter!.frame.size.height/8), width: self.viewBarrierOuter!.frame.size.width, height: self.viewBarrierOuter!.frame.size.height)
    let containerTwo = CGRect(x: scrollView.contentOffset.x+(self.viewBarrierInner!.frame.size.width/2), y: scrollView.contentOffset.y+(self.viewBarrierInner!.frame.size.height/2), width: self.viewBarrierInner!.frame.size.width, height: self.viewBarrierInner!.frame.size.height)
    
    let fetchQ:DispatchQueue = DispatchQueue(label: "BubbleQueue", attributes: [])
    
    fetchQ.async(execute: {
        
        for imageView in self.imagesArray!
        {
            let thePosition:CGRect =  imageView.frame;
            
            
            
            if(containerTwo.intersects(thePosition))
            {
                if (imageView.tag == notAnimating)
                {
                    imageView.tag = isAnimating;
                    DispatchQueue.main.async(execute: {
                        
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            imageView.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
                            }, completion: {(finished:Bool) in
                                
                                imageView.tag = notAnimating;
                        })
                        
                    })
                }
            }else if(container.intersects(thePosition))
            {
                if (imageView.tag == notAnimating)
                {
                    imageView.tag = isAnimating;
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            imageView.transform = CGAffineTransform(scaleX: 0.7,y: 0.7)
                            }, completion: { (finished:Bool) in
                                
                                imageView.tag = notAnimating;
                        })
                        
                    })
                    
                    
                }
            }else{
                if (imageView.tag == notAnimating)
                {
                    imageView.tag = isAnimating;
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            imageView.transform = CGAffineTransform(scaleX: 0.5,y: 0.5)
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
        
        let container = CGRect(x: scrollView.contentOffset.x+(self.viewBarrierOuter!.frame.size.width/8), y: scrollView.contentOffset.y+(self.viewBarrierOuter!.frame.size.height/8), width: self.viewBarrierOuter!.frame.size.width, height: self.viewBarrierOuter!.frame.size.height)
        let containerTwo = CGRect(x: scrollView.contentOffset.x+(self.viewBarrierInner!.frame.size.width/2), y: scrollView.contentOffset.y+(self.viewBarrierInner!.frame.size.height/2), width: self.viewBarrierInner!.frame.size.width, height: self.viewBarrierInner!.frame.size.height)
        
        for imageView in self.imagesArray!
        {
            let thePosition:CGRect =  imageView.frame;
            if(containerTwo.intersects(thePosition))
            {
                imageView.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
                
            }else if(container.intersects(thePosition))
            {
                imageView.transform = CGAffineTransform(scaleX: 0.7,y: 0.7)
                
            }else{
                
                imageView.transform = CGAffineTransform(scaleX: 0.5,y: 0.5)
                
            }
            
            
        }
        
    }
    
 
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

