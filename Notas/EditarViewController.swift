//
//  EditarViewController.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit

class EditarViewController: UIViewController {
    
    @IBOutlet weak var textoNotaEditar: UITextView!
    
    @IBOutlet weak var imagenNotaEditar: UIImageView!
    @IBOutlet weak var fechaNotaEditar: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func editarImagenButton(_ sender: UIButton) {
    }
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func guardarButton(_ sender: UIButton) {
    }
    

}
