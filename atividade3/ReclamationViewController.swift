import UIKit

class ReclamationViewController: UIViewController {
   
   
    @IBOutlet weak var textLabelTitle: UILabel!
    @IBOutlet weak var textLabelAddress: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldInfo: UITextView!
    var reclamation: Reclamation?
   
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       prepareScreen()
   }

   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let reclamationFormViewController = segue.destination as? ReclamationFormViewController  {
           reclamationFormViewController.reclamation = reclamation
       }
   }
   
   func prepareScreen(){
       if let reclamation = reclamation {
           textLabelTitle.text = reclamation.title
           textLabelAddress.text = reclamation.address
           textFieldInfo.text = reclamation.info
           
           if let image = reclamation.image {
               imageView.image = UIImage(data: image)

           }
           
       }
   }

   
}

