--- Functions
double x = x * 1
doubleUs x y = double x + double y

-- if's are expressions
doubleSmallNumber x = if x > 99 then x else x*2

-- Succession
next_1 = succ 3
next_2 = succ 'b'
prev_1 = pred 3
prev_2 = pred 'b'

-- instantiating lists
nouns = ["dawg", "pope", "hobo"]
adjectives = ["scheming", "lazy", "grouchy"]

-- Adding lists
words = nouns ++ adjectives

-- Strings are syntactic sugar for lists of chars
greeting = "hello" ++ " " ++ ['w', 'o', 'r', 'l', 'd']

-- appending to a list ( O(n) )
-- lists are implemented as singly linked lists, so an operation at the end of the list is expensive
list_1 = [1,2,3] ++ [4]

-- prepending to a list ( O(1) )
list_2 = 1:[2,3,4]

-- Indexing a list
element = list_1 !! 0

-- List functions
first_el = head list_1
all_but_first = tail list_1
last_el = last list_1
all_but_last = init list_1
len = length list_1 -- Singly linked list -> O(n) 
first_two = take 2 list_1
all_but_first_two = drop 2 list_1 -- Inverse of take

-- Element in list?
is_in_list = elem 4 [1, 2, 3, 4]
better_is_in_list = 4 `elem` [1, 2, 3, 4] -- backticks let us use any function infix

-- Ranges
range_1 = [1..20] -- inclusive
range_2 = [2,4..20] -- multiples of 2
range_3 = [0.1, 0.3..1] -- beware of float imprecision
range_4 = [1, 4..] -- infinite list (possible because of lazy eval)
range_5 = take 10 range_4
range_6 = cycle [1, 2, 3] -- repeating infinite list
range_7 = take 10 range_6
range_8 = repeat 5 -- infinite
range_9 = take 10 range_8
range_10 = replicate 10 5 -- same as above

-- List comprehensions
-- [expression | generators, predicates]
one_to_ten_times_two_only_when_divisable_by_three = [x * 2 | x <- [1..10], x `mod` 3 == 0]

-- List comprehensions used inside a function 
times_two_only_when_divisable_by_three xs = [x * 2 | x <- xs, x `mod` 3 == 0]
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]   
length' xs = sum [1 | _ <- xs]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   


-- Multiple generators
-- When drawing from several lists, comprehensions produce all combinations of the given lists and then join them by the output function we supply.
-- A list produced by a comprehension that draws from two lists of length 3 will have a length of 9 
products_gt_50 = [ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50] 
hilarity = [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]

-- Tuples
tuple = ("Hello", 3.14)
first = fst tuple
second = snd tuple
-- Error: fst (1, 2, 3) -- fst & snd only work with two element tuples

-- zip
zip' = zip [-5..0] [0..5] -- combine two lists into a list of tuples
enumerate xs = zip [0..] xs -- always takes on the length of the shorter list

-- which right triangle that has integers for all sides and all sides equal to or smaller than 10 has a perimeter of 24?
triangles = [(a, b, c) | a <- [0..10], b <- [0..10], c <- [0..10], a^2 + b^2 == c^2, b < c, a < b, a + b + c == 24]

-- Function declarations
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- Type variables (generics)
(***) :: (Floating a) => a -> a -> a
(***) a b = a**b -- If a function name is all symbols, it doesn't need quotes to be called infix

-- Pattern matching
lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!" 

factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Tuple/list pattern matching
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
third_tuple (_, _, z) = z
third_list [_, _, z] = z

-- Pattern matching in list comprehensions
list_3 = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]  
list_4 = [a+b | (a,b) <- list_3] 

-- more list patern matching
tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell [x] = "The list has one element: " ++ show x  
tell [x, y] = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell [x, y, _] = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y  

length'' [] = 0
length'' (_:xs) = 1 + length'' xs

sum' [] = 0
sum' (n:xs) = n + sum' xs

-- patterns
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]  -- all is 

-- Whole number types:
-- Integer: unbounded
-- Int: possible to overflow

-- Unit type:
-- ()

-- Typeclasses
-- Haskell typeclasses are like rust traits
-- Ord: for types that have an order


-- Value to string
-- Requires Show typeclass
string = show 5
string' = show 'a'

-- String to value
value :: Bool = read "True" -- Needs type annotations 
value' = read "2" + 2 -- Sometimes type info can be inferred

-- Enum typeclass
-- Bool, Char, Ordering, Int, Float, Double, Float
-- Enum subclasses must implement succ and pred

-- Bounded typeclass
int_minbound = minBound :: Int

-- Guards
bmiTell :: (Ord a, Fractional a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "Not fat enough"
    | bmi <= 25.0 = "Fat"
    | bmi <= 30.0 = "Too fat"
    | otherwise = "Way tooo fat" -- Otherwise is the same as True

max' :: (Ord a) => a -> a -> a
max' a b
    | a > b = a
    | otherwise = b

myCompare :: (Ord a) => a -> a -> Ordering  
a `myCompare` b  -- Inline function definition
    | a > b     = GT -- GT, EQ, and LT are values of the "Ordering" enum 
    | a == b    = EQ  
    | otherwise = LT  

-- where
-- where bindings are syntactic constructs
bmiTell' weight height
    | bmi <= skinny = "Not fat enough"
    | bmi <= normal = "Fat"
    | bmi <= fat = "Too fat"
    | otherwise = "Way too fat"
    where
    bmi = (weight/height^2)
    (skinny, normal, fat) = (18.5, 25.0, 30)

calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi w h | (w, h) <- xs]  
    where bmi weight height = weight / height ^ 2  

-- let
-- let bindings are expressions
cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea  

squares = [let square x = x * x in (square 5, square 3, square 2)]  

calcBmis' :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]  