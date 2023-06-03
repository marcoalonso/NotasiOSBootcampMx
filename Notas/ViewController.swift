//
//  ViewController.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 13/05/23.
//

import UIKit
//import CoreData
import RealmSwift

class ViewController: UIViewController {
    
    private var realm = try! Realm()
   
//    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //Arreglo de notas
    var notas : [NotasR] = []
    
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
//        let solicitud: NSFetchRequest<Nota> = Nota.fetchRequest()
//        do {
//            notas = try contexto.fetch(solicitud)
//            //Recargar el collection
//            notasCollection.reloadData()
//        } catch {
//            print("Debug: error al leer de la BD \(error.localizedDescription)")
//        }
        notas = realm.objects(NotasR.self).map({ $0 })
        notasCollection.reloadData()
    }
    
    @IBAction func nuevaNotaButton(_ sender: UIButton) {
        
        //Navegar sin segue hacia NuevaNotaViewController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NuevaNotaViewController")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        present(viewController, animated: true)
        
    }
    

    func borrarNota(_ nota: NotasR){
//        self.contexto.delete(nota)
//        try? contexto.save()
        self.realm.beginWrite()
        self.realm.delete(nota)
        
        do {
            try self.realm.commitWrite()
        } catch {
            print("Debug: error \(error.localizedDescription)")
        }
        leerNotas()
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //navegar
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditarViewController") as! EditarViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        viewController.recibirNota = notas[indexPath.row]
        
        present(viewController, animated: true)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! NotaCell
        celda.textoNota.text = notas[indexPath.row].texto
        
        celda.imagenNota.image = UIImage(data: notas[indexPath.row].imagen! as Data)
        
        let fecha = notas[indexPath.row].fecha!
        celda.fechaNota.text = fecha.getFormattedDate(format: "dd MMM YYYY, HH:mm")
        
        celda.didTapButtonDelete = {
            print("boton borrar seleccionado! \(self.notas[indexPath.row])")
            self.borrarNota(self.notas[indexPath.row])
        }
        
        celda.didTap = {
            print("Se dejo presionada la nota \(self.notas[indexPath.row])")

            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            let vc = UIActivityViewController(activityItems: ["\(self.notas[indexPath.row].texto ?? "")", UIImage(data: self.notas[indexPath.row].imagen! as Data)!], applicationActivities: nil)
            self.present(vc, animated: true)
        }
        
        return celda
    }
}
