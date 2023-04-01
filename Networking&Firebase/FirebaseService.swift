////
////  FirebaseService.swift
////  Networking&Firebase
////
////  Created by Nikhil Patel on 2023-03-19.
////
//
import Foundation
import FirebaseCore
import FirebaseFirestore


class FireBaseService {
    var allImages = [NASAObjectFB]()
    static var shared = FireBaseService()
    let db = Firestore.firestore()
    
    func insertIntoFirestore(id: Int, camera: String, earthDate: String, image: String, completion: @escaping (Bool) -> Void) {
        let query = db.collection("AllImages").whereField("id", isEqualTo: id)
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking for existing document: \(error.localizedDescription)")
                completion(false)
            } else {
                guard let snapshot = snapshot, snapshot.isEmpty else {
                    print("Document with ID \(id) already exists.")
                    completion(false)
                    return
                }
                var ref: DocumentReference? = nil
                ref = self.db.collection("AllImages").addDocument(data: ["id": id, "camera_name": camera, "img_src": image, "earth_date": earthDate]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        completion(false)
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        completion(true)
                    }
                }
            }
        }
    }


   
    func getAllImages(completionHandler : @escaping ([NASAObjectFB])->Void){
        
        var allImagesFormFirebase = [NASAObjectFB]()
        db.collection("AllImages").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    var dID = document.documentID
                    var fb_camera = document.data()["camera_name"] as! String
                    var fb_earthdate = document.data()["earth_date"] as! String
                    var fb_id = document.data()["id"] as! Int
                    var fb_img = document.data()["img_src"] as! String
                    allImagesFormFirebase.append(NASAObjectFB(cameraname: fb_camera, earthdate: fb_earthdate, documentID: dID, ID: fb_id, imgsrc: fb_img))
                }
                print(allImagesFormFirebase)
                completionHandler(allImagesFormFirebase)
            }
        }
                        }
    
    
    func deleteOneImage(todelete : NASAObjectFB){
        
        db.collection("AllImages").document(todelete.docID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    }
    
    
