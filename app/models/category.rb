class Category < ActiveRecord::Base
	after_save :clear_cache

	# update cache every time a category created or updated
	def clear_cache
		$redis.del 'categories'
	end

end
