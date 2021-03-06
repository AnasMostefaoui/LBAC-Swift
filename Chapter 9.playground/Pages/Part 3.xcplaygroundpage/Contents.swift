//: [Previous](@previous)
/*:
 # LBaC
 # Chapter IX: A Top View
 ## Part 3: Declarations
 Here are of the things you can declare in our language
 - Label list
 - Constant list
 - Type list
 - Variable list
 - Procedure
 - Function
 */

func postLabel(_ label: String) {
  print("\(label):", terminator:"")
}

/*:
 ### declarations()
 Declarations need to support a few things. As usual, we will represent each declaration types with a single character.
 
 For the time being, we will use dummy functions for all the declaration types.
 > This time, the dummy functions will have to at least eat the character that invoked it. Or else, we will be stuck in an infinite loop.
 */
func declarations() {
  let decTypes : Set<Character> = Set(["l", "c", "t", "v", "p", "f"])
  while let cur = LOOK.cur, decTypes.contains(cur) {
    switch cur {
    case "l":
      labels()
    case "c":
      constants()
    case "t":
      types()
    case "v":
      variables()
    case "p":
      doProcedure()
    case "f":
      doFunction()
    default:
      break
    }
  }
}

func statements() {
}
/*:
 ### Declaration Types
 */
func labels() {
  LOOK.match("l")
}

func types() {
  LOOK.match("t")
}

func constants() {
  LOOK.match("c")
}

func variables() {
  LOOK.match("v")
}

func doProcedure() {
  LOOK.match("p")
}

func doFunction() {
  LOOK.match("f")
}

/*:
 ### doBlock()
 doBlock just folows what a block should look like. Declarations followed by statements.
 
 The insertion of label via `postLabel` has to do with the operation of SK*DOS. Unlike most OS's, SK*DOS allows the entry point to the main program to be anywhere in the program. All you have to do is give that point a name.
 
 `postLabel` does this by putting that name just before the first `statement`.
 
 > `declarations` and `statements` are dummy functions for now. We will make them in the next part
 */
func doBlock(name: Character) {
  declarations()
  postLabel(String(name))
  statements()
}

func prolog() {
  emitLine(msg: "WARMST EQU $A01E")
}

func epilog(_ name: Character) {
  emitLine(msg: "DC WARMST")
  emitLine(msg: "END \(name)")
}

func prog() {
  LOOK.match("p")
  let name = LOOK.getName()
  prolog()
  doBlock(name: name)
  LOOK.match(".")
  epilog(name)
}

/*:
 ### So far...
 You can try out the compiler with various declaration types, as long as the last character in the program is `.` to indicate end of the program.
 
 Of course, none of the declarations actually don't declare anything; for now 😉
 */
func initialize() -> Buffer {
  var LOOK = Buffer(idx: 0, cur: nil, input: "pxvc.")
  LOOK.getChar()
  return LOOK
}

var LOOK = initialize()
prog()
//: [Next](@next)
