; line 1
"A module docstring."

(import inspect)
; line 5

; line 7
(defn spam [a #* g b c [d 3] [e 4] [f 5] #** h]
  (eggs (+ b d) (+ c f)))

; line 11
(defn eggs [x y]
  "A docstring."
  (global fr st)
  (setv fr (inspect.currentframe))
  (setv st (inspect.stack))
  (setv p x)
  (setv q (/ y 0)))

; line 20
(defclass StupidGit []
  "A longer,
    indented

       docstring."
  
; line 27
  (defn abuse [self a b c]
    "Another
    
        docstring

     containing
\t    
    
    tabs

     "
    (self.argue a b c))
  
; line 40
  (defn argue [self a b c]
    (try
      (spam a b c)
      (except [e BaseException]
        (setv self.ex e)
        (setv self.tr (inspect.trace)))))

  (defn [property] contradiction [self]
    "The automatic gainsaying."))


; line 53
(defclass MalodorousPervert [StupidGit]
  (defn abuse [self a b c])
  (defn [property] contradiction [self]))


(setv Tit MalodorousPervert)


(defclass ParrotDroppings [])


(defclass FesteringGob [MalodorousPervert ParrotDroppings]
  (defn abuse [self a b c])
  (defn _getter [self])
  (setv contradiction (property _getter)))


(defn :async lobbest [grenade])

(setv currentframe (inspect.currentframe))

(try
  (raise (Exception))
  (except [e BaseException]
    (setv tb e.__traceback__)))


(defclass Callable []
  
  (defn __call__ [self #* args]
    (return args))
  
  (defn as_method_of [self obj]
    (import types [MethodType])
    (return (MethodType self obj))))

(setv custom_method ((. (Callable) as_method_of) 42))
(del Callable)



; line 95
(defclass WhichComments []
; line 97
  ; before f
  (defn f [self]
    ; line 100
    (return 1))

    ; line 103
    ; end f
    ; line 105
  ; after f
  
  ; before asyncf - line 108))
  (defn :async asyncf [self]
    ; start asyncf
    (return 2)))
    ; end asyncf
    ; after asyncf - line 113
  ; end of WhichComments - line 114
; after WhichComments - line 115

#()
  
  
(defn after_closing [] (fn [] 1))
