##The function getScratchValue takes a pile of scratchcards 
##The function returns two outputs:
##runningCounter: the point value of the scratch cards 
#sum(scratchCardArray): The number of scratch cards that you have won from the pile

function getScratchValue(fileName)
    scratchCardArray = ones(countlines(fileName), 1)
    open(fileName) do file
        i = 1
        runningCounter = 0
        regex_chars = r"[:\|]"
        for line in eachline(file)
            splitLine = split(line,regex_chars)
            split1 = filter!(val->val≠"",split(splitLine[2]," ")) #the elf's scratchcard numbers
            split2 = filter!(val->val≠"",split(splitLine[3]," ")) #your scratchcard numbers
            intersectionSet = intersect(split1, split2) #compare your scratch card to the elf
            lengthIntersect = length(intersectionSet) #the number of matches between your and the elf's numbers
            for k = (i+1):(i+lengthIntersect)
                if k < countlines(fileName)+1 && lengthIntersect > 0 #the number of matches determines how many subsequent cards you add this card's value to
                    scratchCardArray[k] = scratchCardArray[k] + scratchCardArray[i] #adding the value of the card in match i to the current card's total (card k)
                end
            end
            if lengthIntersect > 0
                runningCounter = runningCounter + (2^(lengthIntersect-1)) #the point value is 1 point (first match) + 2 to the power of every other additional match  
            end
            i = i + 1
        end
    return runningCounter, sum(scratchCardArray)
    end
end

print(getScratchValue("Day4AdventOfCodeExampleText.txt"))
