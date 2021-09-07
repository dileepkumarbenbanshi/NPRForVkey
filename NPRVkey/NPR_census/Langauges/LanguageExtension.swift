//
//  LanguageExtension.swift
//  NPR_census
//
//  Created by IOS Development Team on 01/02/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class LanguageExtension {
    
    public func getModal(language: String) {
        
        var langArray = [[String: Any]]()
        if let path = Bundle.main.path(forResource: "Language", ofType: "plist") {
            
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                
                langArray = array
                
            }
            
        }
        
        //Fetch Language Modal based on User selected Language and Language.plist
        print("Language array size: ", langArray.count)
        switch language {
        case langArray[0]["name"] as! String: print("Langauge is 1: ", langArray[0]["name"] ?? "no value")
            let data = fileToData(fileName: "English")
             decodeJson(jsonData: data)
//            let english = EnglishLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(english)
//               let data = fileToData(fileName: "English")
//                decodeJson(jsonData: data)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[1]["name"] as! String: print("Langauge is 2: ", langArray[1]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Hindi")
             decodeJson(jsonData: data)
//            let hindi = HindiLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(hindi)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[2]["name"] as! String: print("Langauge is 3: ", langArray[2]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Urdu")
             decodeJson(jsonData: data)
//            let urdu = UrduLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(urdu)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[3]["name"] as! String: print("Langauge is 4: ", langArray[3]["name"] ?? "no value")
            let data = fileToData(fileName: "Punjabi")
             decodeJson(jsonData: data)
//            let punjabi = PunjabiLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(punjabi)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[4]["name"] as! String: print("Langauge is 5: ", langArray[4]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Malyalam")
             decodeJson(jsonData: data)
            
//            let malyalam = MalyalamLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(malyalam)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[5]["name"] as! String: print("Langauge is 6: ", langArray[5]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Marathi")
             decodeJson(jsonData: data)
//            let marathi = MarathiLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(marathi)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[6]["name"] as! String: print("Langauge is 7: ", langArray[6]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Konkani")
             decodeJson(jsonData: data)
//            let konkani = KonkaniLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(konkani)
//                
//                decodeJson(jsonData: jsonData)
//                
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[7]["name"] as! String: print("Langauge is 8: ", langArray[7]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Gujrati")
             decodeJson(jsonData: data)
//            let gujrati = GujratiLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(gujrati)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[8]["name"] as! String: print("Langauge is 9: ", langArray[8]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Bengali")
             decodeJson(jsonData: data)
            
//            let bengali = BengaliLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(bengali)
//                
//                decodeJson(jsonData: jsonData)
//                
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[9]["name"] as! String: print("Langauge is 10: ", langArray[9]["name"] ?? "no value")
            
            let data = fileToData(fileName: "Tamil")
             decodeJson(jsonData: data)
//            let tamil = TamilLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(tamil)
//                
//                decodeJson(jsonData: jsonData)
//                
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[10]["name"] as! String: print("Langauge is 11: ", langArray[10]["name"] ?? "no value")
//           let data = fileToData(fileName: "Assamese")
//            decodeJson(jsonData: data)
            let assamese = AssameseLang()
            do {
                // Encode
                let jsonData = try JSONEncoder().encode(assamese)
                
                decodeJson(jsonData: jsonData)
                
            } catch {
                print("Error while encoding: ", error)
            }
            
           break
            
        case langArray[11]["name"] as! String: print("Langauge is 12: ", langArray[11]["name"] ?? "no value")
            
            
            let data = fileToData(fileName: "Kannad")
             decodeJson(jsonData: data)
//            let kannada = KannadaLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(kannada)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[12]["name"] as! String: print("Langauge is 13: ", langArray[12]["name"] ?? "no value")
            let data = fileToData(fileName: "Oriya")
             decodeJson(jsonData: data)
//            let oriya = OriyaLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(oriya)
//                
//                decodeJson(jsonData: jsonData)
//                
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[13]["name"] as! String: print("Langauge is 14: ", langArray[13]["name"] ?? "no value")
            let data = fileToData(fileName: "Nepali")
             decodeJson(jsonData: data)
//            let nepali = NepaliLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(nepali)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        case langArray[14]["name"] as! String: print("Langauge is 15: ", langArray[14]["name"] ?? "no value")
            let data = fileToData(fileName: "Telagu")
             decodeJson(jsonData: data)
//            let telgu = TelguLang()
//            do {
//                // Encode
//                let jsonData = try JSONEncoder().encode(telgu)
//
//                decodeJson(jsonData: jsonData)
//
//            } catch {
//                print("Error while encoding: ", error)
//            }
            
           break
            
        default: print("Langauge is: ", language)
            
            let english = EnglishLang()
            do {
                // Encode
                let jsonData = try JSONEncoder().encode(english)
                
                decodeJson(jsonData: jsonData)
                
            } catch {
                print("Error while encoding: ", error)
            }
            
           break
            
        }
        
    }
    
    func decodeJson(jsonData: Data){
        
        do{
            
            // Decode
            //print("Json Data: ", String(decoding: jsonData, as: UTF8.self))
            let jsonDecoder = JSONDecoder()
            LanguageModal.langObj = try jsonDecoder.decode(LanguageModal.self, from: jsonData)
            print("Lang Check 1: ", LanguageModal.langObj.login)
        }
        catch{
            
            print("Error while decoding: ", error)
            
        }
        
    }
    
    
    func jsonToData(json:[String:Any]) -> Data {
        var data = Data()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
         data = jsonData
            
           
        } catch {
            print(error.localizedDescription)
        }
        return data
    }
    
    
    func getJsonFromFile(fileName:String)-> [String: Any]  {
        var dictJson =  [String:Any]()
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {

            
            do {
                let data = try Data(contentsOf: url)
                guard let dict =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return ["":""] }
               dictJson = dict
                
                    } catch {
                        print(error.localizedDescription)
                    }
            }
return dictJson
       // println("jsonDict \(jsonDict)") - This prints nil.....
    }
    
    func fileToData(fileName:String) -> Data {
        
       
        let json = getJsonFromFile(fileName: fileName)
        let data = jsonToData(json: json)
       return data
    }
}
