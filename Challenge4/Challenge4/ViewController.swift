//
//  ViewController.swift
//  Challenge4
//
//  Created by Daniel Ziper on 7/14/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "pictures") as? Data{
            let decoder = JSONDecoder()
            do {
                pictures = try decoder.decode([Picture].self, from: data)
            }catch{
                print("failed to load pictures")
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pic = pictures[indexPath.row]
        if let detail = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detail.selectedImage = pic.image
            detail.title = pic.name
            
            navigationController?.pushViewController(detail, animated: true)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let pic = pictures[indexPath.row]
        cell.textLabel?.text = pic.name
        
        let path = getDocumentsDirectory().appendingPathComponent(pic.image)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    @objc func addPicture(_ sender: UIAlertAction){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        var picture = Picture(name: "Unknown", image: imageName)
        
        let ac = UIAlertController(title: "Add a caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Confirm", style: .default){
            [weak self, weak ac] _ in
            guard let name = ac?.textFields?[0].text else { return }
            picture.name = name
            self?.pictures.append(picture)
            self?.save()
            self?.tableView.reloadData()
        })
        dismiss(animated: true, completion: nil)
        present(ac, animated: true)
        
    }
    
    func save(){
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        if let data = try? jsonEncoder.encode(pictures){
            defaults.set(data, forKey: "pictures")
        }
        //save to user defaults with json and codable stuff
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }


}

