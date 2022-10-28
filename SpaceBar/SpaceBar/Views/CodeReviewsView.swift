//
//  PullRequestsView.swift
//  SpaceBar
//
//  Created by Pavel Makhov on 2022-10-06.
//

import SwiftUI
import SkeletonUI

struct CodeReviewsView: View {
    var model: Model
    
    var body: some View {
        VStack {
            SkeletonList(with: model.codeReviews, quantity: 3) { loading, codeReview in
                CodeReviewView(codeReview: codeReview, loading: loading)
            }
            .onAppear{
//                model.getCodeReviews()
            }
        }
    }
}

struct CodeReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        CodeReviewsView(model: Model())
    }
}
