require 'sequel'

Sequel.migration do

	up do 
	
		self[:users].insert(:id=>1,:username=>'test1', :email=>'test1@email.com', :passwd=>'pass1')
		self[:users].insert(:id=>2,:username=>'test2', :email=>'test2@email.com', :passwd=>'pass2')
		self[:users].insert(:id=>3,:username=>'test3', :email=>'test3@email.com', :passwd=>'pass3')

		self[:movies].insert(:id=>1,:title=>'The Godfather', 
					:synopsis=>'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 
					:url_image=>'http://pics.filmaffinity.com/The_Godfather-485345341-main.jpg',
					:year=>1972,
					:category=>'Crime',
					:user_id=>1)
					
		self[:movies].insert(:id=>2,:title=>'The Dark Knight',
					:synopsis=>'When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level.',
					:url_image=>'http://pics.filmaffinity.com/The_Dark_Knight-102763119-main.jpg',
					:year=>2008,
					:category=>'Action',
					:user_id=>2)					

		self[:movies].insert(:id=>3,:title=>'Fight Club',
					:synopsis=>'An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...',
					:url_image=>'http://pics.filmaffinity.com/Fight_Club-320750671-main.jpg',
					:year=>1999,
					:category=>'Drama',
					:user_id=>3)					
					
		self[:movies].insert(:id=>4, 
			:title=> 'The Avengers',
			:synopsis=> "Nick Fury is director of S.H.I.E.L.D, an international peace keeping agency. The agency is a who's who of Marvel Super Heroes, with Iron Man, The Incredible Hulk, Thor, Captain America, Hawkeye and Black Widow. When global security is threatened by Loki and his cohorts, Nick Fury and his team will need all their powers to save the world from disaster.",
			:url_image=> 'http://pics.filmaffinity.com/The_Avengers-965206445-main.jpg',
			:year=> 2012,
			:category=>'Fantasy',
			:user_id=>1)
			
		self[:movies].insert(:id=>5, 
			:title=> 'Pulp Fiction',
			:synopsis=> 'The film interweaves three tales, told in a circular, fractured manner, which only fully connect by the time the final credits roll. The first story focuses on Vincent Vega (John Travolta) and Jules Winnfield (Samuel L. Jackson), two hit men on duty for "the big boss," Marsellus Wallace (Ving Rhames), whose gorgeous wife, Mia (Uma Thurman), takes a liking to Vincent. In the second, a down-and-out pugilist (Bruce Willis), who is ordered to take a fall, decides that there’s more money in doing the opposite. The final chapter follows a pair of lovers (Amanda Plummer and Tim Roth) as they prepare to hold up a diner.',
			:url_image=> 'http://pics.filmaffinity.com/Pulp_Fiction-740215304-main.jpg',
			:year=> 1994,
			:category=>'Thriller',
			:user_id=>2)
			
		self[:movies].insert(:id=>6, 
			:title=> 'The Great Dictator',
			:synopsis=> 'Charlie Chaplin has a dual role in this film, his first with dialogue. He plays a sweet-natured Jewish barber and a murderous Hitler-type dictator with such satirical impact that it counterbalanced the oratory of Adolf Hitler. Particularly delectable comic scenes are Hynkel\'s balletic "pas de deux" with a globe, and a cream cake fight between Hynkel and Napoloni, the dictator of Bacteria.',
			:url_image=> 'http://pics.filmaffinity.com/The_Great_Dictator-316529814-main.jpg',
			:year=>1940,
			:category=>'Comedy',
			:user_id=>3)
			
		self[:movies].insert(:id=>7, 
			:title=> 'The Shawshank Redemption',
			:synopsis=> 'Andy Dufresne (Tim Robbins) is sentenced to two consecutive life terms in prison for the murders of his wife and her lover in the late 1940s. However, only Andy knows that he didn’t commit the crimes. Sent to Shawshank Prison to do hard time, Andy—a taciturn banker in the outside world, has to learn to get by in the brutal, cutthroat confines of prison life. His quiet strength slowly earns the respect of his fellow inmates -most notably, Red (Morgan Freeman) -and even much of the prison staff. But Andy’s seemingly stoic acceptance of his unjust imprisonment hides a fierce determination for freedom.',
			:url_image=> 'http://pics.filmaffinity.com/The_Shawshank_Redemption-576140557-main.jpg',
			:year=>1994,
			:category=>'Drama',
			:user_id=>1)
			
		self[:movies].insert(:id=>8, 
			:title=> 'Seven samurai',
			:synopsis=> 'Set in 16th Century Japan, Akira Kurosawa\'s epic SEVEN SAMURAI follows the plight of a defenseless farming village that lives in constant fear of marauding bandits. The farmers know that when their crops are harvested, the thugs will attack, so four men go to town in hopes of employing samurai to fight for them. However, the poor villagers can merely offer payment in the form of shelter and a daily bowl of rice, and initially only Kambei (Takashi Shimura), a brave elder samurai, and his eager young apprentice, Katsushiro (Isao Kimura), take up their cause. Encountering various nomadic warriors on the streets, they slowly put together his team of swordsmen, recruiting Shichiroji (Daisuke Katô), Gorobei (Yoshio Inaba), Heihachi (Minoru Chiaki), and Kyuzo (Seiji Miyaguchi). Finally, Kikuchiyo (Toshirô Mifune), a scruffy wanderer who has been trailing them, completes the small band of ronin. However, upon reaching the village, the samurai learn that the farmers fear them as much the enemy. Despite the tensions, Kambei and his men slowly train the peasants to defend their village. Eventually the warriors launch a preemptive strike against the bandits, and begin a series of intense conflicts that culminates in a rain-soaked final battle--without a doubt, one of the most stunning sequences in cinema history.',
			:url_image=> 'http://pics.filmaffinity.com/Seven_Samurai-914194246-main.jpg',
			:year=> 1954,
			:category=>'Action',
			:user_id=>2)
			
		self[:movies].insert(:id=>9, 
			:title=> 'Psycho',
			:synopsis=> 'Credited with inventing the genre of the modern horror film, PSYCHO has had its share of sequels and imitators, none of which diminishes the achievement of this shocking and complex horror thriller. Alfred Hitchcocks choreography of elements in PSYCHO is considered so perfect it inspired a shot-by-shot remake by Gus Van Sant in 1998. However, Hitchcocks black-and-white original, featuring Anthony Perkinss haunting characterization of lonely motel keeper Norman Bates, has never been equaled. Bates presides over an out-of-the-way motel under the domineering specter of his mother. The young, well-intentioned Bates is introduced to the audience when Marion Crane (Janet Leigh), a blonde on the run with stolen money, checks in for the night. But Momma doesnt like loose women, so the stage is set for this classic tale of horror--and one of the most famous scenes in film history. PSYCHO was initially received by audiences with shock and amazement, and it still terrifies today. Though it is now considered prototypical Hitchcock, its setting, pace, and emphasis on terror were major departures for the director at the time, coming after the more classically grand NORTH BY NORTHWEST.',
			:url_image=> 'http://pics.filmaffinity.com/Psycho-445554968-main.jpg',
			:year=>1960,
			:category=>'Horror',
			:user_id=>3)
			
		self[:movies].insert(:id=>10, 
			:title=> 'Casablanca',
			:synopsis=> 'Humphrey Bogart plays Richard "Rick" Blaine, a cynical but good-hearted American whose café is the gathering place for everyone from the French Police to the black market to the Nazis. When his long-lost love, Ilsa (Ingrid Bergman), surfaces in Casablanca with her Resistance leader husband, Victor Laszlo (Paul Henreid), Rick is pulled into both a love triangle and a web of political intrigue. Ilsa and Victor need to escape from Casablanca, and Rick may be the only one who can help them. The question is, will he?',
			:url_image=> 'http://pics.filmaffinity.com/Casablanca-565828825-main.jpg',
			:year=>1942,
			:category=>'Drama',
			:user_id=>1)
			
		self[:movies].insert(:id=>11, 
			:title=> 'Cinema Paradiso',
			:synopsis=> 'A young boy (Marco Leonardi) in a small Italian village is overjoyed when the local movie projectionist (Philippe Noiret) reveals to him the mysteries of moviemaking, beginning his lifelong love affair with cinema.',
			:url_image=> 'http://pics.filmaffinity.com/Cinema_Paradiso-502451618-main.jpg',
			:year=> 1988,
			:category=>'Drama',
			:user_id=>2)
			
		self[:movies].insert(:id=>12, 
			:title=> 'Untouchable',
			:synopsis=> 'After a paragliding accident, Philippe, a rich aristocrat, is confined to his home. He employs Driss as home help. Driss is a young guy from the projects recently out of prison. In short, the person the least adapted for the job. Vivaldi and Earth, Wind and Fire, fine language and slang, suits and jogging outfits come together and a clash is inevitable. Two worlds collide and win each other over to give birth to a friendship as crazy, funny, and fierce as it is unexpected. A unique relationship that will make sparks fly and render Philippe and Driss untouchable.',
			:url_image=> 'http://pics.filmaffinity.com/Untouchable-218166359-main.jpg',
			:year=> 2011,
			:category=>'Comedy',
			:user_id=>3)
			
		self[:movies].insert(:id=>13, 
			:title=> 'Million Dollar Baby',
			:synopsis=> 'Frankie Dunn (CLINT EASTWOOD) has trained and managed some incredible fighters during a lifetime spent in the ring. The most important lesson he teaches his boxers is the one that rules his life: above all, always protect yourself. In the wake of a painful estrangement from his daughter, Frankie has been unwilling to let himself get close to anyone for a very long time. His only friend is Scrap (MORGAN FREEMAN), an ex-boxer who looks after Frankie\'s gym and knows that beneath his gruff exterior is a man who has attended Mass almost every day for the past 23 years, seeking the forgiveness that somehow continues to elude him. Then, one day, a girl named Maggie Fitzgerald (HILARY SWANK) approaches Frankie Dunn and asks him to train her.',
			:url_image=> 'http://pics.filmaffinity.com/Million_Dollar_Baby-570312918-main.jpg',
			:year=> 2004,
			:category=>'Drama',
			:user_id=>1)
			
		self[:movies].insert(:id=>14, 
			:title=> 'Inception',
			:synopsis=> 'Dom Cobb (Leonardo DiCaprio) is a skilled thief, the absolute best in the dangerous art of extraction, stealing valuable secrets from deep within the subconscious during the dream state, when the mind is at its most vulnerable. Cobb\'s rare ability has made him a coveted player in this treacherous new world of corporate espionage, but it has also made him an international fugitive and cost him everything he has ever loved.
Now Cobb is being offered a chance at redemption. One last job could give him his life back but only if he can accomplish the impossible inception. Instead of the perfect heist, Cobb and his team of specialists have to pull off the reverse: their task is not to steal an idea but to plant one. If they succeed, it could be the perfect crime. But no amount of careful planning or expertise can prepare the team for the dangerous enemy that seems to predict their every move. An enemy that only Cobb could have seen coming.',
			:url_image=> 'http://pics.filmaffinity.com/Inception-652954101-main.jpg',
			:year=> 2010,
			:category=>'Sci-fi',
			:user_id=>2)
			
		self[:movies].insert(:id=>15, 
			:title=> 'Shrek',
			:synopsis=> 'When a green ogre called Shrek discovers his swamp has been swamped with all sorts of fairytale creatures by the scheming Lord Farquaad, Shrek sets out, with a very loud donkey by his side, to persuade Farquaad to give his swamp back. Instead, a deal is made. Farquaad, who wants to become the King, sends Shrek to rescue Princess Fiona, who is waiting for her one true love. But once they head back with Fiona, it starts to become apparent that not only does Shrek like Fiona, but Fiona is keeping something secret.',
			:url_image=> 'http://pics.filmaffinity.com/Shrek-774279129-main.jpg',
			:year=> 2001,
			:category=>'Animation',
			:user_id=>3)
					

		self[:comments].insert(:id=>1, :content=>'Great movie', 
						:comment_date=>Sequel.string_to_date('2014-02-03'), 
						:movie_id=>1, :user_id=>1)
		self[:comments].insert(:id=>2, :content=>'I hate it!', 
						:comment_date=>Sequel.string_to_date('2014-02-10'), 
						:movie_id=>1, :user_id=>2)
		self[:comments].insert(:id=>3, :content=>'I love it!', 
						:comment_date=>Sequel.string_to_date('2014-08-11'), 
						:movie_id=>2, :user_id=>1)
		self[:favs].insert(:id=>1, :movie_id=>1, :user_id=>1)
		self[:favs].insert(:id=>2, :movie_id=>3, :user_id=>2)
	
	end
	
	down do
		self[:favs].delete
		self[:comments].delete
		self[:movies].delete
		self[:users].delete
	end
end
