//
//  NewsListViewController.swift
//  SavannaABC
//
//  Created by Андрей Семенов on 12.11.2023.
//

import UIKit

class NewsListViewController: UITableViewController {
    
    var newsArray: Array<NewsItem>? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.Identifiers.newsItemInListCellNibName, bundle: nil), forCellReuseIdentifier: K.Identifiers.newsItemCell)
        Task {
            do {
                newsArray = try await loadNews()
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.newsItemCell, for: indexPath) as! NewsItemInListCell
        // setting cell field
        let item = newsArray![indexPath.row]
        cell.newsItemTitle.text = item.title
        if let image = item.image {
            cell.setImage(image: image)
        }
        cell.newsItemText.text = item.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Identifiers.goToNewsItem, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Identifiers.goToNewsItem {
            let destinationVC = segue.destination as! NewsItemViewController
            let item = newsArray![tableView.indexPathForSelectedRow!.row]
            destinationVC.newsTitle = item.title!
            if let image = item.image {
                destinationVC.newsImage = image
            }
            destinationVC.newsText = item.text!
        }
    }
    
    func loadNews() async throws -> [NewsItem]? {
        let url = URL(string: "\(K.Backend.baseUrl)/api/news/all/")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let newsList = await parseJSON(data: data)
        return newsList
    }
    
    func parseJSON(data: Data) async -> Array<NewsItem>? {
        var newsList = [NewsItem]()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let decodedData = try decoder.decode(NewsList.self, from: data)
            for item in decodedData.news {
                var newItem = NewsItem()
                newItem.id = item.id
                newItem.title = item.title
                newItem.text = item.text
                newItem.createdDate = item.createdDate
                newItem.imageURL = URL(string: "\(K.Backend.baseUrl)\(item.image_url)")
                if let imageURL = newItem.imageURL {
                    let loadedImage = ImageLoader(imageUrl: imageURL)
                    newItem.image = try await loadedImage.image
                }
                newsList.append(newItem)
            }
            return newsList
        } catch {
            print("There is an error decoding data: \(String(describing: error))")
            return nil
        }
    }
    
}
