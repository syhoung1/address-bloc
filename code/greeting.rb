def greeting
    greet, *names = ARGV
    names.each do |name|
        puts greet + " #{name}"
    end
end

greeting
