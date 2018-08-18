//
//  ViewController.swift
//  SwiftTest
//
//  Created by Ranjan on 25/12/17.
//  Copyright © 2017 Ranjan. All rights reserved.
//

import UIKit

let productKey = "ABC"
let urlString = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=d84bea1f0a9d42378053ccd767456b83"

//key in Json
let mainHeadingKey = "title"
let subHeadingKey = "abstract"
let authorKey  = "byline"
let publishDateKey = "published_date"

class NyViewCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var roundRect: UIView!
    @IBOutlet weak var calendarImg: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    func setUpCell(_ newsObject:NewsModal)
    {
        self.mainLabel?.text = newsObject.mainHeadline
        self.subLabel.text = newsObject.subHeadline
        self.authorLabel.text = newsObject.author
        self.dateLabel.text = newsObject.date
        self.roundRect.layer.cornerRadius =
        self.roundRect.frame.height/2.0
        self.roundRect.backgroundColor = UIColor.lightGray

    }
    
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listView: UITableView!
    var newsCollection = [NewsModal]()
    
    // create and initialize URLSession with a default session configuration
    var defaultSession: DHURLSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        
        // Set Center
        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: urlString)
        // from the session you created, you initialize a URLSessionDataTask to handle the HTTP GET request.
        // the constructor of URLSessionDataTask takes in the URL that you constructed along with a completion handler to be called when the data task completed
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicatorView.startAnimating()
        dataTask = defaultSession.dataTask(with: url!) {
            data, response, error in
            // invoke the UI update in the main thread and hide the activity indicator to show that the task is completed
            DispatchQueue.main.async {
                // stop animator UI update code
                self.activityIndicatorView.stopAnimating()
            }
            // if HTTP request is successful you call updateSearchResults(_:) which parses the response NSData into Tracks and updates the table view
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.updateNewsData(data)
                }
            }
        }
        
        // all tasks start in a suspended state by default, calling resume() starts the data task
        dataTask?.resume()

        
    }
    
    
    func updateNewsData(_ data: Data?)
    {
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                
                // Get the results array
                if let array: AnyObject = response["results"] {
                     for dic in array as! [AnyObject] {
                    //for dic in array {
                        
                        let newDic = dic as! Dictionary<String, AnyObject>
                        let news = NewsModal.init(mainHeadline: newDic[mainHeadingKey] as? String,subHeadline: newDic[subHeadingKey] as? String, author: newDic[authorKey] as? String, date: newDic[publishDateKey] as? String)
                        
                        self.newsCollection.append(news)
                        
                        
                    //}
                    }
                    
                } else {
                    print("Results key not found in dictionary")
                }
            } else {
                print("JSON Error")
            }
        }catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
        }
        
        
        DispatchQueue.main.async {
            self.listView.reloadData()
            self.listView.setContentOffset(CGPoint.zero, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYCellDemo", for: indexPath as IndexPath) as! NyViewCell
        
        let newsObject = newsCollection[indexPath.row]
        cell.setUpCell(newsObject)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsCollection.count
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailNewsViewController
        next.selectedName = newsCollection[indexPath.row]
        self.present(next, animated: true, completion: nil)
    }
    

    
}

