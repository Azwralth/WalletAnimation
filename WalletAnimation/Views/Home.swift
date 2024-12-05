//
//  Home.swift
//  WalletAnimation
//
//  Created by Владислав Соколов on 04.12.2024.
//

import SwiftUI

struct Home: View {
    let size: CGSize
    let safeAreaInsets: EdgeInsets
    
    @State private var showDetailView = false
    @State private var selectedCard: Card?
    
    @Namespace private var animation
    
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Text("My Wallet")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image(.pic)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                        }
                        
                    }
                    .blur(radius: showDetailView ? 5 : 0)
                    .opacity(showDetailView ? 0 : 1)
                
                let mainOffset = CGFloat(cards.firstIndex(where: { $0.id == selectedCard?.id }) ?? 0) * -size.width
                
                LazyVStack(spacing: 10) {
                    ForEach(cards) { card in
                        let cardOffset = CGFloat(cards.firstIndex(where: { $0.id == card.id }) ?? 0) * size.width
                        
                        CardView(card)
                            .frame(width: showDetailView ?  size.width : nil)
                            .visualEffect { [showDetailView] content, proxy in
                                content
                                    .offset(x: showDetailView ? cardOffset : 0, y: showDetailView ? -proxy.frame(in: .scrollView).minY : 0)
                            }
                    }
                }
                .padding(.top, 25)
                .offset(x: showDetailView ? mainOffset : 0)
            }
            .safeAreaPadding(15)
            .safeAreaPadding(.top, safeAreaInsets.top)
        }
        .scrollDisabled(showDetailView)
        .scrollIndicators(.hidden)
        .overlay {
            if let selectedCard, showDetailView {
                DetailView(selectedCard: selectedCard)
                    .padding(.top, expandedCardHeight)
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        ZStack {
            Rectangle()
                .fill(card.color.gradient)
            
            VStack(alignment: .leading, spacing: 15) {
                if !showDetailView {
                    CardImageView(card.cardGeometryId, height: 70)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.number)
                        .font(.caption)
                        .foregroundStyle(.white.secondary)
                    
                    Text(card.balance)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: showDetailView ? .center : .leading)
                .overlay {
                    ZStack {
                        if showDetailView {
                            CardImageView(card.cardGeometryId, height: 30)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(y: 35)
                        }
                        
                        if let selectedCard, selectedCard.id == card.id, showDetailView {
                            Button {
                                withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                    self.selectedCard = nil
                                    showDetailView = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17).bold())
                                    .foregroundStyle(.white)
                                    .contentShape(.rect)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                        }
                    }
                }
                .padding(.top, showDetailView ? safeAreaInsets.top - 10 : 0)
                
                HStack {
                    Text("Expires: \(card.expires)")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("Name")
                        .font(.callout)
                    
                }
                .foregroundStyle(.white.secondary)
                
            }
            .padding(showDetailView ? 15 : 25)
        }
        .frame(height: showDetailView ? expandedCardHeight : nil)
        .frame(height: 200, alignment: .top)
        .clipShape(.rect(cornerRadius: showDetailView ? 0 : 25))
        .onTapGesture {
            guard !showDetailView else { return }
            withAnimation(.smooth(duration: 0.6, extraBounce: 0)) {
                selectedCard = card
                showDetailView = true
            }
        }
    }
    
    @ViewBuilder
    func CardImageView(_ id: String, height: CGFloat) -> some View {
        Image(.master)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: id, in: animation)
            .frame(height: height)
            .offset(x: showDetailView ? -18 : -37)
    }
    
    var expandedCardHeight: CGFloat {
        safeAreaInsets.top + 130
    }
}

struct DetailView: View {
    let selectedCard: Card
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...20, id: \.self) { item in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(color: .gray, radius: 2, x: 1, y: 2)
                        .frame(height: 80)
                        .padding(.top, 3)
                        .overlay {
                            HStack {
                                Circle()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.gray.opacity(0.2))
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 15)
                                
                                VStack(spacing: 5) {
                                    ForEach(1...3, id: \.self) { index in
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: index == 1 ? 250 : 250 - CGFloat((index - 1) * 100), height: 10)
                                            .offset(x: index == 1 ? 0 : CGFloat((index - 1) * -50))
                                            .foregroundStyle(.gray.opacity(0.2))
                                    }
                                }
                                .padding()
                                .offset(x: -20)
                            }
                            
                        }
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    ContentView()
}
