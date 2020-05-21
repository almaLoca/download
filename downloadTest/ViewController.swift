

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var img_out: UIImageView!
    let documentInteractionController = UIDocumentInteractionController()
    override func viewDidLoad() {
        super.viewDidLoad()
         documentInteractionController.delegate = self
    }

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
         guard let navVC = self.navigationController else {
             return self
         }
         return navVC
     }
    
    
    @IBAction func btn_down_doc_act(_ sender: UIButton) {
        storeAndShare(withURLString: "http://webstudent.npstj.com/Assignment_Files/T203640892.docx")
    }
    

    @IBAction func btn_down_img_act(_ sender: UIButton) {
         storeAndShare(withURLString: "http://webstudent.npstj.com/Assignment_Files/i202445189.png")
    }
    
    func storeAndShare(withURLString: String) {
        guard let url = URL(string: withURLString) else { return }
        
        let filenameSeperated = url.lastPathComponent.components(separatedBy: ".")
        
        var fileName = ""
        
        if filenameSeperated[1] == "jpeg" || filenameSeperated[1] == "png" || filenameSeperated[1] == "jpg" {
            
            fileName = "fileName.png"
        } else {
            
            fileName = url.lastPathComponent
        }
             URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else { return }
               let tmpURL = FileManager.default.temporaryDirectory
                   .appendingPathComponent(fileName)
               do {
                   try data.write(to: tmpURL)
               } catch {
                   print(error)
               }
               DispatchQueue.main.async {
                   /// STOP YOUR ACTIVITY INDICATOR HERE
                   self.share(url: tmpURL)
               }
               }.resume()
   
    }
    
    func share(url: URL) {
          documentInteractionController.url = url
          documentInteractionController.presentPreview(animated: true)
      }
  
   
    

    
    
}

