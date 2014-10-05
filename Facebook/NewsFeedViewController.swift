//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController
//, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
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
    
    @IBAction func onTapImage(gestureRecognizer: UITapGestureRecognizer) {
        imageViewToSegue = gestureRecognizer.view as UIImageView!
        performSegueWithIdentifier("weddingSegue", sender: self)
        
    }
    
    override func prepareForSegue(weddingSegue: (UIStoryboardSegue!), sender: AnyObject!) {
        var destinationViewController = weddingSegue.destinationViewController as PhotoViewController
        destinationViewController.view = imageViewToSegue
        destinationViewController.image = self.imageViewToSegue.image
        
    }
    
    

    
}
