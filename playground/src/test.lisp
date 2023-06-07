(import std "reduce" "floor" "round" "map" "push" "max")
; (let sample (Array "FBFBBFFRLR" "BFFFBBFRRR" "BFFFBBFRRR" "BBFFBBFRLL"))

; Start by considering the whole range, rows 0 through 127.
; F means to take the lower half, keeping rows 0 through 63.
; B means to take the upper half, keeping rows 32 through 63.
; F means to take the lower half, keeping rows 32 through 47.
; B means to take the upper half, keeping rows 40 through 47.
; B keeps rows 44 through 47.
; F keeps rows 44 through 45.
; The final F keeps the lower of the two, row 44.

(let sample (Array "FBFBBFFRLR" "BFFFBBFRRR" "FFFBBBFRRR" "BBFFBBFRLL"))
(let input sample)
(function to_fb array (reduce array (lambda a b i _ (if (< i 7) (push a b) a)) (Array 0)))
(function to_lr array (reduce array (lambda a b i _ (if (>= i 7) (push a b) a)) (Array 0)))
(function binary_boarding input bounds lower upper (do input 
    (reduce (lambda a b _ _ (block (let half (* (+ (get a 0) (get a 1)) 0.5))
    (if (= b lower) (set a 1 (floor half))
    (if (= b upper) (set a 0 (round half)))))) bounds) 
    (get (= (get input -1) upper))))

      (do sample 
      (map (lambda x _ _ (do (... x) (to_fb) (binary_boarding (Array 0 127) "F" "B"))))
      (map (lambda x _ _ (* x 8))))
    (do sample
    (map (lambda x _ _ (do (... x) (to_lr) (binary_boarding (Array 0 7) "L" "R")))))


(function calc fb lr 
  (+ (* (binary_boarding fb (Array 0 127) "F" "B") 8) 
        (binary_boarding lr (Array 0 7) "L" "R")))


(do sample 
    (map (lambda x _ _ (block 
      (let arr (... x))
      (calc (to_fb arr) (to_lr arr)))))
      (reduce (lambda a b _ _  (max a b)) 0)
      (log))