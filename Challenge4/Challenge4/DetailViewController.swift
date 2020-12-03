//
//  DetailViewController.swift
//  Challenge4
//
//  Created by Daniel Ziper on 7/14/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(selectedImage).path)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
