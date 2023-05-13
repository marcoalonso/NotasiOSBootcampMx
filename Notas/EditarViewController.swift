//
//  EditarViewController.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit
import CoreData

class EditarViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //Conexion a la bd o al contexto
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recibirNota: Nota?
    
    @IBOutlet weak var textoNotaEditar: UITextView!
    @IBOutlet weak var imagenNotaEditar: UIImageView!
    @IBOutlet weak var fechaNotaEditar: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mostrarNota()
    }
    
    func mostrarNota(){
        if let notaRecibida = recibirNota {
            textoNotaEditar.text = notaRecibida.texto
            fechaNotaEditar.date = notaRecibida.fecha!
            imagenNotaEditar.image = UIImage(data: notaRecibida.imagen!)
        }
    }
    

    @IBAction func editarImagenButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagenSeleccionada = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imagenNotaEditar.image = imagenSeleccionada
        }
        
        picker.dismiss(animated: true)
    }
    
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func guardarButton(_ sender: UIButton) {
        //que datos voy a guardar
        if let textoNotaEdiata = textoNotaEditar.text, textoNotaEdiata != "" {
            recibirNota?.texto = textoNotaEdiata
            recibirNota?.fecha = fechaNotaEditar.date
            recibirNota?.imagen = imagenNotaEditar.image?.pngData()
            
            try? contexto.save()
            
            dismiss(animated: true)
        }
        
    }
}
