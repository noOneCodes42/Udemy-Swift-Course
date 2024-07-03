
protocol CanFly{
    func fly()
}

extension CanFly{
    func fly(){
        print("The object takes off into the air")
    }
}
class Bird {
    var isFemale = true
    func layEgg(){
        if isFemale{
            print("The bird makes a new bird")
        }
    }
}
class Eagle: Bird, CanFly{
    
    
    func soar(){
        print("The eagle glides in the air")
    }
}
class Penguin: Bird{
    func swim(){
        print("The penguin paddles")
    }
}
struct FlyingMuseum{
    func flyingDemo(flyingObject: CanFly){
        flyingObject.fly()
    }
}

struct AirPlane: CanFly{
    
}
let myPlane = AirPlane()
myPlane.fly()
