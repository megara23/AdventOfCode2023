##The function getTotal takes a series of lines and adds the first and last number together for each line, and then outputs the total 
#filename: the name of the input file
#mode: "digit" or "word"; "digit" only counts numbers if they are 0-9, while "word" converts words to digits (ex: "zero" => 0)
function getTotal(fileName,mode)
    open(fileName) do file
        runningCounter = 0
        regex_literal_alphabet = r"[a-z]"
        for line in eachline(file)
            if mode == "word" #replace words with digits; if words overlap, replace it with all digits (up to 3)
                line = replace(line, "zerone" => 01,"oneight"=> 18, "twone" => 21,"threeight"=> 38,"fiveight"=> 58,"sevenine"=>79,"eightwo"=> 82,
                "eighthree"=> 83,"nineight"=> 98,"zeroneight"=> 018,"oneightwo" => 182,"twoneight"=> 218,"threeightwo"=> 382,"fiveightwo"=> 582,
                "fiveighthree"=> 583,"eightwone"=> 821)
                line = replace(line, "zero" => 0,"one" => 1, "two" => 2, "three" => 3,"four" => 4,"five" => 5, "six" => 6, "seven" => 7,"eight" => 8,"nine"=>9)
            elseif mode == "digit"
            end
            splitLine = split(line,regex_literal_alphabet) #remove non-numeric parts of string
            filteredNumVector = filter!(val->val≠"",splitLine) #get rid of empty spaces
            filteredNum = join(filteredNumVector) #join numbers remaining
            runningCounter = runningCounter +  parse(Int,first(filteredNum)*last(filteredNum)) #add the first and last number together, and add it to the running total
        end
        return runningCounter
    end
end

print(getTotal("Day1AdventOfCodeExampleText.txt","digit"))
