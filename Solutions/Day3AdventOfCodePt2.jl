using DelimitedFiles #import text file as matrix 


function findNumbers(mat,i1,j1,numbers) #find one of the two numbers adjacent to the gear (except in special case in function below)
    matij = string(mat[i1,j1])
    j2 = j1 + 1
    j3 = j1 - 1
    if j2 <= size(mat,1) #see if string of numbers can be expanded to the right (until it runs into a symbol or period)
        while j2 <= size(mat,1) && string(mat[i1,j2]) in numbers
            matij = matij * string(mat[i1,j2])
            j2 = j2 + 1
        end
    end
    if j3 > 0 #see if string of numbers can be expanded to the left (until it runs into a symbol or period)
        while j3 > 0 && string(mat[i1,j3]) in numbers
            matij = string(mat[i1,j3]) * matij
            j3 = j3 - 1
        end
    end
return parse(Int,matij) #turn string into integer value
end

function findNumbersSpecial(mat,i1,j1s,j2s,numbers) #find the gear ratio when the numbers are left and right of the gear
matij1 = ""
matij2 = ""
if j1s <= size(mat,1) #put together string of numbers to the right of the gear
    while j1s <= size(mat,1) && string(mat[i1,j1s]) in numbers
        matij1 = matij1 * string(mat[i1,j1s])
        j1s = j1s + 1
    end
end
if j2s > 0 #put together string of numbers to the left of the gear
    while j2s > 0 && string(mat[i1,j2s]) in numbers
        matij2 = string(mat[i1,j2s]) * matij2
        j2s = j2s - 1
    end
end
return parse(Int,matij1) * parse(Int,matij2) #multiply numbers together to get gear ratio
end

function checkForGears(coordinate,i,j) #Checking to see if there are gears; if so, we return their value
    gearCounter = 0
    gearValue = 0 
    numbers = ["0","1","2","3","4","5","6","7","8","9"]
    trackArray = [100000]
    if j < size(mat,1) && j > 1 && string(mat[i,j+1]) in numbers && string(mat[i,j-1]) in numbers #see if numbers are on the left or right of the gear
        gearCounter = 2 #set the number of adjacent numbers to gear to 2
        gearValue = findNumbersSpecial(mat,i,j+1,j-1,numbers)
    else #check to see in which other cases are there numbers adjacent to gears
        if j < size(mat,1) && string(mat[i,j+1]) in numbers
            gearCounter = gearCounter + 1 #track how many numbers we have found that are adjacent to a gear so far
            gearValue = findNumbers(mat,i,j+1,numbers) #combine strings of numbers into an integer
            trackArray = push!(trackArray, gearValue) #track what numbers have been discovered to avoid duplicates
        end
        if j > 1 && string(mat[i,j-1]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i,j-1,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i,j-1,numbers) in trackArray #prevent the computer from finding the same numbers and multiplying them together, since a symbol can be adjacent to one or more decimals of the same number
                else
                    gearValue = gearValue * findNumbers(mat,i,j-1,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i1,j-1,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
        if i < size(mat,2) && string(mat[i+1,j]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i+1,j,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i+1,j,numbers) in trackArray
                else
                    gearValue = gearValue * findNumbers(mat,i+1,j,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i+1,j,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
        if i > 1 && string(mat[i-1,j]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i-1,j,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i-1,j,numbers) in trackArray
                else
                    gearValue = gearValue * findNumbers(mat,i-1,j,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i-1,j,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
        if i < size(mat,2) && j > 1 && string(mat[i+1,j-1]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i+1,j-1,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i+1,j-1,numbers) in trackArray
                else
                    gearValue = gearValue * findNumbers(mat,i+1,j-1,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i+1,j-1,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
        if i > 1 && j < size(mat,1) && string(mat[i-1,j+1]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i-1,j+1,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i-1,j+1,numbers) in trackArray
                else
                    gearValue = gearValue * findNumbers(mat,i-1,j+1,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i-1,j+1,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
        if i != size(mat,2) && j != size(mat,1) && string(mat[i+1,j+1]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i+1,j+1,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i+1,j+1,numbers) in trackArray 
                else
                    gearValue = gearValue * findNumbers(mat,i+1,j+1,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i+1,j+1,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
        if i > 1 && j > 1 && string(mat[i-1,j-1]) in numbers
            if gearValue == 0 
                gearValue = findNumbers(mat,i-1,j-1,numbers)
                trackArray = push!(trackArray, gearValue)
                gearCounter = gearCounter + 1
            else 
                if findNumbers(mat,i-1,j-1,numbers) in trackArray
                else
                    gearValue = gearValue * findNumbers(mat,i-1,j-1,numbers)
                    trackArray = push!(trackArray, findNumbers(mat,i-1,j-1,numbers))
                    gearCounter = gearCounter + 1
                end
            end
        end
    end
    if gearCounter < 2 #get rid of gear ratio value when there was only one number adjacent to a gear
        gearValue = 0
    end
return gearValue
end 

##The main function takes a blueprint representing an engine schematic; in this part, "*" symbols are gears.
##The function returns one output:
##gearValue: the sum of the gear ratios (by multiplying two adjacant numbers to a gear)
function mainFunction2(mat) 
    numbers = ["0","1","2","3","4","5","6","7","8","9"]
    gearValue = 0
    for i = 1:size(mat,2)
        for j = 1:size(mat,1)
            if string(mat[i,j]) == "*"
                gearValue = gearValue + checkForGears(mat,i,j)
            end
        end
    end
return gearValue
end

##Convert text file into a matrix file
lines = map(collect, readlines("C:/Users/megki/Documents/AdventOfCode2023/Day3AdventOfCodeExampleText.txt"))
mat = permutedims(hcat(lines...))
print(mainFunction2(mat))