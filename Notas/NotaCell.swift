//
//  NotaCell.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit

class NotaCell: UICollectionViewCell {
    
    @IBOutlet weak var didTapNotaBackground: UIView!
    @IBOutlet weak var fechaNota: UILabel!
    @IBOutlet weak var imagenNota: UIImageView!
    @IBOutlet weak var textoNota: UILabel!
    
    //Closure cuando se presiona devuelve la info a la vista que incorpora esta celda
    var didTap: (() -> Void)?
    var didTapButtonDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Agregar una funcionalidad a la vista de fondo
        
        didTapNotaBackground.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(didTapNote)))
        
    }
    
    //Solo si agregaste boton de eliminar
    @IBAction func deleteButton(_ sender: UIButton) {
        if let tap = didTapButtonDelete {
            tap()
        }
    }
    
    @objc func didTapNote() {
        ///Desenvolver el closure
        if let tap = didTap {
            tap()
        }
    }
    
    

}
