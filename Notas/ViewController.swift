//
//  ViewController.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit

class ViewController: UIViewController {
   
    //Arreglo de notas
    
    
    @IBOutlet weak var notasCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notasCollection.register(UINib(nibName: "NotaCell", bundle: nil), forCellWithReuseIdentifier: "celda")
        
        notasCollection.delegate = self
        notasCollection.dataSource = self
    }
    
    @IBAction func nuevaNotaButton(_ sender: UIButton) {
        
        //Navegar sin segue hacia NuevaNotaViewController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NuevaNotaViewController")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        present(viewController, animated: true)
        
    }
    

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! NotaCell
        
        celda.textoNota.text = "Ir al cine"
        celda.fechaNota.text = "15 Mayo 2023, 14:00"
        celda.imagenNota.image = UIImage(systemName: "note")
        
        celda.didTapButtonDelete = {
            print("boton borrar seleccionado!")
        }
        
        celda.didTap = {
            print("Se dejo presionada la nota")
        }
        
        return celda
    }
}
