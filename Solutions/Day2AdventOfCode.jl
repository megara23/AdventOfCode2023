##The function getGameIDSum takes a series of lines from a game where a series of balls are taken out and then returned
##The function returns two outputs:
##runningCounter: the sum of the games (numbered 1 to the number of games) that would be possible if there were only 12 red balls, 13 blue balls, and 14 green balls
#runningPower: The minimum number of balls needed for each round to be possible in each game, taken to their power (red * blue * green) for each game, then added up 
function getGameIDSum(fileName)
    open(fileName) do file
        runningCounter = 0
        runningPower = 0
        regex_parts = r"[' '|;|:|,]"
        for line in eachline(file)
            DictionaryColors = Dict("blue" => 0, "red" => 0, "green" => 0) #make dictionary; color -> number of balls of that color
            splitLine = split(line,regex_parts) #split lines by all delimiters
            filteredGameVector = filter!(val->val≠"",splitLine) #get rid of empty strings in array 
            gameNum = parse(Int, filteredGameVector[2]) #get the game number
            for i in 4:length(filteredGameVector) #range through the rest of the array
                if (filteredGameVector[i] == "red") || (filteredGameVector[i] == "green") || (filteredGameVector[i] == "blue")
                    gameInt = parse(Int, filteredGameVector[i-1])
                    colorVal = get(DictionaryColors, filteredGameVector[i],0)
                    if gameInt > colorVal 
                        DictionaryColors[filteredGameVector[i]] = gameInt #increase the number of balls of a color if it is larger than what is in the dictionary
                    end
                end
            end
            runningPower = runningPower + (get(DictionaryColors, "red",0) * get(DictionaryColors, "green",0) * get(DictionaryColors, "blue",0)) #add up powers 
            if (get(DictionaryColors, "red",0) <= 12) && (get(DictionaryColors, "green",0) <= 13) && (get(DictionaryColors, "blue",0) <= 14) #if game is possible    
                runningCounter = runningCounter +  gameNum #add up game numbers
            end
        end
        return runningCounter, runningPower
    end
end

print(getGameIDSum("Day2AdventOfCodeExampleText.txt"))