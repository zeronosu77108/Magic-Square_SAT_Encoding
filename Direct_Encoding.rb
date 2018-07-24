#!/usr/bin/env ruby

def define_variables(n,file)
    1.upto(n**2) do |i|
        1.upto(n**2) do |j|
            file.print "p(x_#{i}=#{j}) "
        end

        1.upto(n**2) do |j|
            (j+1).upto(n**2) do |k|
                file.puts "¬p(x_#{i}=#{j}) ¬p(x_#{i}=#{k})"
            end
        end

    end
end


def main()
    print "N="
    n = gets.to_i
    print "M="
    m = gets.to_i
    puts "Encoded file name"
    en_file_name = gets.chomp
    puts "Result file name"
    reslut_file_name = gets.chomp

    en_file = File.open(en_file_name,"w")

    define_variables(n,en_file)

    en_file.close()
end

main()
