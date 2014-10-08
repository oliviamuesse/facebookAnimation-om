//
//  PhotoViewController.swift
//  facebookAnimation-om
//
//  Created by Olivia Muesse on 10/4/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
  
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionsView: UIImageView!
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        imageView.image = image
        println(imageView.image)
    }

    @IBAction func onDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        // Do fading out of done and action buttons here

    func scrollViewDidScroll(scrollview: UIScrollView!) {
            var offset = abs(Float(scrollView.contentOffset.y))
            var alphaOffset = 1 - CGFloat(offset/70)
            self.view.backgroundColor = UIColor(white: 0, alpha: alphaOffset)
            doneButton.alpha = CGFloat(alphaOffset)
            actionsView.alpha = CGFloat(alphaOffset)
    
            }
    
        func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            var offset = abs(Float(scrollView.contentOffset.y))
            println(offset)
    
    
            if (offset > 80) {
                dismissViewControllerAnimated(true, completion: nil)
            // Do fading out of done and action buttons here
        }
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
