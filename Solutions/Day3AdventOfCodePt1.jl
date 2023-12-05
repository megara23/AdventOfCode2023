using DelimitedFiles #import text file as matrix 

##The function checkForSymbols looks at all numbers and determines whether they are adjacent (top/bottom,left/right,diagonal) to a symbol
##The function returns one output:
##isSymbol: converts to TRUE if number is adjacent to a symbol; otherwise default is FALSE
function checkForSymbols(coordinate,i,j,isSymbol,symbols) #Checking to see if any of the numbers are adjacent to a symbol
    if isSymbol == false
        if (j != size(mat,1) && string(mat[i,j+1]) in symbols) || (j > 1 && string(mat[i,j-1]) in symbols) || (i != size(mat,2) && string(mat[i+1,j]) in symbols) || (i > 1 && string(mat[i-1,j]) in symbols) || (i != size(mat,2) && j > 1 && string(mat[i+1,j-1]) in symbols) || (i > 1 && j != size(mat,1) && string(mat[i-1,j+1]) in symbols) || (i != size(mat,2) && j != size(mat,1) && string(mat[i+1,j+1]) in symbols) || (i > 1 && j > 1 && string(mat[i-1,j-1]) in symbols)
            isSymbol = true
        end
    end
return isSymbol
end 

##The main function takes a blueprint representing an engine schematic; "." characters are ignored, while other symbols are parts and numbers represent their part number
##The function returns one output:
##counter: the sum of the part numbers (numbers adjacent to a symbol)
function mainFunction(mat) 
    numbers = ["0","1","2","3","4","5","6","7","8","9"]
    symbols = ["!","@","#","%","^","&","*","(",")","-","+","=","/","\$"] 
    counter = 0
    isSymbol = false
    matij = ""
    for i = 1:size(mat,2)
        for j = 1:size(mat,1)
            if string(mat[i,j]) in numbers
                isSymbol = checkForSymbols(mat,i,j,isSymbol,symbols) #checks for symbol of one number
                if matij == ""
                    matij = string(mat[i,j])
                else 
                    matij = matij * string(mat[i,j]) #if number is adjacent (left/right) to another number, join strings together
                end
            else
                if matij != "" #when the coordinate to the right of a number becomes a symbol or period
                    if isSymbol == true
                        counter = counter + parse(Int,matij) #convert string into integer, count up parts numbers
                        isSymbol = false
                    else 
                    end
                end
                matij = ""
                isSymbol = false
            end
        end
    end
return counter
end

##Convert text file into a matrix file
lines = map(collect, readlines("Day3AdventOfCodeExampleText.txt"))
mat = permutedims(hcat(lines...))
print(mainFunction(mat))
