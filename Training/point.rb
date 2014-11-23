class Point
	def initialize(x,y)
		@x = x
		@y = y
	end

	def x
		@x
	end

	 def y
		@y
	end

	def x=(value)
		@x = value
	end  

	def y=(value)
		@y = value
	end 

	private

	def cannot_call_this
	end

	def nor_this
	end
end