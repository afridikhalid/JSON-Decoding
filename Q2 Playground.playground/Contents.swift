import UIKit


struct Data: Decodable {
    let data: String
    let keys: [Key]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(String.self, forKey: .data)
        
        self.keys = try! JSONDecoder().decode([Key].self, from: self.data.data(using: .utf8)!)
    }
    
    // MARK: - Calculated properties
    var agesGreaterthanOrEqualTo50: Int {
        let ages: [Key] = keys.compactMap { (key) -> Key? in
            key.age >= 50 ? key : nil
        }
        return ages.count
    }
    
}


struct Key: Decodable {
    let key: String
    let age: Int
}


let JSON = """
{ "data": "[{\\"key\\": \\"tk-18\\", \\"age\\":34},{\\"key\\":\\"tk-32\\",\\"age\\":49},{\\"key\\":\\"ab-12\\",\\"age\\":60},{\\"key\\":\\"ab-43\\",\\"age\\":50},{\\"key\\":\\"tk-33\\",\\"age\\":75},{\\"key\\":\\"tkAB\\",\\"age\\":79},{\\"key\\":\\"tk-AG\\",\\"age\\":45}]" }
"""

let data = try! JSONDecoder().decode(Data.self, from: JSON.data(using: .utf8)!)


print(data.agesGreaterthanOrEqualTo50)
