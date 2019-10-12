import UIKit
import CoreData
import HealthKit


public var name_ = ""
public var weight_ = ""
public var height_ = ""
public var age_ = ""

class UserHealthProfile {
    var heightInMeters: Double?
    var weightInKilograms: Double?
}


class ViewController: UIViewController {
    
    @IBOutlet weak var HiddenMessageLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var heightLabel: UITextField!
    
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var saveButtonPressed: UIButton!
    
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    private let userHealthProfile = UserHealthProfile()
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    private enum ProfileSection: Int {
        case weightHeightBMI
        case readHealthKitData
        case saveBMI
    }
    
    private enum ProfileDataError: Error {
        
        case missingBodyMassIndex
        var localizedDescription: String {
            switch self {
            case .missingBodyMassIndex:
                return "Unable to calculate body mass index with available profile data."
            }
        }
    }
    
    


    private func updateHealthInfo() {
        loadAndDisplayMostRecentWeight()
        loadAndDisplayMostRecentHeight()
    }
    
    
    
    private func loadAndDisplayMostRecentHeight() {
        
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                
                return
            }
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.userHealthProfile.heightInMeters = heightInMeters
            self.updateLabels()
        }
    }
    
    private func loadAndDisplayMostRecentWeight() {
        
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile.weightInKilograms = weightInKilograms
            self.updateLabels()
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if ((nameLabel.text != "") && (weightLabel.text != "") && (heightLabel.text != "") && (ageLabel.text != "")){
            HiddenMessageLabel.text = ""
            name_ = nameLabel.text!
            weight_ = weightLabel.text!
            height_ = heightLabel.text!
            age_ = ageLabel.text!
            
            if(!isAppAlreadyLaunchedOnce()){
                createData_(name: name_, weight: (weight_ as NSString).doubleValue, height: (height_ as NSString).doubleValue , age: (age_ as NSString).doubleValue)
            }
            tabBarController?.selectedIndex = 2
        } else {
            HiddenMessageLabel.isHidden = false
            HiddenMessageLabel.text = "Oops, it looks like you've forgotten something!"
            saveButtonPressed.isUserInteractionEnabled = false
        }
        saveButtonPressed.isUserInteractionEnabled = true
    }
    
    
    
    private func displayAlert(for error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func updateLabels() {
        if let weight = userHealthProfile.weightInKilograms {
            let weightFormatter = MassFormatter()
            weightFormatter.isForPersonMassUse = true
            weightLabel.text = weightFormatter.string(fromKilograms: weight)
            weight_ = weightFormatter.string(fromKilograms: weight)
        }
        
        if let height = userHealthProfile.heightInMeters {
            let heightFormatter = LengthFormatter()
            heightFormatter.isForPersonHeightUse = true
            heightLabel.text = heightFormatter.string(fromMeters: height)
            height_ = heightFormatter.string(fromMeters: height)
        }
    }
    
    func authorizeHealthKitinApp() {
        let healthKitTypesToRead : Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!
        ]
        
        let healthKitTypesToWrite : Set<HKSampleType> = []
        
        if !HKHealthStore.isHealthDataAvailable() {
            print("Error occured")
            return
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) -> Void in
            print("Read Write Authorization succeded")
        }
    }
    
    
    func createData_(name: String, weight: Double, height: Double, age: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(name, forKey: "name")
        user.setValue(weight, forKey: "weight")
        user.setValue(height, forKey: "height")
        user.setValue(age, forKey: "age")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retrieveData () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                if(nameLabel.text == ""){
                    nameLabel.text = (data.value(forKey: "name") as! String)
                }
                if(weightLabel.text == ""){
                    weightLabel.text = String(data.value(forKey: "weight") as! Double)
                }
                if(heightLabel.text == ""){
                    heightLabel.text = String(data.value(forKey: "height") as! Double)
                }
                if(ageLabel.text == ""){
                    ageLabel.text = String(data.value(forKey: "age") as! Double)
                }
            }
        } catch {
            print("Failed")
        }
    }
    
//    func deleteData() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//        fetchRequest.predicate = NSPredicate(format: "name = %@", "Veronika")
//        do {
//            let test = try managedContext.fetch(fetchRequest)
//
//            let objectToDelete = test[0] as! NSManagedObject
//            managedContext.delete(objectToDelete)
//
//            do {
//                try managedContext.save()
//            } catch {
//                print(error)
//            }
//        } catch {
//            print(error)
//        }
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HiddenMessageLabel.text = ""
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
   
        
        if(!isAppAlreadyLaunchedOnce()){
            self.authorizeHealthKitinApp()
            updateHealthInfo()
            createData_(name: nameLabel.text!, weight: (weightLabel.text! as NSString).doubleValue, height: (heightLabel.text! as NSString).doubleValue, age: (ageLabel.text! as NSString).doubleValue)
        } else {
            updateHealthInfo()
            retrieveData()
        }
    }
    
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}


