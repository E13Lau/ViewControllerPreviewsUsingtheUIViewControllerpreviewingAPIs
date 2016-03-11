/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The master view controller.
*/

import UIKit

class MasterViewController: UITableViewController {
    // MARK: Types 
    
    /// A simple data structure to populate the table view.
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    
    // MARK: Properties
    
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]

    /// An alert controller used to notify the user if 3D touch is not available.
    var alertController: UIAlertController?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for force touch feature, and add force touch/previewing capability.
        //检查力触摸功能，并添加力触摸/预览能力。
        if traitCollection.forceTouchCapability == .Available {
            /*  
                Register for `UIViewControllerPreviewingDelegate` to enable
                "Peek" and "Pop".
                (see: MasterViewController+UIViewControllerPreviewing.swift)
                注册

                The view controller will be automatically unregistered when it is
                deallocated.
                当它被释放时，视图控制器将自动注销。
            
            */
            registerForPreviewingWithDelegate(self, sourceView: view)
        }
        else {
            // Create an alert to display to the user.
            alertController = UIAlertController(title: "3D Touch Not Available", message: "Unsupported device.", preferredStyle: .Alert)
        }
    }

    override func viewWillAppear(animated: Bool) {
        // Clear the selection if the split view is only showing one view controller.
        //清除所选内容，如果拆分视图只显示一个视图控制器。
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present the alert if necessary.
        //??????? let ＝ var ???
        if let alertController = alertController {
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            
            // Clear the `alertController` to ensure it's not presented multiple times.
            self.alertController = nil
        }
    }
    
    // MARK: UIStoryboardSegue Handling
    //as!     ????????????????
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail", let indexPath = tableView.indexPathForSelectedRow {
            let previewDetail = sampleData[indexPath.row]
            
            let detailViewController = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            
            // Pass the `title` to the `detailViewController`.
            detailViewController.detailItemTitle = previewDetail.title
        }
    }

}

