#!/usr/bin/env ruby

def define_variables(n,file)
    1.upto(n**2) do |i|
        1.upto(n**2) do |j|
            file.print "p(x_#{i}=#{j}) "
        end
        file.puts ""

        1.upto(n**2) do |j|
            (j+1).upto(n**2) do |k|
                file.puts "¬p(x_#{i}=#{j}) ¬p(x_#{i}=#{k})"
            end
        end
    end
end

def define_constraints(n,m,file)
    n.times do |i|
        comb = _define_constraints(n-1,m,1+i*n,1,[1+i*n])
        __define_constraints(n, m, file, comb, "", 0)
    end

    n.times do |i|
        comb = _define_constraints(n-1, m, 1+i, n, [1+i])
        __define_constraints(n, m, file, comb, "", 0)
    end

    comb = _define_constraints(n-1, m, 1, n+1, [1])
    __define_constraints(n, m, file, comb,"",0)

    comb = _define_constraints(n-1, m, n, n-1, [n])
    __define_constraints(n, m, file, comb,"",0)
end

def _define_constraints(n, m, s, d, comb)
    if n>0 
        comb << comb[-1] + d
        return _define_constraints(n-1, m, s, d, comb)
    end

    return comb
end

def __define_constraints(n,m,file,comb,str,sum)
    # p str,comb
    if comb.length > 0
        head = comb.shift
        1.upto(n**2) do |i|
            __define_constraints(n,m,file, comb, str ++ "¬p(x_#{head}=#{i}) ", sum+i)
        end
        comb.unshift(head)
    else
        if sum == m
            return 
        end
        file.puts str
    end
end

def alldiff(n,file)
    1.upto(n**2) do |i|
        1.upto(n**2) do |j|
            (j+1).upto(n**2) do |k|
                file.puts "¬p(x_#{j}=#{i}) ¬p(x_#{k}=#{i})"
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
    define_constraints(n,m,en_file)

    alldiff(n,en_file)

    en_file.close()
end

main()
