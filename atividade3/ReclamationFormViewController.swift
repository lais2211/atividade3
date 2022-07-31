import UIKit

class ReclamationFormViewController: UIViewController {
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textViewInfo: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var reclamation: Reclamation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let reclamation = reclamation{
            
            title = "Edit"
            textFieldTitle.text = reclamation.title
            textFieldAddress.text = reclamation.address
            textViewInfo.text = reclamation.info
            
            if let image = reclamation.image {
                imageView.image = UIImage(data: image)
            }
        }
    }
    


    @IBAction func uploadPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "Select Photo", message: "Choose a image", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        
        let albumAction = UIAlertAction(title: "Photos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(libraryAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if reclamation == nil {
            reclamation = Reclamation(context: context)
            reclamation?.date = Date.now
        }
        
        reclamation?.title = textFieldTitle.text
        reclamation?.image = imageView.image?.jpegData(compressionQuality: 0.9)
        reclamation?.info = textViewInfo.text
        reclamation?.address = textFieldAddress.text
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
        
    }
    
}


extension ReclamationFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
