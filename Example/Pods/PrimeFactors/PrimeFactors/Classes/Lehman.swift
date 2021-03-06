//
//  FermatFactor.swift
//  PrimeBase
//
//  Created by Stephan Jancar on 28.11.16.
//  Copyright © 2016 esjot. All rights reserved.
//

import Foundation
import BigInt

public class PrimeFactorLehman : PFactor {
	public func GetFactor(n: BigUInt, cancel: CalcCancelProt?) -> BigUInt {
		return Lehman(n: n, cancel: cancel)
	}
	
	private var sieve : PrimeSieve!
	private var trial : TrialDivision!
	var stopped = false
	var skipTrialDivision = false
	
	public init () {
		sieve = PSieve.shared
		trial = TrialDivision()
	}
	public init( sieve : PrimeSieve, cancel : CalcCancelProt) {
		self.sieve = sieve
		trial = TrialDivision(sieve: sieve)
	}
	
	private func IsCancelled(prot: CalcCancelProt?) -> Bool {
		return prot?.IsCancelled() ?? false
	}
	
	func Lehman(n: BigUInt,cancel : CalcCancelProt?) -> BigUInt
	{
		stopped = false
		if n <= 2 { return n }
		//let n64 = UInt64(n)
		var q : BigUInt = 1
		if !self.skipTrialDivision {
			q = LehmanStep1(n: n, cancel: cancel)
		}
		if q > 1 { return BigUInt(q) }
		if n < BigUInt(UInt64.max) {
			let q64 = LehmanStep2(n: UInt64(n),cancel: cancel)
			q = BigUInt(q64)
		} else {
			q = LehmanStep2Big(n: n, cancel: cancel)
		}
		return BigUInt(q)
	}
	
	private func LehmanStep1(n: BigUInt,cancel : CalcCancelProt?)  ->  BigUInt {
		let upto = n.iroot3()
		let divisor = trial.BigTrialDivision(n: n, upto: upto, cancel: cancel)
		return divisor
	}
	
	private func LehmanStep2(n: UInt64, cancel : CalcCancelProt?) -> UInt64 {
		let n3 = n.iroot3()
		let n6 = n3.squareRoot()
		
		for k in 1...n3 {
			if cancel?.IsCancelled() ?? false { return 0 }
			let rk = k.squareRoot()
			let rkn = (k*n).squareRoot()
			
			let amin = 2*rkn - 1
			var amax = n6 / 4 / rk
			amax = 1 + 2 * rkn + amax
			
			for a in amin...amax {
				
				if cancel?.IsCancelled() ?? false { return 0 }
				
				//Converting to 128 bit
				let a_128 = UInt128(a)
				let k_128 = UInt128(k)
				let n_128 = UInt128(n)
				
				// a^2 - 4 kn
				let a2 = a_128 * a_128
				let kn4 = k_128 * n_128 * UInt128(4)
				
				if kn4 > a2 {
					//This case can occure, because you should use the ceil of the root in amin
					//But i use the floor
					continue
				}
				let y = a2 - kn4
				let ry = y.squareRoot()
				
				//Perfect Square ?
				if ry * ry == y {
					let c = a + UInt64(ry)
					
					let d = c.greatestCommonDivisor(with: n)
					if (d != 1) { return d }
				}
			}
		}
		return 1
	}
	
	private func LehmanStep2Big(n: BigUInt, cancel: CalcCancelProt?) -> BigUInt {
		let n3 = n.iroot3()
		let n6 = n3.squareRoot()
		for k in 1...n3 {
			if cancel?.IsCancelled() ?? false { return 0 }
			let rk = k.squareRoot()
			let rkn = (k*n).squareRoot()
			let amin = 2*rkn - 1
			var amax = n6 / 4 / rk
			amax = 1 + 2 * rkn + amax
			for a in amin...amax {
				if cancel?.IsCancelled() ?? false { return 0 }
				let a2 = a*a
				let kn4 = k*n*4
				if kn4 > a2 {
					//This case can occure, because you should use the ceil of the root in amin
					//But i use the floor
					continue
				}
				let y = a2 - kn4
				let ry = y.squareRoot()
				
				//Perfect Square ?
				if ry * ry == y {
					let c = a + ry
					let d = c.greatestCommonDivisor(with: n)
					if (d != 1) { return d }
				}
			}
		}
		return  1
	}
}
