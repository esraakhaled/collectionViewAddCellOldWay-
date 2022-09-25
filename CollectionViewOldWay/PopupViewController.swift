//
//  PopupViewController.swift
//  CollectionViewOldWay
//
//  Created by Esraa Khaled   on 22/08/2022.
//

import UIKit
import Combine
protocol AddMusic{
    func addMusic(music: Model)
}
class PopupViewController: UIViewController {
    var delegate: AddMusic?
    @IBOutlet weak var imageAdded: UIImageView!
    
    @IBOutlet weak var SongText: UITextField!
    
    var cancellable: AnyCancellable?
    @IBAction func addTapped(_ sender: Any) {
        guard let comment = SongText.text , SongText.hasText else{
            print("handle error here")
            return
        }
        let image = imageAdded.image!
        
        let music = Model(musicImage: image, musicText: comment, color:view.backgroundColor!)
        
        delegate?.addMusic(music: music)
        print(music.musicText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func imageChoose(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    @IBAction func colorChooser(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.view.backgroundColor!
        
        //  Subscribing selectedColor property changes.
        self.cancellable = picker.publisher(for: \.selectedColor)
            .sink { color in
                
                //  Changing view color on main thread.
                DispatchQueue.main.async {
                    self.view.backgroundColor = color
                }
            }
        
        self.present(picker, animated: true, completion: nil)
        
    }
}
extension PopupViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageAdded.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension PopupViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.view.backgroundColor = viewController.selectedColor
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.view.backgroundColor = viewController.selectedColor
    }
    
}
