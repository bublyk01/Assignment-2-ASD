class Apartment {
    let number: Int
    weak var tenant: Person?
    init(number: Int) {
        self.number = number
    }
    func getInfo() {
        print("Apartment \(number) hosting \(tenant?.name.description ?? "empty")")
    }
    deinit {
        print("Apartment deinitialized")
    }
}

class Person {
    let name: String
    weak var apartment: Apartment?
    init(name: String) {
        self.name = name
    }
    func setupApartment(_ apartment: Apartment) {
        self.apartment = apartment
    }
    func getInfo() {
        print("Person \(name) is in Apartment \(apartment?.number.description ?? "empty")")
    }
    deinit {
        print("Person deinitialized")
    }
}

var person: Person? = Person(name: "Your Name")
var apartment: Apartment? = Apartment(number: 42)

person?.setupApartment(apartment!)
apartment?.tenant = person

person?.getInfo()
apartment?.getInfo()

person = nil
apartment = nil

//though the code did work with unowned reference, I changed it to weak
//so that it will be safer to use - weak does indeed make sure that the
//objects are deinitialized when they actually have to, instead of
//clinging onto each other
