//
//  NewsListViewController.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 12.11.2023.
//

import UIKit

class NewsListViewController: UITableViewController {
    
    var newsArray: [NewsItem] = [
        NewsItem(title: Samples.Sample1.title, text: Samples.Sample1.text, imageName: Samples.Sample1.imageName),
        NewsItem(title: Samples.Sample2.title, text: Samples.Sample2.text, imageName: Samples.Sample2.imageName)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = true
        tableView.register(UINib(nibName: K.Identifiers.newsItemInListCellNibName, bundle: nil), forCellReuseIdentifier: K.Identifiers.newsItemCell)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.newsItemCell, for: indexPath) as! NewsItemInListCell
        cell.newsItemTitle.text = newsArray[indexPath.row].title
//        cell.newsItemImage.image = UIImage(named: newsArray[indexPath.row].imageName)
        cell.setImage(image: UIImage(named: newsArray[indexPath.row].imageName)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Identifiers.goToNewsItem, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Identifiers.goToNewsItem {
            let destinationVC = segue.destination as! NewsItemViewController
            destinationVC.newsTitle = newsArray[tableView.indexPathForSelectedRow!.row].title
            destinationVC.newsImageName = newsArray[tableView.indexPathForSelectedRow!.row].imageName
            destinationVC.newsText = newsArray[tableView.indexPathForSelectedRow!.row].text
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
