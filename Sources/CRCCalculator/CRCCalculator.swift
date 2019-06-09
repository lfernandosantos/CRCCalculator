
//  Created by Luiz Fernando dos Santos on 09/06/19.
//  Copyright © 2019 Luiz Fernando dos Santos. All rights reserved.
//

enum CRCType {
    case MODBUS
    case ARC
    case XMODEM
}

public class CRCCalc {
    
    
    public func calculate(type: CRCType, bytes: [UInt8]) -> UInt16? {
        switch type {
        case .ARC:
            return crcArcModbus(bytes, type: .ARC)
        case .MODBUS:
            return crcArcModbus(bytes, type: .MODBUS)
        case .XMODEM:
            return crcXModem(bytes: bytes)
        }
    }
    
    
    private func crcXModem( bytes: [UInt8]) -> UInt16 {
        var crc: UInt16 = 0x0000          // initial value
        let polynomial: UInt16 = 0x1021   // 0001 0000 0010 0001  (0, 5, 12)
        
        for by in bytes {
            
            for i in 0..<8 {
                let bit = ((by  >> (7-i) & 1) == 1)
                let c15 = ((crc >> 15    & 1) == 1)
                
                crc <<= 1
                
                if (c15 != bit) {
                    crc ^= polynomial
                }
            }
            crc &= 0xffff
        }
        
        return crc
    }
    
    
    private func crcArcModbus(_ data: [UInt8], type: CRCType) -> UInt16? {
        if data.isEmpty {
            return nil
        }
        let polynomial: UInt16 = 0xA001 // A001 is the bit reverse of 8005
        var accumulator: UInt16
        // set the accumulator initial value based on CRC type
        if type == .ARC {
            accumulator = 0
        }
        else {
            // default to MODBUS
            accumulator = 0xFFFF
        }
        // main computation loop
        for byte in data {
            var tempByte = UInt16(byte)
            for _ in 0 ..< 8 {
                let temp1 = accumulator & 0x0001
                accumulator = accumulator >> 1
                let temp2 = tempByte & 0x0001
                tempByte = tempByte >> 1
                if (temp1 ^ temp2) == 1 {
                    accumulator = accumulator ^ polynomial
                }
            }
        }
        return accumulator
    }
}
