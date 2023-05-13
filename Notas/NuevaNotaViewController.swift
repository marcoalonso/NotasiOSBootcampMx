//
//  NuevaNotaViewController.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit
import CoreData

class NuevaNotaViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var fechaNota: UIDatePicker!
    @IBOutlet weak var imagenNota: UIImageView!
    @IBOutlet weak var textoNota: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    ///Oculta teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func elegirImagenButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    // MARK:  Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagenSeleccionada = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imagenNota.image = imagenSeleccionada
        }
        
        picker.dismiss(animated: true)
    }
    
    func guardarNota(){
        if let textoNota = textoNota.text, textoNota != "" {
            let fechaPicker = fechaNota.date
            
            //Crear la nueva nota a guardar
            let nuevaNota = Nota(context: self.contexto)
            nuevaNota.texto = textoNota
            nuevaNota.fecha = fechaPicker
            nuevaNota.imagen = imagenNota.image?.pngData()
            //Guardar los cambios al contexto
            try? contexto.save()
            
            //Regresar
            dismiss(animated: true)
            
            
        } else {
            print("Escribe algo")
            //Quiere guardar una nota vacia
            //Alert "Escribe algo"
        }
    }
    
    
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func guardarButton(_ sender: UIButton) {
        guardarNota()
    }
    


}
