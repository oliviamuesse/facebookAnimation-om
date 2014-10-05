//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    var isPresenting: Bool = true
    var imageViewToSegue: UIImageView!
    //var copyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = feedImageView.image!.size
        scrollView.alpha = 0
        loadingSpinner.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Animation: loading spinner, view fades in
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadingSpinner.startAnimating()
        delay (1.5) {
            self.loadingSpinner.stopAnimating()
            self.loadingSpinner.alpha = 0
            UIView.animateWithDuration(0.3, animations: {
                self.scrollView.alpha = 1
            })
        }
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //Segue: tap image, see detail
    
    override func prepareForSegue(weddingSegue: (UIStoryboardSegue!), sender: AnyObject!) {
        var destinationViewController = weddingSegue.destinationViewController as PhotoViewController
        destinationViewController.image = self.imageViewToSegue.image
        println("identifier\(weddingSegue.identifier)")
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
    }
    
    @IBAction func onTapImage(gestureRecognizer: UITapGestureRecognizer) {
        imageViewToSegue = gestureRecognizer.view as UIImageView!
        performSegueWithIdentifier("weddingSegue", sender: nil)
        
    }
    
    //Animation: Custom segue
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            var copyImageView = UIImageView()
            copyImageView.frame.origin = view.convertPoint(imageViewToSegue.frame.origin, fromView: scrollView)
            copyImageView.frame.size = imageViewToSegue.frame.size
            copyImageView.image = imageViewToSegue.image
            copyImageView.contentMode = UIViewContentMode.ScaleAspectFill
            copyImageView.clipsToBounds = true
            copyImageView.userInteractionEnabled = true
            var window = UIApplication.sharedApplication().keyWindow
            window.addSubview(copyImageView)
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    copyImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
            
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                fromViewController.view.alpha = 0
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    
}
