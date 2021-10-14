//
//  TableViewController.swift
//  lmwn-assignment
//
//  Created by ggolfz on 14/10/2564 BE.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tableViewElements = [PhotoData]()
    var photoManager = PhotoManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        photoManager.delegate = self
        // Do any additional setup after loading the view.
        let nib: UINib = UINib(nibName: "PhotoTile", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        photoManager.fetchPhotoData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        photoManager.fetchPhotoData()
        sender.endRefreshing()
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewElements.count
    }
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PhotoTile
        let element = tableViewElements[indexPath.row];
        cell.descriptionText.text = element.imageDescription
        cell.titleText.text = element.imageName
        cell.likeAmount.text = element.likeString
        let url = URL(string: element.imageURL)
        let data = try? Data(contentsOf: url!)
        cell.photoView.image = UIImage(data: data!)
        return cell
    }
}

extension TableViewController: PhotoManagerDelegate {
    func updatePhotoData(_ photoManager: PhotoManager, photoList: PhotoList) {
        DispatchQueue.main.async {
            self.tableViewElements = photoList.lists
            self.tableView.reloadData()
        }
    }
}
