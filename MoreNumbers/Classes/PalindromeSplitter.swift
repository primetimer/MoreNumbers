//
//  PalindromeSplitter.swift
//  Palindrome
//
//  Created by Stephan Jancar on 22.09.18.
//  Copyright © 2018 Stephan Jancar. All rights reserved.
//

import Foundation
import BigInt

public enum NumType : Int , CaseIterable {
	case A1,  A2, A3, A4, A5, A6
	case B1, B2, B3, B4, B5, B6, B7
}

public extension NumType {
	func asString() -> String {
		let str = ["A1","A2","A3","A4","A5","A6","B1","B2","b3","B4","B5","B6","B7"]
		return str[self.rawValue]
	}
}

public extension PalindromeSplitter {
	
	
	private func GetType(d: [Int],  _ base: Int)  {
		let digits = self.d
		let l = digits.count;
		let m = l >> 1;
		let dl1 = digits[l - 1]
		let dl2 = digits[l - 2]
		let dl3 = digits[l - 3]
		
		let d0 = digits[0];
		self.type = nil
		var z1 = 0
		self.special = false //esjot digits[m] == 0 || digits[m - 1] == 0;
		self.special = digits[m] == 0 || digits[m - 1] == 0;
		//esjot2

		
		if esjot2 { //} && dl1 == 1 && dl2 == 0 && dl3 == 4) {
			type = NumType.B1
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2;
			config[0][1] = dl2;
			config[0][0] = 1;
			config[1][l - 3] = dl3 - 1;
			config[1][0] = dl3 - 1;
			z1 = D(d0 - dl3, base);
			config[2][l - 4] = z1;
			config[2][0] = z1;
			special = false
		} else // Ende esjot2
		
		if (dl2 > 2 && D(d0 - dl1 - dl2 + 1, base) != 0) {
			type = NumType.A1;
			config[0][l - 1] = dl1;
			config[0][0] = dl1;
			config[1][l - 2] = dl2 - 1;
			config[1][0] = dl2 - 1;
			z1 = D(d0 - dl1 - dl2 + 1, base);
			config[2][0] = z1;
			config[2][l - 3] = z1;
			special = special && l % 2 == 0;
		} else if (dl2 > 2 && D(d0 - dl1 - dl2 + 1, base) == 0) {
			type = NumType.A2;
			config[0][l - 1] = dl1;
			config[0][0] = dl1;
			config[1][l - 2] = dl2 - 2;
			config[1][0] = dl2 - 2;
			config[2][0] = 1;
			config[2][l - 3] = 1;
			special = special && l % 2 == 0;
		} else if (dl2 <= 2 && dl1 != 1 && D(d0 - dl1 + 2, base) != 0) {
			type = NumType.A3
			config[0][l - 1] = dl1 - 1;
			config[0][0] = dl1 - 1;
			config[1][l - 2] = base - 1;
			config[1][0] = base - 1;
			z1 = D(d0 - dl1 + 2, base);
			config[2][0] = z1;
			config[2][l - 3] = z1;
			special = special && l % 2 == 0;
		} else if (dl2 <= 2 && dl1 != 1 && D(d0 - dl1 + 2, base) == 0) {
			type = NumType.A4
			config[0][l - 1] = dl1 - 1;
			config[0][0] = dl1 - 1;
			config[1][l - 2] = base - 2;
			config[1][0] = base - 2;
			config[2][0] = 1;
			config[2][l - 3] = 1;
			special = special && l % 2 == 0;
		} else if (dl1 == 1 && dl2 == 0 && dl3 <= 3 && D(d0 - dl3, base) != 0) {
			type = NumType.A5
			config[0][l - 2] = base - 1;
			config[0][0] = base - 1;
			config[1][l - 3] = dl3 + 1;
			config[1][0] = dl3 + 1;
			z1 = D(d0 - dl3, base);
			config[2][0] = z1;
			config[2][l - 4] = z1;
			special = special && l % 2 == 1;
		} else if (dl1 == 1 && dl2 == 0 && dl3 <= 2 && D(d0 - dl3, base) == 0) {
			type = NumType.A6
			config[0][l - 2] = base - 1;
			config[0][0] = base - 1;
			config[1][l - 3] = dl3 + 2;
			config[1][0] = dl3 + 2;
			config[2][0] = base - 1;
			config[2][l - 4] = base - 1;
			special = special && l % 2 == 1;
		} else if (dl1 == 1 && dl2 <= 2 && dl3 >= 4 && D(d0 - dl3, base) != 0) {
			type = NumType.B1
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2;
			config[0][1] = dl2;
			config[0][0] = 1;
			config[1][l - 3] = dl3 - 1;
			config[1][0] = dl3 - 1;
			z1 = D(d0 - dl3, base);
			config[2][l - 4] = z1;
			config[2][0] = z1;
			special = special && l % 2 == 0
		} else if (dl1 == 1 && dl2 <= 2 && dl3 >= 3 && D(d0 - dl3, base) == 0) {
			type = NumType.B2
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2;
			config[0][1] = dl2;
			config[0][0] = 1;
			config[1][l - 3] = dl3 - 2;
			config[1][0] = dl3 - 2;
			config[2][l - 4] = 1;
			config[2][0] = 1;
			special = special && l % 2 == 0;
//			if dl1 == 1 && dl2 == 0 && dl3 == 3 {
//				special = false }//esjot103
		} else if (dl1 == 1 && (dl2 == 1 || dl2 == 2) && (dl3 == 0 || dl3 == 1) && d0 == 0) {
			type = NumType.B3
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2 - 1;
			config[0][1] = dl2 - 1;
			config[0][0] = 1;
			config[1][l - 3] = base - 2;
			config[1][0] = base - 2;
			config[2][l - 4] = 1;
			config[2][0] = 1;
			special = special && l % 2 == 0;
		} else if (dl1 == 1 && (dl2 == 1 || dl2 == 2) && (dl3 == 2 || dl3 == 3) && d0 == 0) {
			type = NumType.B4
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2;
			config[0][1] = dl2;
			config[0][0] = 1;
			config[1][l - 3] = 1;
			config[1][0] = 1;
			config[2][l - 4] = base - 2;
			config[2][0] = base - 2;
			special = special && l % 2 == 0;
		} else if (dl1 == 1 && (dl2 == 1 || dl2 == 2) && dl3 <= 2 && d0 != 0) {
			type = NumType.B5
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2 - 1;
			config[0][1] = dl2 - 1;
			config[0][0] = 1;
			config[1][l - 3] = base - 1;
			config[1][0] = base - 1;
			config[2][l - 4] = d0;
			config[2][0] = d0;
			special = special && l % 2 == 0;
		} else if (dl1 == 1 && (dl2 == 1 || dl2 == 2) && dl3 == 3 && D(d0 - 3, base) != 0) {
			type = NumType.B6
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2;
			config[0][1] = dl2;
			config[0][0] = 1;
			config[1][l - 3] = 2;
			config[1][0] = 2;
			z1 = D(d0 - 3, base);
			config[2][l - 4] = z1;
			config[2][0] = z1;
			special = special && l % 2 == 0;
		} else if (dl1 == 1 && (dl2 == 1 || dl2 == 2) && dl3 == 3 && d0 == 3) {
			type = NumType.B7
			config[0][l - 1] = 1;
			config[0][l - 2] = dl2;
			config[0][1] = dl2;
			config[0][0] = 1;
			config[1][l - 3] = 1;
			config[1][0] = 1;
			config[2][l - 4] = 1;
			config[2][0] = 1;
			special = special && l % 2 == 0;
		}
	}
}

public class PalindromeSplitter {
	
	public private (set) var x : BigUInt
	public private (set) var base : Int
	
	public var type: NumType? = nil
	public var special : Bool = false
	public var esjot2 : Bool = false
	public var config : [[Int]] = []
	public var algorithm : Int = 0
	public var sampler : protPalindromSampler? = nil
	
	public init(p: BigUInt, base: Int = 10, esjot2: Bool) {
		precondition(base >= 5)
		self.x = p
		self.base = base
		self.esjot2 = esjot2
		self.p1 = 0
		self.p2 = 0
		self.p3 = 0
	}
	
	public func Calc() {
		
		defer {
			sampler?.Finished(self)
		}
		if x == 0 {	return }
		if x.isPalindromic(base: base) {
			self.p1 = x

			return
		}
		self.d = x.getDigits(base:base)

		let c = d.count
		if d.count >= 5 {
			let l = d.count
			let m = l >> 1
			self.special = (d[m] == 0 || d[m-1] == 0) ? true : false
			self.config = Array(repeating: [], count: 3)
			self.config[0] = Array(repeating: 0, count: l+1)
			self.config[1] = Array(repeating: 0, count: l+1)
			self.config[2] = Array(repeating: 0, count: l+1)
			GetType(d: d,base)
		}
		
		var ispalindromic = true
		for i in 0..<c {
			if d[i] != d[c-i-1] {
				ispalindromic = false; break;
			}
		}
		if ispalindromic {
			self.p1 = x
			return
		}
		
		Split()
	}
	public init(p: BigUInt,  base: Int = 10) {
		precondition(base >= 5)
		self.x = p
		self.base = base
		self.p1 = 0
		self.p2 = 0
		self.p3 = 0
		self.esjot2 = false
	}
	
	public private (set) var d : [Int] = []
	public private (set) var p1 : BigUInt = 0
	public private (set) var p2 : BigUInt = 0
	public private (set) var p3 : BigUInt = 0
	private func Split2() {
		if d[1] <= d[0] {
			self.p1 = BigUInt(d[1] *  base + d[1])
			self.p2 = BigUInt(d[0] - d[1])
		} else 	if d[1] > d[0] + 1 {
			self.p1 = BigUInt((d[1] - 1) * self.base + (d[1] - 1))
			self.p2 = BigUInt(self.base+d[0]-d[1]+1)
		} else {
			self.p3 = BigUInt(d[0] * self.base + d[0])
			self.p2 = BigUInt(self.base - 1)
			self.p1 = BigUInt(1)
		}
	}
	
	private func Concat(_ d0: Int, _ d1: Int = 0, _ d2: Int = 0, _ d3 : Int = 0, _ d4: Int = 0, _ d5 : Int = 0) -> BigUInt {
		let x = ((((d5 * base + d4) * base + d3) * base + d2) * base + d1) * base + d0
		return BigUInt(x)
	}
	
	private func D(_ n: Int, _  base: Int) -> Int {
		var n = n % base;
		if (n < 0) {
			n += base;
		}
		return n
	}
	
	private func Split3() {
		if d[2] <= d[0] {
			self.p1 = Concat(d[2],d[1],d[2])
			self.p2 = Concat(d[0]-d[2])
		} else 	if d[1] != 0 {
			self.p1 = Concat(d[2],d[1]-1,d[2])
			self.p2 = BigUInt(self.base + d[0] - d[2])
		} else if D(d[2]-d[0]-1,  base) != 0 {
			self.p1 = Concat(d[2]-1,self.base-1,d[2]-1)
			self.p2 = BigUInt(self.base+d[0]-d[2]+1)
		} else if d[2] >= 3 {
			self.p1 = Concat(d[2]-2,self.base-1,d[2]-2)
			self.p2 = Concat(1,1,1)
		} else 	if d[2] == 2 {
			self.p1 = Concat(1,0,1)
			self.p2 = Concat(self.base - 1 , self.base - 1)
			self.p3 = Concat(1)
		} else {
			self.p1 = Concat(self.base - 1 , self.base - 1)
			self.p2 = Concat(1)
		}
	}
	
	
	private func Split4() {
		let test3 = Concat(d[3],0,0,d[3])
		
		func CheckForm() -> Bool {
			if 	self.x == test3 + Concat(1,0,2)	{ return true }
			for delta in 0...base-2 {
				if self.x == test3 + Concat(delta,delta+1) {
					return true
				}
			}
			return false
		}
		if self.x >= test3 && !CheckForm() {
			let split2 = PalindromeSplitter(p: self.x - test3, base: self.base)
			split2.Calc()
			self.p1 = test3
			self.p2 = split2.p1
			self.p3 = split2.p2
			return
		}
		if self.x == test3 + Concat(1,0,2) {
			if d[3] != 1 && d[3] != self.base - 1 {
				self.p1 = Concat(d[3] - 1,self.base-1,self.base-1,d[3]-1)
				self.p2 = Concat(2,1,2)
			} else if d[3] == 1 {
				self.p1 = Concat(1,1,1,1)
				self.p2 = Concat(self.base-2,self.base-2)
				self.p3 = Concat(3)
			} else {
				self.p1 = Concat(self.base-1,1,1,self.base-1)
				self.p2 = Concat(self.base-2,self.base-2)
				self.p3 = 3
			}
			return
		}
		for delta in 0...self.base-2 {
			let add = Concat(delta,delta+1)
			if self.x == test3 + add {
				if d[3] + delta == d[0] {
					if d[3] != 1 {
						self.p1 = Concat(d[3]-1,self.base-2,self.base-2,d[3]-1)
						self.p2 = Concat(1,3,1)
						self.p3 = Concat(delta,delta)
						return
					} else {
						self.p1 = Concat(self.base-1,self.base-1,self.base-1)
						self.p2 = Concat(delta+1,delta+1)
						self.p3 = Concat(1)
						return
					}
				}
				if d[3] + delta == self.base + d[0] && d[0] <= self.base - 1 {
					self.p1 = Concat(d[3]-1,self.base-2,self.base-2,d[3]-1)
					self.p2 = Concat(1,3,1)
					self.p3 = Concat(delta,delta)
					return
				}
				assert(false)
			}
		}
		if self.x == Concat(d[0],0,0,d[3]) && d[0] 	<= d[3] - 1 && d[3] != 1 {
			self.p1 = Concat(d[3]-1,self.base-1,self.base-1,d[3]-1)
			self.p2 = Concat(self.base + d[0] - d[3])
			self.p3 = Concat(1)
			return
		}
		if self.x == Concat(0,0,0,1) {
			self.p1 = Concat(self.base-1,self.base-1,self.base-1)
			self.p2 = Concat(1)
			return
		}
		assert(false)
	}
	
	private func Split5() {
		
		
		
		let d0 = self.d[0]
		let d1 = self.d[1]
		let d2 = self.d[2]
		let d3 = self.d[3]
		let d4 = self.d[4]
		
		
		if (d4 != 1) {
			return Algorithms()
		}
		
		let test1 = Concat(1,d3,0,d3,1)
		//print("test1:",test1)
		
		func CheckForm() -> Int? {
			for delta in 0...base-2 {
				if self.x == test1 + Concat(delta,delta+1) {
					return delta
				}
			}
			return nil
		}
		
		if self.x == test1 + Concat(1,0,2) {
			self.p1 = Concat(1,d3,1,d3,1)
			self.p2 = Concat(1,0,1)
			return
		}
		
		if let delta = CheckForm() {
			if d3 != 0 {
				if delta+1+d3 <= self.base - 1 {
					self.p1 = Concat(1,d3-1,1,d3-1,1)
					self.p2 = Concat(self.base-1,delta+1,self.base-1)
					self.p3 = Concat(delta + 1)
					return
				}
				
				if d3+1+delta == self.base + d1 {
					self.p1 = Concat(1,d3-1,1,d3-1,1)
					self.p2 = Concat(self.base-1,delta+1,self.base-1)
					self.p3 = Concat(delta + 1)
					return
				}
				assert(false)
			}
			
			if d3 == 0 {
				self.p1 = Concat(self.base-1,self.base-1,self.base-1,self.base-1)
				self.p2 = Concat(delta+1,delta+1)
				self.p3 = Concat(1)
				return
			}
			assert(false)
		}
		
		if self.x >= test1 {
			let dif = self.x - test1
			let difsplitter = PalindromeSplitter(p: dif,  base: base)
			difsplitter.Calc()
			//print(difsplitter)
			self.p1 = difsplitter.p1
			self.p2 = difsplitter.p2
			self.p3 = test1
			return
		}
		
		let test0 = Concat(0,d3,0,d3,1)
		if self.x <= test0 && d3 == 0 {
			self.p1 = Concat(self.base-1,self.base-1,self.base-1,self.base-1)
			self.p2 = Concat(1)
			return
		}
		
		func Check0Form(dif: BigUInt) -> Bool {
			if dif == Concat(1,0,2) { return true }
			for delta in 1...base-2 {
				if dif == Concat(delta,delta+1) {
					return true
				}
			}
			return false
		}
		if self.x <= test0 && d3 != 0 {
			let temp = Concat(1,d3-1,self.base-1,d3-1,1)
			let dif = self.x - temp
			if !Check0Form(dif: dif) {
				let difsplitter = PalindromeSplitter(p: dif,  base: base)
				difsplitter.Calc()
				self.p1 = difsplitter.p1
				self.p2 = difsplitter.p2
				self.p3 = temp
				return
			}
		}
		
		for delta in 0...self.base-2 {
			let temp = Concat(1,d3-1,self.base-1,d3-1,1)
			let test = Concat(delta,delta+1)
			if d3 + delta == self.base + d1 {
				if self.x == temp + test {
					self.p1 = Concat(1,d3-1,self.base-2,d3-1,1)
					self.p2 = Concat(1,delta+1,1)
					self.p3 = Concat(delta-1)
					return
				}
			}
		}
		assert(false)
		
	}
	
	private func Split() {
		if d.count == 1 {
			self.p1 = self.x
		} else if d.count == 2 {
			Split2()
		}
		else if d.count == 3 {
			Split3()
		}
		else if d.count == 4 {
			Split4()
		}
		else if d.count == 5 {
			Split5()
		}
		else if d.count == 6 {
			Split6()
		} else {
			Algorithms()
		}
	}
	
	private func AlgorithmI(m: Int) {
		let l = d.count;
		var x : [Int] = Array(repeating: 0, count: m+2)
		var y : [Int] = Array(repeating: 0, count: m+2)
		var z : [Int] = Array(repeating: 0, count: m+2)
		var c : [Int] = Array(repeating: 0, count: m+2)
		
		var _ref2 = [config[0][0], config[1][0], config[2][0]];
		x[1] = _ref2[0];
		y[1] = _ref2[1];
		z[1] = _ref2[2];
		
		
		c[1] = (x[1] + y[1] + z[1]) /  base
		if z[1] <= d[2 * m - 2] - 1 {
			x[2] = D(d[2 * m - 1] - y[1],  base)
		} else {
			x[2] = D(d[2 * m - 1] - y[1] - 1, base)
		}
		
		y[2] = D(d[2 * m - 2] - z[1] - 1,  base);
		z[2] = D(d[1] - x[2] - y[2] - c[1],  base);
		c[2] = (x[2] + y[2] + z[2] + c[1] - d[1]) / base
		if m>=3 {
			for i in 3...m {
				x[i] = z[i - 1] <= d[2 * m - i] - 1 ? 1 : 0;
				y[i] = D(d[2 * m - i] - z[i - 1] - 1,  base);
				z[i] = D(d[i - 1] - x[i] - y[i] - c[i - 1],  base);
				c[i] = (x[i] + y[i] + z[i] + c[i - 1] - d[i - 1]) / base
			}
		}
		x[m + 1] = 0
		if (c[m] == 1) {
			// do nothing;
		} else if (c[m] == 0) {
			x[m + 1] = 1;
		} else if (c[m] == 2) {
			if (z[m] != base - 1) {
				y[m] -= 1;
				z[m] += 1;
			} else {
				x[m + 1] = 1;
				y[m] -= 1;
				z[m] = 0;
			}
		}
		
		for i in 1...m {
			config[0][i - 1] = x[i];
			config[0][2 * m + 1 - i] = x[i];
			config[1][i - 1] = y[i];
			config[1][2 * m - i] = y[i];
			config[2][i - 1] = z[i];
			config[2][2 * m - i - 1] = z[i];
		}
		config[0][m] = x[m + 1];
		
		for i in 0...l {
			self.p1 = self.p1 * BigUInt(base) + BigUInt(config[0][l-i])
			self.p2 = self.p2 * BigUInt(base) + BigUInt(config[1][l-i])
			self.p3 = self.p3 * BigUInt(base) + BigUInt(config[2][l-i])
		}
		
	}
	
	private func Algorithms() {
		
		let l = self.d.count
		let odd = l % 2 == 1 ? true : false
		let m = l >> 1
		
		guard let type = self.type else { return }
		
		switch (type) {
		case .A1, .A2, .A3, .A4:
			if (odd) {
				self.algorithm = 1
				AlgorithmI(m: m)
				return
			}
			else if !special {
				self.algorithm = 2
				AlgorithmII()
				return
			}
			else {
				self.algorithm = 5
				return AlgorithmV()
			}
			
			
		case .A5,.A6:
			if (!odd) {
				self.algorithm = 1
				return AlgorithmI(m: m - 1)
			} else if (!special) {
				self.algorithm = 2
				return AlgorithmII()
			}
			else {
				self.algorithm = 5
				return AlgorithmV()
			}
			
		case .B1,.B2,.B3,.B4,.B5,.B6,.B7:
			
			if (odd) {
				self.algorithm = 3
				return AlgorithmIII()
			}
			else if (!special) {
				self.algorithm = 4
				return AlgorithmIV()
			} else {
				self.algorithm = 5
				return AlgorithmV()
			}
		}
	}
}



extension PalindromeSplitter : CustomStringConvertible {
    public var description : String {
		let s = String(x,radix:self.base) + ":" + String(p1,radix:self.base) + "," + String(p2,radix:self.base) + "," + String(p3,radix:self.base)
		return s
	}
}

extension PalindromeSplitter {
	
	func idiv(_ a: Int, _ b: Int) -> Int {
		return a / b
	}
	
	func Split6Leading1() {
		let l = d.count
		let m = l>>1
		var _x5 : [Int] = Array(repeating: 0, count: m+2)
		var _y : [Int] = Array(repeating: 0, count: m+2)
		var _z : [Int] = Array(repeating: 0, count: m+2)
		var _c : [Int] = Array(repeating: 0, count: m+2)
		let (d0,d1,d2,d3,d4,_) = (d[0],d[1],d[2],d[3],d[4],d[5])
		
		if (D(d0 - d4 + 1,  base) != 0 && D(d0 - d4 + 2,  base) != 0) {
			_x5[1] = ((base + d4 - 1) / 2)
			_y[1] = base + d4 - 1 - _x5[1];
			_z[1] = D(d0 - d4 + 1,  base);
			_c[1] = (_x5[1] + _y[1] + _z[1] - d0) / base
			_x5[2] = ((base + d3 - 1) / 2)
			_y[2] = base + d3 - 1 - _x5[2];
			_z[2] = D(d1 - _x5[2] - _y[2] - _c[1],  base);
			_c[2] = (_x5[2] + _y[2] + _z[2] + _c[1] - d[1]) /  base
			_x5[3] = ((base + d2 - _c[2] - _z[1]) / 2);
			_y[3] = base + d2 - _c[2] - _z[1] - _x5[3];
			
			self.p1 = Concat(_x5[1],_x5[2],_x5[3],_x5[2],_x5[1])
			self.p2 = Concat(_y[1],_y[2],_y[3],_y[2],_y[1])
			self.p3 = Concat(_z[1],_z[2],_z[1])
			return
		} else if (D(d0 - d4 + 2,  base) == 0 && d2 != 0) {
			_x5[1] = ((base + d4 - 1) / 2)
			_y[1] = base + d4 - 1 - _x5[1]
			_z[1] = base - 1;
			_c[1] = (_x5[1] + _y[1] + _z[1] - d0) / base
			_x5[2] = ((base + d3 - 1) / 2)
			_y[2] = base + d3 - 1 - _x5[2]
			_z[2] = D(d1 - _x5[2] - _y[2] - _c[1],  base);
			_c[2] = (_x5[2] + _y[2] + _z[2] + _c[1] - d[1]) / base
			_x5[3] = ((1 + d2 - _c[2]) / 2);
			_y[3] = 1 + d2 - _c[2] - _x5[3];
			self.p1 = Concat(_x5[1],_x5[2],_x5[3],_x5[2],_x5[1])
			self.p2 = Concat(_y[1],_y[2],_y[3],_y[2],_y[1])
			self.p3 = Concat(_z[1],_z[2],_z[1])
			return
		} else if (D(d0 - d4 + 2,  base) == 0 && d2 == 0) {
			if (d4 == 0) {
				_x5[2] = (d3 / 2);
				_y[2] = d3 - _x5[2];
				_z[2] = D(d1 - _x5[2] - _y[2] - 1,  base);
				_c[2] = (_x5[2] + _y[2] + _z[2] + 1 - d1) /  base
				_x5[3] = ((base - _c[2] - _z[2]) / 2);
				_y[3] = base - _c[2] - _z[2] - _x5[3]
				self.p1 = Concat(base-2,_x5[2],_x5[3],_x5[2],base-2)
				self.p2 = Concat(1,_y[2],_y[3],_y[2],1)
				self.p3 = Concat(base-1,_z[2],_z[2],base-1)
				return
			} else if (d4 == 1) {
				_x5[2] = (d3 / 2);
				_y[2] = d3 - _x5[2];
				_z[2] = D(d1 - _x5[2] - _y[2] - 1,  base);
				_c[2] = idiv(_x5[2] + _y[2] + _z[2] + 1 - d1, base);
				_x5[3] = ((base - _c[2] - _z[2]) / 2);
				_y[3] = base - _c[2] - _z[2] - _x5[3]
				self.p1 = Concat(base-1,_x5[2],_x5[3],_x5[2],base-1)
				self.p2 = Concat(1,_y[2],_y[3],_y[2],1)
				self.p3 = Concat(base-1,_z[2],_z[2],base-1)
				return
				
			} else if (d4 == 2) {
				_x5[2] = (d3 / 2);
				_y[2] = d3 - _x5[2];
				_z[2] = D(d1 - _x5[2] - _y[2] - 2,  base);
				_c[2] = idiv(_x5[2] + _y[2] + _z[2] + 2 - d1, base);
				if (_c[2] != 2) {
					_x5[3] = ((base - _c[2] - _z[2]) / 2);
					_y[3] = base - _c[2] - _z[2] - _x5[3];
					self.p1 = Concat(base-1,_x5[2],_x5[3],_x5[2],base-1)
					self.p2 = Concat(2,_y[2],_y[3],_y[2],2)
					self.p3 = Concat(base-1,_z[2],_z[2],base-1)
					return
				} else {
					self.p1 = Concat(1,2,base-2,base-2,2,1)
					self.p2 = Concat(1,base-3,1)
					self.p3 = Concat(base-2)
					return
				}
			} else if (d4 >= 3) {
				_c[4] = idiv(D(d3 - 1,  base) + 1 - d3, base)
				_c[1] = 1;
				let _z2 = D(d1 - d3 - 1 + _c[4],  base)
				_c[2] = idiv(2 - _c[4] + D(d3 - 1,  base) + _z2 - d1, base)
				self.p1 = Concat(1,1-_c[4],0,0,1-_c[4],1)
				self.p2 = Concat(d4-1,D(d3-1,base),2-_c[2],D(d3-1,base),d4-1)
				self.p3 = Concat(base-2,_z2,base-2)
				return
			}
		} else if (D(d0 - d4 + 1,  base) == 0 && d3 != 0) {
			if (d4 != base - 1) {
				_x5[1] = ((base + d4) / 2);
				_y[1] = base + d4 - _x5[1];
				_z[1] = base - 1;
				_c[1] = idiv(_x5[1] + _y[1] + _z[1] - d0, base);
				_x5[2] = ((d3 - 1) / 2);
				_y[2] = d3 - 1 - _x5[2];
				_z[2] = D(d1 - _x5[2] - _y[2] - _c[1],  base);
				_c[2] = idiv(_x5[2] + _y[2] + _z[2] + _c[1] - d1, base);
				_x5[3] = ((1 + d2 - _c[2]) / 2);
				_y[3] = 1 + d2 - _c[2] - _x5[3]
				self.p1 = Concat(_x5[1],_x5[2],_x5[3],_x5[2],_x5[1])
				self.p2 = Concat(_y[1],_y[2],_y[3],_y[2],_y[1])
				self.p3 = Concat(_z[1],_z[2],_z[1])
				return
				
			} else {
				let _y2 = D(d1 - 3 - 1,  base) == base - 1 ? 3 : D(d1 - 3 - 1,  base) == base - 2 ? 2 : 1;
				let _x6 = d3 < _y2 ? d3 + base - _y2 : d3 - _y2;
				_c[1] = idiv(3 + _y2 + D(d1 - 3 - _y2,  base) - d1, base);
				var mu = 0;
				_c[2] = idiv(_x6 + D(d2 - _x6 - 1 - _c[1] + mu,  base) + _c[1] + 1 - d2, base);
				if (_c[2] <= 1) {} else {
					_c[2] = 1;
					mu = 1;
				}
				_c[3] = idiv(_x6 + _y2 - d3, base)
				self.p1 = Concat(1, 3 - _c[3], _x6 - mu, _x6 - mu, 3 - _c[3], 1)
				self.p2 = Concat(base - 4, _y2 - _c[2] + mu, D(d2 - _x6 - 1 - _c[1] + mu,  base), _y2 - _c[2] + mu, base - 4)
				self.p3 = Concat(1, D(d1 - 3 - _y2,  base) + _c[2] - mu + _c[3], 1);
				return
			}
		} else if (D(d0 - d4 + 1,  base) == 0 && d3 == 0) {
			if (d4 == 0) {
				if (d2 != 0) {
					let s = self.x - BigUInt(1) - BigUInt(base*base*base*base*base)
					let ps = PalindromeSplitter(p: s, base: base)
					ps.Calc()
					self.p1 = ps.p1
					self.p2 = ps.p2
					self.p3 = Concat(1,0,0,0,0,1)
					return
				} else if (d1 != 0 && d1 != base - 1) {
					let s = self.x - BigUInt(1) - BigUInt(base*base*base*base*base)
					let ps = PalindromeSplitter(p: s, base: base)
					ps.Calc()
					self.p1 = ps.p1
					self.p2 = ps.p2
					self.p3 = Concat(1,0,0,0,0,1)
					return
				} else if (d1 == 0) {
					self.p1 = Concat(1,0,0,0,0,1)
					self.p2 = Concat(base-2)
					return
				} else if (d1 == base - 1) {
					self.p1 = Concat(base - 1, 0, 1, 0, base - 1)
					self.p2 = Concat(base - 1, base - 2, base - 2, base - 1)
					self.p3 = Concat( 1, 0, 1)
					return
				}
			} else if (d4 == 1) {
				if (d2 >= 2 || d2 == 1 && d1 >= 2) {
					let _s2 = self.x - BigUInt(1 + base + base*base*base*base + base*base*base*base*base)
					let _ps3 = PalindromeSplitter(p: _s2,  base: base)
					_ps3.Calc()
					self.p1 = _ps3.p1
					self.p2 = _ps3.p2
					self.p3 = Concat(1,1,0,0,1,1)
					return
				} else if (d2 == 1 && d1 == 0) {
					self.p1 = Concat(1, 0, base - 1, base - 1, 0, 1)
					self.p2 = Concat(1, base - 1, 1)
					self.p3 = Concat(base - 2)
					return
				} else if (d2 == 1 && d1 == 1) {
					self.p1 = Concat(1, 1, 0, 0, 1, 1)
					self.p2 = Concat(base - 1, base - 1)
					return
				} else if (d2 == 0 && d1 >= 2) {
					self.p1 = Concat(1, 1, 0, 0, 1, 1)
					self.p2 = Concat(d1 - 2, d1 - 2)
					self.p3 = Concat(base - d1 + 1)
					return
				} else if (d2 == 0 && d1 == 1) {
					self.p1 = Concat(1, 0, 0, 0, 0, 1)
					self.p2 = Concat(1, 0, 0, 0, 1)
					self.p3 = Concat(base - 2)
					return
				} else if (d2 == 0 && d1 == 0) {
					self.p1 = Concat(1, 0, 0, 0, 0, 1)
					self.p2 = Concat(base - 1, base - 1, base - 1, base - 1)
					return
				}
			} else if (d4 == 2) {
				if (d2 >= 2 || d2 == 1 && d1 >= 2) {
					let _s3 = self.x - BigUInt(1 + 2 * base + 2 * base * base * base * base + base * base * base * base * base)
					let _ps4 = PalindromeSplitter(p: _s3,  base: base)
					_ps4.Calc()
					self.p1 = _ps4.p1
					self.p2 = _ps4.p2
					self.p3 = Concat(1,2,0,0,2,1)
					return
				} else if (d2 == 1 && d1 == 0) {
					self.p1 = Concat(1, 1, base - 1, base - 1, 1, 1)
					self.p2 = Concat(1, base - 2, 1)
					self.p3 = Concat(base - 1)
					return
				} else if (d2 == 1 && d1 == 1) {
					self.p1 = Concat(1, 1, base - 1, base - 1, 1, 1)
					self.p2 = Concat(1, base - 1, 1)
					self.p3 = Concat(base - 1)
					return
				} else if (d2 == 0 && d1 == 3) {
					self.p1 = Concat(1, 2, 0, 0, 2, 1)
					self.p2 = Concat(base - 1)
					self.p3 = Concat(1)
					return
				} else if (d2 == 0 && d1 > 3) {
					self.p1 = Concat(1, 2, 0, 0, 2, 1)
					self.p2 = Concat(d1 - 3, d1 - 3)
					self.p3 = Concat(base - d1 + 3)
					return
				} else if (d2 == 0 && d1 == 2) {
					self.p1 = Concat(1, 1, base - 1, base - 1, 1, 1)
					self.p2 = Concat(1, 0, 1)
					self.p3 = Concat(base - 1)
					return
				} else if (d2 == 0 && d1 == 1) {
					self.p1 = Concat(1, 0, 0, 0, 0, 1)
					self.p2 = Concat(2, 0, 0, 0, 2)
					self.p3 = Concat(base - 2)
				} else if (d2 == 0 && d1 == 0) {
					self.p1 = Concat(1, 1, base - 1, base - 1, 1, 1)
					self.p2 = Concat(base - 2, base - 2)
					self.p3 = Concat(2)
				}
			} else if (d4 == 3) {
				let _y3 = D(d1 - 1 - 1,  base) == 0 ? 3 : D(d1 - 1 - 1,  base) == base - 1 ? 2 : 1;
				_c[1] = idiv(2 + _y3 + D(d1 - 1 - _y3,  base) - d1, base);
				_c[2] = idiv(base - _y3 - 1 + D(d2 + _y3 + 2,  base) + base - 1 - d2, base)
				self.p1 = Concat(1, 0, base - _y3 - 1 - _c[1], base - _y3 - 1 - _c[1], 0, 1)
				self.p2 = Concat(2, _y3 - _c[2] + 1 + _c[1], D(d2 + _y3 + 2,  base), _y3 - _c[2] + 1 + _c[1], 2)
				self.p3 = Concat(base - 1, D(d1 - 1 - _y3,  base) + _c[2] - 1 - _c[1], base - 1)
			} else if (d4 >= 4) {
				let _y4 = D(d1 - 1 - 1,  base) == 0 ? 3 : D(d1 - 1 - 1,  base) == base - 1 ? 2 : 1;
				_c[1] = idiv(1 + _y4 + D(d1 - 1 - _y4,  base) - d1, base);
				_c[2] = idiv(base - _y4 + 1 + D(d2 + _y4 - 1,  base) - d2, base)
				self.p1 = Concat(1, 2, base - _y4 - _c[1], base - _y4 - _c[1], 2, 1)
				self.p2 = Concat(d4 - 3, _y4 - _c[2] + _c[1], D(d2 + _y4 - 1,  base), _y4 - _c[2] + _c[1], d4 - 3)
				self.p3 = Concat(1, D(d1 - 2 - _y4,  base) + _c[2] - _c[1], 1)
			}
		}
	}
	
	func Split6() {
		if d[5] == 1 {
			Split6Leading1()
			return
		}
		
		let m = 3
		
		var x : [Int] = Array(repeating: 0, count: m+2)
		var y : [Int] = Array(repeating: 0, count: m+2)
		var z : [Int] = Array(repeating: 0, count: m+2)
		var c : [Int] = Array(repeating: 0, count: m+2)
//		let (_,d1,d2,d3,d4,d5) = (d[0],d[1],d[2],d[3],d[4],d[5])
		
		x[1] = config[0][0]
		y[1] = config[1][0]
		z[1] = config[2][0]
		
		c[1] = idiv(x[1] + y[1] + z[1], base);
		x[2] = z[1] <= d[2 * m - 3] - 1 ? D(d[2 * m - 2] - y[1],  base) : D(d[2 * m - 2] - y[1] - 1,  base);
		y[2] = D(d[2 * m - 3] - z[1] - 1,  base);
		z[2] = D(d[1] - x[2] - y[2] - c[1],  base);
		c[2] = idiv(x[2] + y[2] + z[2] + c[1] - d[1], base);
		x[m] = 0;
		y[m] = D(d[m - 1] - z[m - 1] - c[m - 1],  base);
		c[m] = idiv(x[m] + y[m] + z[m - 1] + c[m - 1] - d[m - 1], base)
		
		switch c[m] {
		case 0:
			if (y[m] != 0) {
				x[m] = 1; y[m] -= 1;
			} else {
				if (y[m - 1] != 0) {
					x[m] = 1; y[m] = base - 2; y[m - 1] -= 1; z[m - 1] += 1;
				} else {
					if (z[m - 1] != 0) {
						y[m] = 1; y[m - 1] = 1;	z[m - 1] -= 1;
					} else {
						if (x[2] != 0) {
							x[2] -= 1; x[3] = base - 1;	y[2] = 1; y[3] = 1;
						} else if (x[1] == 1) {
							self.p1 = Concat(2, 0, 0, 0, 0, 2)
							self.p2 = Concat(1,1)
							self.p3 = Concat(base-4)
							return
						} else if (x[1] != 1 && y[1] != base - 1) {
							self.p1 = Concat(x[1] - 1, base - 1, 0, 0, base - 1, x[1] - 1)
							self.p2 = Concat(y[1] + 1, 0, base - 2, 0, y[1] + 1)
							self.p3 = Concat(z[1], 1, 1, z[1])
							return
						} else if (x[1] != base - 1 && z[1] == base - 1 && y[1] == base - 1) {
							self.p1 = Concat(x[1] + 1, 0, 0, 0, 0, x[1] + 1)
							self.p2 = Concat(1, 1)
							self.p3 = Concat(base - 4)
							return
						}
					}
				}
			}
		case 2:
			x[m] = 1; y[m - 1] -= 1; y[m] = base - 2; z[m - 1] = 0;
		default:
			break
		}
		
		self.p1 = Concat(x[1], x[2], x[3], x[3], x[2], x[1])
		self.p2 = Concat(y[1], y[2], y[3], y[2], y[1])
		self.p3 = Concat(z[1], z[2], z[2], z[1])
	}
	
	
	public func AlgorithmII() {
		let l = d.count
		let m = l>>1
		var x : [Int] = Array(repeating: 0, count: m+2)
		var y : [Int] = Array(repeating: 0, count: m+2)
		var z : [Int] = Array(repeating: 0, count: m+2)
		var c : [Int] = Array(repeating: 0, count: m+2)
		
		x[1] = config[0][0]
		y[1] = config[1][0]
		z[1] = config[2][0]
		
		c[1] = (x[1] + y[1] + z[1]) /  base
		x[2] = z[1] <= d[2 * m - 3] - 1 ? D(d[2 * m - 2] - y[1],  base) : D(d[2 * m - 2] - y[1] - 1,  base)
		y[2] = D(d[2 * m - 3] - z[1] - 1,  base);
		z[2] = D(d[1] - x[2] - y[2] - c[1],  base);
		c[2] = (x[2] + y[2] + z[2] + c[1] - d[1]) / base
		
		if m-1 >= 3 {
			for i in 3...m-1 {
				x[i] = z[i - 1] <= d[2 * m - i - 1] - 1 ? 1 : 0;
				y[i] = D(d[2 * m - i - 1] - z[i - 1] - 1,  base)
				z[i] = D(d[i - 1] - x[i] - y[i] - c[i - 1],  base)
				c[i] = (x[i] + y[i] + z[i] + c[i - 1] - d[i - 1]) / base
			}
		}
		x[m] = 0;
		y[m] = D(d[m - 1] - z[m - 1] - c[m - 1],  base);
		c[m] = (x[m] + y[m] + z[m - 1] + c[m - 1] - d[m - 1]) /  base
		
		if (c[m] == 1) {// II.1
			// do nothing
		} else if (c[m] == 0) {
			// II.2
			if (y[m] != 0) {
				// II.2.i
				x[m] = 1;
				y[m] -= 1;
			} else {
				// II.2.ii
				if (y[m - 1] != 0) {
					// II.2.ii.a
					x[m] = 1;
					y[m] = base - 2;
					y[m - 1] -= 1;
					z[m - 1] += 1;
				} else if (y[m - 1] == 0 && z[m - 1] != 0) {
					// II.2.ii.b
					y[m] = 1; y[m - 1] = 1; z[m - 1] -= 1;
				} else if (y[m - 1] == 0 && z[m - 1] == 0) {
					// II.2.ii.c
					x[m - 1] -= 1; x[m] = 1; y[m] = base - 4;
					y[m - 1] = base - 1; z[m - 1] = 2;
				}
			}
		} else if (c[m] == 2) {
			// II.3
			x[m] = 1; y[m - 1] -= 1; y[m] = base - 2; z[m - 1] = 0;
		}
		
		for _i2 in 1...m-1 {
			config[0][_i2 - 1] = x[_i2];
			config[0][2 * m - _i2] = x[_i2];
			config[1][_i2 - 1] = y[_i2];
			config[1][2 * m - _i2 - 1] = y[_i2];
			config[2][_i2 - 1] = z[_i2];
			config[2][2 * m - _i2 - 2] = z[_i2];
		}
		config[0][m] = x[m];
		config[0][m - 1] = x[m];
		config[1][m - 1] = y[m];
		
		for i in 0...l {
			self.p1 = self.p1 * BigUInt(base) + BigUInt(config[0][l-i])
			self.p2 = self.p2 * BigUInt(base) + BigUInt(config[1][l-i])
			self.p3 = self.p3 * BigUInt(base) + BigUInt(config[2][l-i])
		}
	}
}

public extension PalindromeSplitter {
	
	func AlgorithmIII() {
		let l = d.count
		let m = l >> 1;
		var x : [Int] = Array(repeating: 0, count: m+2)
		var y : [Int] = Array(repeating: 0, count: m+2)
		var z : [Int] = Array(repeating: 0, count: m+2)
		var c : [Int] = Array(repeating: 0, count: m+2)
		
		x[1] = config[0][1]
		y[1] = config[1][0]
		z[1] = config[2][0]
		
		c[1] = idiv(1 + y[1] + z[1], base);
		x[2] = z[1] <= d[2 * m - 3] - 1 ? D(d[2 * m - 2] - y[1],  base) : D(d[2 * m - 2] - y[1] - 1, base);
		y[2] = D(d[2 * m - 3] - z[1] - 1, base);
		z[2] = D(d[1] - x[1] - y[2] - c[1], base);
		c[2] = idiv(x[1] + y[2] + z[2] + c[1] - d[1], base)
		if m-1 >= 3 {
			for i in 3...m-1 {
				x[i] = z[i - 1] <= d[2 * m - i - 1] - 1 ? 1 : 0;
				y[i] = D(d[2 * m - i - 1] - z[i - 1] - 1,  base);
				z[i] = D(d[i - 1] - x[i - 1] - y[i] - c[i - 1],  base);
				c[i] = idiv(x[i - 1] + y[i] + z[i] + c[i - 1] - d[i - 1], base);
			}
		}
		x[m] = 0;
		y[m] = D(d[m - 1] - z[m - 1] - x[m - 1] - c[m - 1],  base);
		c[m] = idiv(x[m - 1] + y[m] + z[m - 1] + c[m - 1] - d[m - 1], base)
		
		switch c[m] {
		case 0:
			x[m] = 1
		case 2:
			if (y[m - 1] != 0) {
				if (z[m - 1] != base - 1) {
					y[m - 1] -= 1; y[m] -= 1; z[m - 1] += 1;
				} else {
					x[m] = 1; y[m - 1] -= 1; z[m - 1] = 0;
				}
			} else {
				if (z[m - 1] != base - 1) {
					x[m - 1] -= 1; y[m - 1] = base - 1;	y[m] -= 1; z[m - 1] += 1;
				} else {
					x[m - 1] -= 1; x[m] = 1; y[m - 1] = base - 1; z[m - 1] = 0;
				}
			}
		default:
			break
		}
		for _i3 in  1...m-1 {
			config[0][_i3] = x[_i3];
			config[0][2 * m - _i3] = x[_i3];
			config[1][_i3 - 1] = y[_i3];
			config[1][2 * m - _i3 - 1] = y[_i3];
			config[2][_i3 - 1] = z[_i3];
			config[2][2 * m - _i3 - 2] = z[_i3];
		}
		config[0][m] = x[m];
		config[1][m - 1] = y[m];
		
		for i in 0...l {
			self.p1 = self.p1 * BigUInt(base) + BigUInt(config[0][l-i])
			self.p2 = self.p2 * BigUInt(base) + BigUInt(config[1][l-i])
			self.p3 = self.p3 * BigUInt(base) + BigUInt(config[2][l-i])
		}
	}
}

public extension PalindromeSplitter {
	
	
	
    func AlgorithmIV() {
		let digits = self.d
		let l = digits.count;
		let m = l >> 1;
		var config = self.config
		var x : [Int] = Array(repeating: 0, count: m+2)
		var y : [Int] = Array(repeating: 0, count: m+2)
		var z : [Int] = Array(repeating: 0, count: m+2)
		var c : [Int] = Array(repeating: 0, count: m+2)
		
		x[1] = config[0][1]
		y[1] = config[1][0]
		z[1] = config[2][0]
		
		c[1] = idiv(1 + y[1] + z[1], base);
		x[2] = z[1] <= digits[2 * m - 4] - 1 ? D(digits[2 * m - 3] - y[1], base) : D(digits[2 * m - 3] - y[1] - 1, base);
		y[2] = D(digits[2 * m - 4] - z[1] - 1, base);
		z[2] = D(digits[1] - x[1] - y[2] - c[1], base);
		c[2] = idiv(x[1] + y[2] + z[2] + c[1] - digits[1], base);
		//if m-2 >= 3 {
			for i in 3 ... m-1 {
				x[i] = z[i - 1] <= digits[2 * m - i - 2] - 1 ? 1 : 0;
				y[i] = D(digits[2 * m - i - 2] - z[i - 1] - 1, base);
				z[i] = D(digits[i - 1] - x[i - 1] - y[i] - c[i - 1], base);
				c[i] = idiv(x[i - 1] + y[i] + z[i] + c[i - 1] - digits[i - 1], base);
			}
		//}
		x[m - 1] = z[m - 2] <= digits[m - 1] - 1 ? 1 : 0;
		y[m - 1] = D(digits[m - 1] - z[m - 2] - 1, base);
		z[m - 1] = D(digits[m - 2] - x[m - 2] - y[m - 1] - c[m - 2], base);
		c[m - 1] = idiv(x[m - 2] + y[m - 1] + z[m - 1] + c[m - 2] - digits[m - 2], base);
		if (x[m - 1] + c[m - 1] == 1) {// IV.1
			// do nothing
		} else if (x[m - 1] + c[m - 1] == 0 && y[m - 1] != base - 1) {
			// IV.2
			if (z[m - 1] != 0) {
				// IV.2.i
				y[m - 1] += 1; z[m - 1] -= 1;
			} else if (z[m - 1] == 0 && y[m - 1] != 0) {
				// IV.2.ii
				if (y[m - 1] != 1 && z[m - 2] != base - 1) {
					// IV.2.ii.a
					x[m - 1] = 1; y[m - 2] -= 1;
					if y[m-2] <= 0 { y[m-2] = y[m-2] + base }
					y[m - 1] -= 1;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] += 1;
					z[m - 1] += 1;
				} else if (y[m - 1] != 1 && z[m - 2] == base - 1) {
					// IV.2.ii.b
					x[m - 1] = 2; y[m - 2] -= 1;
					if y[m-2] <= 0 { y[m-2] = y[m-2] + base}
					y[m - 1] -= 2;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] = 0;
					z[m - 1] = 3;
				} else if (y[m - 1] == 1) {
					// IV.2.ii.c
					x[m - 1] = 1; y[m - 2] -= 1;
					if y[m-2] <= 0 { y[m-2] = y[m-2] + base}
					y[m - 1] = base - 1;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] = 0; z[m - 1] = 3;
				}
			} else if (z[m - 1] == 0 && y[m - 2] == 0) {
				// IV.2.iii
				if (z[m - 2] != base - 1) {
					// IV.2.iii.a
					x[m - 2] -= 1; x[m - 1] = 1; y[m - 2] = base - 1;
					y[m - 1] -= 1; z[m - 2] += 1; z[m - 1] = 1;
				} else if (z[m - 2] == base - 1 && y[m - 1] != 1) {
					// IV.2.iii.b
					x[m - 2] -= 1; x[m - 1] = 2; y[m - 2] = base - 1; y[m - 1] -= 2;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] = 0; z[m - 1] = 3;
				} else if (z[m - 1] == base - 1 && y[m - 1] == 1) {
					// IV.2.iii.c
					x[m - 2] -= 1; x[m - 1] = 1; y[m - 2] = base - 1; y[m - 1] = base - 1;
					z[m - 2] = 0; z[m - 1] = 3;
				}
			}
		} else if (x[m - 1] + c[m - 1] == 0 && y[m - 1] == base - 1) {
			// IV.3
			x[m - 1] = 1; y[m - 2] -= 1;
			if y[m-2] <= 0 { y[m-2] = y[m-2] + base}
			y[m - 1] = base - 2; z[m - 2] += 1;	z[m - 1] = 1;
		} else if (x[m - 1] + c[m - 1] == 2 && x[m - 1] == 0 && c[m - 1] == 2) {
			// IV.4
			if (z[m - 1] != base - 1) {
				// IV.4.i
				y[m - 1] -= 1;
				if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
				z[m - 1] += 1;
			} else if (z[m - 1] == base - 1 && z[m - 2] != base - 1) {
				// IV.4.ii
				if (y[m - 2] != 0) {
					// IV.4.ii.a
					x[m - 1] = 1;
					y[m - 2] -= 1;
					if y[m-2] <= 0 { y[m-2] = y[m-2] + base}
					y[m - 1] -= 2;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] += 1;
					z[m - 1] = 1;
				} else if (y[m - 2] == 0) {
					//IV.4.ii.b
					x[m - 2] -= 1; x[m - 1] = 1; y[m - 2] = base - 2; y[m - 1] -= 2;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] += 1; z[m - 1] = 1;
				}
			} else if (z[m - 1] == base - 1 && z[m - 2] == base - 1) {
				// IV.4.iii
				if (y[m - 1] < base - 2) {
					// IV.4.iii.a
					if (y[m - 2] != base - 1) {
						x[m - 2] -= 1; x[m - 1] = base - 2;	y[m - 2] += 1;
						y[m - 1] += 2;	z[m - 2] = base - 2; z[m - 1] = base - 2;
					} else {
						x[m - 1] = base - 2; y[m - 2] = 0;	y[m - 1] += 2;
						z[m - 2] = base - 2; z[m - 1] = base - 2;
					}
				} else {
					// IV.4.iii.b
					if (y[m - 2] >= 1) {
						x[m - 1] = 2;
						y[m - 2] -= 1;
						if y[m-2] <= 0 { y[m-2] = y[m-2] + base}
						y[m - 1] -= 3;
						if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
						z[m - 2] = 0;
						z[m - 1] = 3;
					} else {
						x[m - 2] -= 1;
						x[m - 1] = 2;
						y[m - 2] = base - 1;
						y[m - 1] -= 3;
						z[m - 2] = 0;
						z[m - 1] = 3;
					}
				}
			}
		} else if (x[m - 1] + c[m - 1] == 2 && x[m - 1] == 1 && c[m - 1] == 1) {
			if (z[m - 1] != base - 1 && y[m - 1] != 0) {
				y[m - 1] -= 1;
				if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
				z[m - 1] += 1;
			} else if (z[m - 1] != base - 1 && y[m - 1] == 0) {
				x[m - 1] = 0;
				y[m - 1] = base - 1;
				z[m - 1] += 1;
			} else if (z[m - 1] == base - 1 && z[m - 2] != 0) {
				if (y[m - 2] != base - 1) {
					x[m - 1] = 0; y[m - 2] += 1; y[m - 1] += 1;	z[m - 2] -= 1;
					if z[m-2] <= 0 { z[m-2] = z[m-2] + base}
					z[m - 1] = base - 2;
				} else if (y[m - 2] == base - 1 && y[m - 1] > 1) {
					x[m - 1] = 2; y[m - 2] = base - 2; y[m - 1] -= 2; z[m - 2] += 1; z[m - 1] = 1;
				} else if (y[m - 2] == base - 1 && y[m - 1] == 0) {
					y[m - 2] = base - 2; y[m - 1] = base - 2; z[m - 2] += 1; z[m - 1] = 1;
				} else if (y[m - 2] == base - 1 && y[m - 1] == 1) {
					y[m - 2] = base - 2; y[m - 1] = base - 1; z[m - 2] += 1; z[m - 1] = 1;
				}
			} else if (z[m - 1] == base - 1 && z[m - 2] == 0 && y[m - 2] != 0) {
				if (y[m - 1] > 1) {
					x[m - 1] = 2; y[m - 2] -= 1; y[m - 1] -= 2;	z[m - 2] = 1; z[m - 1] = 1;
				} else if (y[m - 1] == 0) {
					y[m - 2] -= 1; y[m - 1] = base - 2;	z[m - 2] = 1; z[m - 1] = 1;
				} else if (y[m - 1] == 1) {
					y[m - 2] -= 1; y[m - 1] = base - 1;	z[m - 2] = 1; z[m - 1] = 1;
				}
			} else if (z[m - 1] == base - 1 && z[m - 2] == 0 && y[m - 2] == 0) {
				if (y[m - 1] > 1) {
					x[m - 2] -= 1; x[m - 1] = 2; y[m - 2] = base - 1; y[m - 1] -= 2;
					if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
					z[m - 2] = 1; z[m - 1] = 1;
				} else if (y[m - 1] == 0) {
					x[m - 2] -= 1; y[m - 2] = base - 1;
					y[m - 1] = base - 2;
					z[m - 2] = 1; z[m - 1] = 1;
				} else if (y[m - 1] == 1) {
					x[m - 2] -= 1; y[m - 2] = base - 1; y[m - 1] = base - 1;
					z[m - 2] = 1; z[m - 1] = 1;
				}
			}
		} else if (x[m - 1] + c[m - 1] == 3) {
			y[m - 1] -= 1;
			if y[m-1] <= 0 { y[m-1] = y[m-1] + base}
			z[m - 1] = 0;
		}
		
		for _i4 in 1 ... m-1 {
			config[0][_i4] = x[_i4];
			config[0][2 * m - 1 - _i4] = x[_i4];
			config[1][_i4 - 1] = y[_i4];
			config[1][2 * m - 2 - _i4] = y[_i4];
			config[2][_i4 - 1] = z[_i4];
			config[2][2 * m - 3 - _i4] = z[_i4];
		}
		
		for k in 0...2 {
			for j in 0...l {
				if config[k][j] < 0 { config[k][j] += base }
				if config[k][j] >= base { config[k][j] -= base }
			}
		}
		
		var i = 0
		while i <= l
		{
			self.p1 = self.p1 * BigUInt(base) + BigUInt(config[0][l-i])
			self.p2 = self.p2 * BigUInt(base) + BigUInt(config[1][l-i])
			self.p3 = self.p3 * BigUInt(base) + BigUInt(config[2][l-i])
			i = i + 1
		}
		if self.p1 + self.p2 + self.p3 < self.x {
			let dif = self.x - self.p1 - self.p2 - self.p3
			if (self.p1 + dif).isPalindromic(base: self.base) {
				self.p1 = self.p1 + dif
			} else if (self.p2 + dif).isPalindromic(base: self.base) {
				self.p2 = self.p2 + dif
			} else if (self.p3 + dif).isPalindromic(base: self.base) {
				self.p3 = self.p3 + dif
			}
		}
		if self.p1 + self.p2 + self.p3 > self.x {
			let dif = self.p1 + self.p2 + self.p3 - self.x
			if (self.p1 - dif).isPalindromic(base: self.base) {
				self.p1 = self.p1 - dif
			} else if (self.p2 - dif).isPalindromic(base: self.base) {
				self.p2 = self.p2 - dif
			} else if (self.p3 + dif).isPalindromic(base: self.base) {
				self.p3 = self.p3 - dif
			}
		}
//		print(String(self.p1))
//		print(String(self.p2))
//		print(String(self.p3))
//		if p1 + p2 + p3 != self.x  {
//			print("Sum false")
//		}
//		if !p1.isPalindromic(base: self.base) {
//			print("error1") }
//		if !p2.isPalindromic(base: self.base) {
//			print("error2") }
//		if !p3.isPalindromic(base: self.base) {
//			print("error3") }
	}
	
	func AlgorithmV() {
		let l = d.count;
		let m = l >> 1;
		
		var gpot = BigUInt(1)
		for _ in 1...m-1 {
			gpot = gpot * BigUInt(self.base)
		}
		
		let s = gpot + gpot * BigUInt(self.base)
		var n = self.x - s
		
//		print("n = \(self.x) n' = \(n)")
		let nsplit1 = PalindromeSplitter(p: n,  base: self.base)
		nsplit1.Calc()
		self.p2 = nsplit1.p2
		self.p3 = nsplit1.p3
		self.p1 = nsplit1.p1 + s
		
		var testpalindromic = (self.p1).isPalindromic(base: base)
		if testpalindromic { return }
		
		n = n - s
		let nsplit2 = PalindromeSplitter(p: n,  base: self.base)
		nsplit2.Calc()
		self.p2 = nsplit2.p2
		self.p3 = nsplit2.p3
		self.p1 = nsplit2.p1 + 2*s
		
		testpalindromic = (self.p1).isPalindromic(base: base)
		if testpalindromic { return }
		
		let nsplit3 = PalindromeSplitter(p: n,  base: self.base, esjot2 : true)
		nsplit3.Calc()
		self.p2 = nsplit3.p2
		self.p3 = nsplit3.p3
		self.p1 = nsplit3.p1 + 2*s
		
		testpalindromic = (self.p1).isPalindromic(base: base) && (self.p3).isPalindromic(base: base)
		if testpalindromic { return }
		
		n = n + s
		let nsplit4 = PalindromeSplitter(p: n,  base: self.base, esjot2 : true)
		nsplit4.Calc()
		self.p2 = nsplit4.p2
		self.p3 = nsplit4.p3
		self.p1 = nsplit4.p1 + s
		
		testpalindromic = (self.p1).isPalindromic(base: base) && (self.p3).isPalindromic(base: base)
		if testpalindromic { return }

		
		assert(false)
	}
		
}

