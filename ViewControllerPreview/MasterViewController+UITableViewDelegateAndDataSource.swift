//
//  MasterViewController+UITableViewDelegateAndDataSource.swift
//  ViewControllerPreview
//
//  Created by 刘一智 on 16/3/11.
//  Copyright © 2016年 Apple Inc. All rights reserved.
//

import UIKit

extension MasterViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        return sampleData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let previewDetail = sampleData[indexPath.row]
        cell.textLabel!.text = previewDetail.title
        
        return cell
    }

}
