//
//  ViewController.swift
//  homework_multithread
//
//  Created by Pham An on 5/24/17.
//  Copyright © 2017 Pham An. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDownloadDelegate {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var sld: UISlider!
    @IBOutlet weak var progress: UIProgressView!
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        sld.minimumValue = 0
        sld.maximumValue = 100
        progress.progress = 0
    }
	
    @IBAction func click(_ sender: Any) {
        let url = URL(string: "https://images7.alphacoders.com/671/671281.jpg")!
        downloadTask = backgroundSession.downloadTask(with: url)
        downloadTask.resume()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            print("download task did finish")
            do
            {
                let d = try Data(contentsOf: location)
                let i = UIImage(data: d)
               // DispatchQueue.main.async {
                    self.img.contentMode = .scaleAspectFit
                    self.img.clipsToBounds = true
                    self.img.image = i
              // }
            }  catch{
              print("Error info: \(error)")
            }
       }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let vl:Float = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)*100
        print(vl)
        self.sld.value = vl
        self.progress.progress = vl/100
    }


}

