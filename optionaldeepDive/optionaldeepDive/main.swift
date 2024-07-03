
struct MyOptional{
    var property = 123
    func method(){
        print("I am a method")
    }
}
// We have a data type of MyOptional
let myOptional: MyOptional?
myOptional = MyOptional()
// The ?? is the nil coalescing value, I am stating that if my var is nil then the default value is "I am the king"
//let text: String = myOptional ?? "I am the king"

//print(text)
// Optional chanining, if it is property then we can use the optional?.property, else if it is an method we can use
// optional?.method()
print(myOptional?.property)
