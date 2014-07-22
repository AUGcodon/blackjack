def calculate_total(cards) #[["3", "Hearts"], ["4", "Spades"]]
	arr = cards.map{|e| e[0]}

	total = 0
	arr.each do |value|
		if value == "Ace"
			total += 11
			#can you put correction for aces as a sub if?
		elsif value.to_i == 0 #Jack, queen, king
			total += 10
		else
			total += value.to_i
		end
	end

#correct for aces that make total go over 21
arr.select {|e| e == "Ace"}.count.times do #select- only looking for condition of some sort, doesnt affect array
	total -= 10 if total > 21
end
	total
end


#start game

puts "Welcome to Blackjack!"

suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
#keep cards and suits as strings so can multiple together without converting later i.e. when adding 
#final score

deck = cards.product(suits)
#product function on arrays gives product of every combo of arrays being multiplied, 
#cards.product(suits) will give you combos of 2Hearts etc, if you do suits.product(cards)
#then it will give Hearts2, so prefer first method order

deck.shuffle!

#! after method means bang, bang mutates a variable from then on in coding 
#shuffle! function randomly sorts array

#setting up cards:

mycards = []
dealercards = [] 

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop
#<< appends into array
#pop function perm removes last variable in array until restart program

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)
#calculate total will be a defined method


#show cards:

puts "Dealer's top card is: #{dealercards[0]}"
puts "Your hand has: #{mycards} for a total of #{mytotal}"
puts ""

#player turn


if mytotal ==21
	puts "Congrats, you won!"
	exit
end

#dont know how many times user will hit so make indefinite loop 
while mytotal < 21
	puts "What would you like to do? Press 1 for hit and 2 for stay"
	hit_or_stay = gets.chomp
	
	if !["1", "2"].include?(hit_or_stay)
		puts "Error: you must enter 1 or 2"
		next
	end

	if hit_or_stay == "2"
		puts "you chose to stay."
		break
	end

	new_card = deck.pop
	puts "dealing card to player: #{new_card}"
	mycards << new_card
	mytotal = calculate_total(mycards)
	puts "Your total is now: #{mytotal}"

	if mytotal == 21
		puts "You won Blackjack!"
		exit
	elsif mytotal > 21
		puts "Sorry, you busted!"
		exit
	end
end

# Dealer turn
if dealertotal == 21
	puts "Sorry, dealer hit blackjack, you lose!"
	exit
end

while dealertotal < 17
	#has to hit
	new_card = deck.pop
	puts "Dealing new card for the dealer: #{new_card}"
	dealercards << new_card
	dealertotal = calculate_total(dealercards)
	puts "The dealer is #{dealertotal}"

	if dealertotal == 21
		puts "Dealer won, sorry"
		exit
	elsif dealertotal > 21
		puts "congrats, dealer busted, you win!"
		exit
	end
end

#compare hands

puts "dealer's cards are: "
dealercards.each do |card|
	puts "=> #{card}"
end

puts ""

puts "your cards are: "
mycards.each do |card|
	puts "=> #{card}"
end

if dealertotal > mytotal
	puts "sorry dealear won"
elsif dealertotal < mytotal
	puts "Congrats, you won!"
else
	puts "It's a tie!"
end








