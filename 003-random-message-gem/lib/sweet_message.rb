require "awesome_print"

QUOTES = [
	"I'm on a whiskey diet. I've lost three days already.",
	"I put my phone in airplane mode, but it’s not flying!",
	"Why don't scientists trust atoms? Because they make up everything!",
	"I'm not arguing, I'm just explaining why I'm right.",
	"I'm on a seafood diet. I see food and I eat it.",
	"My bed is a magical place where I suddenly remember everything I forgot to do.",
	"I told my computer I needed a break, and now it won't stop sending me Kit-Kats.",
	"Of course I talk to myself. Sometimes I need expert advice.",
	"I don't need a hair stylist, my pillow gives me a new hairstyle every morning.",
	"I could agree with you, but then we’d both be wrong."
]

class SweetMessage
	def self.show
		random_element = QUOTES.sample
		ap random_element
	end
end