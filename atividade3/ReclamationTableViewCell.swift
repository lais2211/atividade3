import UIKit

class ReclamationTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(_ reclamation: Reclamation){
        textLabel?.text = reclamation.title
        detailTextLabel?.text = reclamation.date?.formatted(.dateTime)
        
    }

}
