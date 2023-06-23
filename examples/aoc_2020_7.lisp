(import std "reduce" "find" "for_each" "split_by" "split" "map" "trim" "push" "every" "remove" "some")
(let sample1 
"light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.")
(let sample2 "shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.")
; 2 + 2 * 3  + 3
(let sample3 "shiny gold bags contain 2 muted aqua bags.
muted aqua bags contain 3 dark red bags.
dark red bags contain no other bags.")
; 2
(let sample4 "shiny gold bags contain 1 dull aqua bag.
dull aqua bags contain 1 shiny purple bag.
shiny purple bags contain no other bags.")
; 6
(let sample5 "shiny gold bags contain 2 dull aqua bags.
dull aqua bags contain 2 shiny purple bags.
shiny purple bags contain no other bags.")
; 8
(let sample6 "shiny gold bags contain 1 cool cyan bag, 1 awesome aqua bag.
cool cyan bags contain 1 dusty diamond bag.
awesome aqua bags contain 2 dusty diamond bags.
dusty diamond bags contain 1 leafy lime bag.
leafy lime bags contain no other bags.")
; 622
(let sample7 "f f bags contain no other bags.
e e bags contain 2 f f bags.
d d bags contain 2 e e bags, 2 f f bags.
c c bags contain 2 d d bags, 2 e e bags, 2 f f bags.
b b bags contain 2 c c bags, 2 d d bags, 2 e e bags.
a a bags contain 2 b b bags, 2 c c bags, 2 d d bags.
shiny gold bags contain 2 a a bags, 2 b b bags, 2 c c bags.")
(function bags array 
          (map array 
            (lambda x _ _ 
              (do x 
                (regex_match "^(.*(?= bags contain))|(?<=(contain )).*(?=(,|.))") 
  (map 
    (lambda y _ _ 
      (do y 
        (split ", "))))))))
; (map (lambda z _ _ (regex_match z "[1-9]|.*")))
  (let target (Array "shiny" "gold"))
  (function solve1 bags target (block 
    (let count 0)
    (loop traverse-bags left right (block
      (for_each bags 
        (lambda bag _ _ 
          (and 
            (not (= (get (car bag) -1) 1)) 
              (some (car (cdr bag)) 
                (lambda x _ _ 
                  (and 
                    (= left (car (cdr x)))
                    (= right (car (cdr (cdr x))))
                    (let* count (+ count 1))
                    (set (car bag) 2 1)
                    (traverse-bags (car (car bag)) (car (cdr (car bag))))))))))))
       (traverse-bags (car target) (car (cdr target)))
       count))
  
  (function read-input input
      (do 
        input 
        (split_by "\n") 
        (bags)
        (remove 
          (lambda bag _ _ 
            (not 
              (or 
                (= (car (car bag)) (concatenate (car target) (car (cdr target))))
                (= (car (car (cdr bag))) "no other bags")
                ))))
        (map 
          (lambda bag _ _ 
            (block
              (let left (car (car bag)))
              (let right (car (cdr bag)))
              (let head (split left " "))
              (let tail 
                (do right  
                  (map 
                    (lambda x _ _ 
                      (block 
                        (let current (split x " "))
                        (do current 
                          (set 0 (type (car current) Number)) 
                          (set -1)))))))
              (Array head tail))))))

    (do 
      (read-input sample1) 
      (solve1 target) 
      (log))
    (do 
      (read-input sample2) 
      (solve1 target) 
      (log))
    (log (solve1 all-bags target))

(function find-bag bags left right 
          (find bags 
            (lambda x _ _ (and 
              (= (car (car x)) left)
              (= (car (cdr (car x))) right)))))
      
(function sum-bags initial all-bags 
  (reduce initial (lambda output current _ _ (block 
    (let next (find-bag all-bags (car (cdr current)) (car (cdr (cdr current)))))
    (+ output (if next  (* (car current) (sum-bags (car (cdr next)) all-bags)) (car current))))) 1))
; 1 + 1*7 + 2 + 2*11 = 32
(let inpt (read-input (open "./playground/src/aoc_2020/7/input.txt")))
  (do 
   inpt
    (find-bag "shiny" "gold")
    (cdr)
    (car)
    (sum-bags inpt)
    (- 1)
    (log))
  (do (read-input sample1) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample1)) (- 1) (log))
  (do (read-input sample2) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample2)) (- 1) (log))
  (do (read-input sample3) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample3)) (- 1) (log))
  (do (read-input sample4) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample4)) (- 1) (log))
  (do (read-input sample5) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample5)) (- 1) (log))
  (do (read-input sample6) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample6)) (- 1) (log))
  (do (read-input sample7) (find-bag "shiny" "gold") (cdr) (car) (sum-bags (read-input sample7)) (- 1) (log))