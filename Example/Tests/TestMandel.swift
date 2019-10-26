import XCTest
import MoreNumbers
import BigInt

public struct Complex {
    
    public private (set) var r: Double!
    public private (set) var i: Double!
    public init(_ r : Double, _ i : Double = 0.0) {
        self.r = r
        self.i = i
    }
    
    public var norm2 : Double { return self.r*self.r+self.i*self.i }
}

public func +(_ a: Complex, _ b: Complex) -> Complex {
    let ans = Complex(a.r + b.r, a.i+b.i)
    return ans
}

public func -(_ a: Complex, _ b: Complex) -> Complex {
    let ans = Complex(a.r - b.r, a.i - b.i)
    return ans
}

public func *(_ a: Complex, _ b: Complex) -> Complex {
    let ans = Complex(a.r * b.r - a.i * b.i, a.r * b.i + a.i * b.r)
    return ans
}

public func /(_ a: Complex, b: Complex) -> Complex {
    let r = a.r*b.r + a.i*b.i
    let i = a.i*b.r - a.r*b.i
    let n = b.norm2
    
    let ans = Complex(r/n,i/n)
    return ans
}


class TestMandel: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func Mandel(_ index : UInt) -> Int? {
        let r = -3.0 / 4.0
        let i = pow(10.0, -Double(index))
        let c = Complex(r,i)
        
        var z = Complex(0)
        for i in 1...100000 {
            z = z*z + c
            let n = z.norm2
            print(i,":",n)
            if n > 2 { return i }
        }
        return nil
    }
    func test1() {
        _ = Mandel(4)
    }
   
}
