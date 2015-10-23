require 'ruby-prof'

def onemax(vector)
	return vector.inject(0){|sum, value| sum + value}
end

def generate_candidate(vector)
	candidate = {}
	candidate[:bitstring] = Array.new(vector.size)
	vector.each_with_index do |p, i|
		candidate[:bitstring][i] = (rand()<p) ? 1 : 0
	end
	candidate[:cost] = onemax(candidate[:bitstring])
	return candidate
end

def update_vector(vector, winner, loser, pop_size)
	vector.size.times do |i|
		if winner[:bitstring][i] != loser[:bitstring][i]
			if winner[:bitstring][i] == 1
				vector[i] += 1.0/pop_size.to_f
			else
				vector[i] -= 1.0/pop_size.to_f
			end
		end
	end
end

def search(num_bits, max_iterations, pop_size)
	vector = Array.new(num_bits){0.5}
	best = nil
	max_iterations.times do |iter|
		c1 = generate_candidate(vector)
		c2 = generate_candidate(vector)
		winner, loser = (c1[:cost] > c2[:cost] ? [c1,c2] : [c2,c1])
		best = winner if best.nil? or winner[:cost]>best[:cost]
		update_vector(vector, winner, loser, pop_size)
		break if best[:cost] == num_bits
		# puts " >iteration=#{iter}, f=#{best[:cost]}, s=#{best[:bitstring]}"
		puts " >iteration=#{iter}"
	end
	return best
end

if __FILE__ == $0
	puts " >num_bits=#{ARGV[0]}"
	puts " >population=#{ARGV[1]}"
	# problem configuration
	num_bits = ARGV[0].to_i
	# algorithm configuration
	max_iterations = 1000000
	pop_size = ARGV[1].to_i
	
	RubyProf.measure_mode = RubyProf::CPU_TIME
	RubyProf.start	

	# execute the algorithm
	best = search(num_bits, max_iterations, pop_size)

	result = RubyProf.stop

	# puts "done! Solution: f=#{best[:cost]}/#{num_bits},
	s=#{best[:bitstring]}"

	printer = RubyProf::FlatPrinter.new(result)
	printer.print(STDOUT)
end
