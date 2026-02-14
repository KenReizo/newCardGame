local M = {}

Card = require("cards.Card")
CardsP1 = require("cards.Player1Cards")

M.deck = {}
M.hand = {}
M.discardPile = {}
M.heldCard = nil
M.hoverdCard = nil

function M.update()
    local mx, my = love.mouse.getPosition()

    M.hoverdCard = nil
    for _, card in ipairs(CM.hand) do
        if card:cardHover(mx, my) then
            M.hoverdCard = card
        end
    end
    if not M.heldCard and love.mouse.isDown(1) then
        M.heldCard = M.hoverdCard
    end
    if M.heldCard then
        if mx >= 0 and mx <= Screen.width
            and my >= 0 and my <= Screen.height then
            M.heldCard.x = mx - M.heldCard.width / 2
            M.heldCard.y = my - M.heldCard.height / 2
        end
    end
end

function M.shuffleTable(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

function M.shuffledCopy(t)
    local copy = {}
    for _, v in ipairs(t) do
        table.insert(copy, v)
    end
    M.shuffleTable(copy)
    return copy
end

function M.createDeck()
    local deck = {}
    for i = 1, 10, 1 do
        if i <= 5 then
            deck[i] = CardsP1.AttackCard(10, 400)
        elseif i >= 6 then
            deck[i] = CardsP1.BlockCard(10, 400)
        end
    end
    deck[10] = CardsP1.AddManaCard(10, 400)
    deck[11] = CardsP1.DrawCardCard(10, 400)
    return deck
end

function M.drawCard(amount, from, to)
    if amount > #from then
        M.discardHand(M.discardPile, M.deck)
    end
    amount = math.min(amount, #from)
    for i = amount, 1, -1 do
        local card = table.remove(from, i)
        table.insert(to, card)
    end
end

function M.discardHand(hand, discardPile)
    for i = #hand, 1, -1 do
        local card = hand[i]
        if card.discard then
            table.remove(hand, i)
            table.insert(discardPile, card)
        end
    end
end

function M.cardToTable(card, from, to)
    for i = #from, 1, -1 do
        if card == from[i] then
            local c = from[i]
            table.remove(from, i)
            table.insert(to, c)
        end
    end
end

return M
