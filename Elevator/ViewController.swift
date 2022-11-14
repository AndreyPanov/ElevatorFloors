import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureElevator()
    }


    func configureElevator() {
        
        let basement = Floor(.basement)
        let ground = Floor(.ground)
        let parking = Floor(.parking)
        let floor0 = Floor(-3)
        let floor1 = Floor(-2)
        let floor2 = Floor(0)
        let floor3 = Floor(2)
        let floor4 = Floor(4)
        let floor5 = Floor(5)
        let floor6 = Floor(6)
        let floor7 = Floor(7)
        let parking1 = Floor(.parking)
        let roof = Floor(.roof)

        let elevator = Elevator()
        elevator.floor = basement
        elevator.append(ground)
        elevator.append(parking)
        elevator.append(floor0)
        elevator.append(floor1)
        elevator.append(floor2)
        elevator.append(floor3)
        elevator.append(floor4)
        elevator.append(floor5)
        elevator.append(floor6)
        elevator.append(floor7)
        elevator.append(parking1)
        elevator.append(roof)
        elevator.printAll()
    }
}

