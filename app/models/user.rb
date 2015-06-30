class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def follow!(user)
		# start a transaction block
		$redis.multi do 
			# Add member to the set stored at key.
			# If member is already a member of this set, no operation is performed. 
			# If key does not exist, a new set is created with member as its sole member

			$redis.sadd(self.redis_key(:following), user.id)
			$redis.sadd(user.redis_key(:followers), self.id)
		end
	end   

	def unfollow!(user)
		$redis.multi do
			# Remove member from the set stored at key.
			# If member is not a member of this set, no operation is performed.
			$redis.srem(self.redis_key(:following), user.id)
			$redis.srem(user.redis_key(:followers), self.id)
		end
	end

	def followers
		# Returns all the members of the set value stored at key.
		user_ids = $redis.smembers(self.redis_key(:followers))
		User.where(:id => user_ids)
	end

	def following
		user_ids = $redis.smembers(self.redis_key(:following))
		User.where(:id => user_ids)
	end

	def followed_by?(user)
		# Returns if member is a member of the set stored at key.
		$redis.sismember(self.redis_key(:followers), user.id)
	end

	def following?(user)
		$redis.sismember(self.redis_key(:following), user.id)
	end

	def followers_count
		# Returns the set cardinality (number of elements) of the set stored at key.
		$redis.scard(self.redis_key(:followers))
	end

	def following_count
		$redis.scard(self.redis_key(:following))
	end

	# helper method to generate redis key	

	def redis_key(str)
		"user:#{self.id}:#{str}"
	end


	# Create highscore table using sorted sets
	def scored(score)
		if score > self.high_score
			# Adds the member with the specified score to the sorted set stored at key. 
			# If member is already a member of the sorted set, 
			# the score is updated and the element reinserted at the right position 
			# to ensure the correct ordering. 
			# If key does not exist, a new sorted set with the specified member as sole member is created.

			$redis.zadd('highscores', score, self.id)
		end
	end

	def rank
		# Returns the rank of member in the sorted set stored at key, 
		# with the scores ordered from high to low. 
		# The rank (or index) is 0-based, which means that the member with the highest score has rank 0.

		$redis.zrevrank('highscores', self.id) + 1
	end

	def high_score
		# Returns the score of member in the sorted set at key.
		$redis.zscore('highscores', self.id).to_i
	end

	def self.top_3
		# Returns the specified range of elements in the sorted set stored at key. 
		# The elements are considered to be ordered from the highest to the lowest score.
		
		$redis.zrevrange('highscores', 0, 2).map{|id| User.find(id)}
	end
end
