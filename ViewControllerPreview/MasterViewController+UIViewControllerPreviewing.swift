/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Demonstrates the implementation of the previewing delegate's "Peek" and "Pop" callbacks.
*/

import UIKit

extension MasterViewController: UIViewControllerPreviewingDelegate {
    // MARK: UIViewControllerPreviewingDelegate
    
    /// Create a previewing view controller to be shown at "Peek".
    //创建预览视图控制器显示在"peek"。
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Obtain the index path and the cell that was pressed.
        //获取索引路径和的单元格，按下的键。
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
                  cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a detail view controller and set its properties.
        //创建详细视图控制器并设置其属性。
        //guard ??? http://swift.gg/2015/08/06/swift-guard-better-than-if/
        //http://swift.gg/2016/02/14/swift-guard-radix/
        guard let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController else { return nil }

        let previewDetail = sampleData[indexPath.row]
        detailViewController.detailItemTitle = previewDetail.title
        
        /*
            Set the height of the preview by setting the preferred content size of the detail view controller.
            Width should be zero, because it's not used in portrait.
            通过设置详细视图控制器的首选内容大小设置预览的高度。
            宽度应为零，因为它不用在肖像。
        */
        detailViewController.preferredContentSize = CGSize(width: 0.0, height: previewDetail.preferredHeight)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        //设置源矩形为单元格框架，所以周围的元素变得模糊。
        previewingContext.sourceRect = cell.frame
        
        return detailViewController
    }
    
    /// Present the view controller for the "Pop" action.
    //当前视图控制器"pop"的行动。
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
        //重用"peek"视图控制器的演示文稿。
        showViewController(viewControllerToCommit, sender: self)
    }
}