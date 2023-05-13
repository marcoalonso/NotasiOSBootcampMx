//
//  ViewController.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
   
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //Arreglo de notas
    var notas : [Nota] = []
    
    @IBOutlet weak var notasCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notasCollection.register(UINib(nibName: "NotaCell", bundle: nil), forCellWithReuseIdentifier: "celda")
        
        notasCollection.delegate = self
        notasCollection.dataSource = self
        
        
    }
    
    //Antes de que la vista aparezca
    override func viewWillAppear(_ animated: Bool) {
        leerNotas()
    }
    
    func leerNotas(){
        let solicitud: NSFetchRequest<Nota> = Nota.fetchRequest()
        do {
            notas = try contexto.fetch(solicitud)
            //Recargar el collection
            notasCollection.reloadData()
        } catch {
            print("Debug: error al leer de la BD \(error.localizedDescription)")
        }
        
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
        return notas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! NotaCell
        
        celda.textoNota.text = notas[indexPath.row].texto
        
        celda.imagenNota.image = UIImage(data: notas[indexPath.row].imagen!)
    
        
        let fecha = notas[indexPath.row].fecha!
        celda.fechaNota.text = fecha.getFormattedDate(format: "dd MMM YYYY, HH:mm")
        
        celda.didTapButtonDelete = {
            print("boton borrar seleccionado! \(self.notas[indexPath.row])")
        }
        
        celda.didTap = {
            print("Se dejo presionada la nota \(self.notas[indexPath.row])")
        }
        
        return celda
    }
}
