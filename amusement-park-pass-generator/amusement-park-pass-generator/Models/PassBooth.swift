//
//  PassBooth
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct PassBooth {
    func assignPass(to entrant: Entrant) {
        var entrant = entrant
        
        if entrant.isValidEntrant() {
            entrant.accessPass = Pass(for: entrant)
        }
        
        if let pass = entrant.accessPass {
            print(pass)
        }
    }
}
