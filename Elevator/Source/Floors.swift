import Foundation

// https://elevation.fandom.com/wiki/Floor_numbering
/*
 **Ground floor**
 BG (Dutch): begane grond (lit. "walked-upon ground")
 BV (Swedish): Bottenvåning ("ground floor")
 D (Indonesia): dasar/lantai dasar ("ground floor")
 E(G) (Germany): Erdgeschoss ("ground floor"), (Swedish): Entrévåning ("Entrance floor")
 PB (Spain): planta baja or planta baixa ("bottom floor")
 PT (Italy): piano terra (lit. "ground floor")
 RC (France): rez-de-chaussée ("street level"), (Portuguese): rés-do-chão ("ground floor")[3]
 S (Danish): Stuen ("ground floor")
 T (Brazil): Térreo (Ground)
 P, PK (Finland) Pohjakerros ("ground floor")
 כ (Israel): כניסה ("Entrance")
 ק (Israel): קרקע ("Ground")
 ι (Greece): ισόγειο ("ground floor")
 F (Hungary): Földszint ("ground level")
 P (Poland, Czech Reand Slovakia): Parter (Polish), Přízemí (Czech), Prízemie (Slovak)
 */

final class Floor {
    let type: FloorType?
    var number: Int?
    private var _next: Floor?
    var next: Floor? {
        set {
            _next = ConditionChecker.can(floor: newValue, beAddedTo: previous)
            ? newValue
            : nil
        }
        get { return _next }
    }
    var previous: Floor? = nil
    var debugDescription: String { type?.abbreviation ?? "\(number!)" }
    
    init(_ type: FloorType) {
        self.type = type
        self.number = nil
    }
    
    init(_ number: Int) {
        self.number = number
        self.type = nil
    }
}

struct ConditionChecker {
    
    //NSLocale.current.identifier
    static func can(floor: Floor?, beAddedTo prevFloor:Floor?) -> Bool {
        guard var prevFloor = prevFloor else { return true }
        guard let floor = floor else { return true }
        // we can't have 2 Ground floors
        // or roof on top of the basement
        // or smth on top of the roof
        if floor.type == prevFloor.type && floor.type == .ground ||
            prevFloor.type == .basement && floor.type == .roof ||
            prevFloor.type == .roof {
            return false
        }
        // we can't add parking if we have some already
        if floor.type == .parking {
            while let previous = prevFloor.previous {
                if previous.type == .parking {
                    print("second parking can't be added")
                    return false
                }
                prevFloor = previous
            }
        }
        return true
    }
}

enum FloorType: String {
    case additional,
         basement,
         ground,
         lobby,
         mezzanine,
         parking,
         roof
    
    var abbreviation: String {
        switch self {
        //Floor numbers ending with A are usually used to depict an extra floor or split levels, such as 3A being an additional third floor.
        case .additional: return "A"
        //B also known as basement, usually used to depict floors below ground floor. It is widely used in most buildings. An additional basement below is often marked as LB (lower basement) or SB (sub-basement) while above is UB (upper basement)
        case .basement: return "B"
        //G or GF usually means ground floor. This floor numbering is widely used in buildings using European scheme. In some case, the letter G may be replaced into zero (0) in Europe or one (1) in America.
        case .ground: return "G"
        case .lobby: return "L"
        case .mezzanine: return "M"
        case .parking: return "P"
        case .roof: return "R"
        }
    }
}
