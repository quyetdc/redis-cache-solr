module CategoriesHelper
	def fetch_categories	

		categories = $redis.get('categories');

		#  if not cache -> cache it
		if !categories || categories == '[]'
			categories = Category.all.to_json
			$redis.set('categories', categories)
		end

		# decode json format
		@categories = JSON.load categories

	end
end
