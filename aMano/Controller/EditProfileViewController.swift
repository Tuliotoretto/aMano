//
//  EditProfileViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 16/01/23.
//

import UIKit
import PhotosUI

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    private var imageName: String?
    private var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // open keyboard
        nameTextField.becomeFirstResponder()
        
        // set up UIImageView
        profileImage.roundedImage()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        profileImage.addGestureRecognizer(tapGR)
        profileImage.isUserInteractionEnabled = true
        
        // load image from storage
        if let imageUrl = AuthManager.shared.userImageURL {
            StorageManager.shared.downloadImage(url: imageUrl) { image in
                self.profileImage.image = image
            }
        }
        
        // load name from auth storage
        if let userName = AuthManager.shared.currentUser?.displayName {
            nameTextField.text = userName
        }
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            // TODO show error
            return
        }
        
        if let photoName = self.imageName, let photoData = self.imageData {
            StorageManager.shared.uploadImage(name: photoName, data: photoData) {[weak self] imageURL in
                AuthManager.shared.setUser(name: name, photoURL: imageURL) {[weak self] err in
                    if err != nil {
                        // TODO SHOW ERROR
                        return
                    }
                    
                    self?.imageName = nil
                    self?.imageData = nil
                    
                    self?.performSegue(withIdentifier: K.segues.toMenuSegue, sender: self!)
                    
                }
            }
        } else {
            AuthManager.shared.setUser(name: name, photoURL: nil) {[weak self] err in
                if err != nil {
                    // TODO SHOW ERROR
                    return
                }
                self?.performSegue(withIdentifier: K.segues.toMenuSegue, sender: self!)
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

// MARK: - UIImagePicker Controller Delegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let name = (info[.imageURL] as? URL)?.lastPathComponent else {return}
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageData = image.jpegData(compressionQuality: 0.20) else {return}
        
        self.imageName = name
        self.imageData = imageData
        profileImage.image = UIImage(data: imageData)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
