; line 1

(defn wrap [[foo None]]
  (defn wrapper [func] (return func))
  (return wrapper))

; line 7
(defn replace [func]
  (defn insteadfunc []
    (print "hello"))
  (return insteadfunc))

; line 13
(defn [(wrap) (wrap wrap)] wrapped [])




; line 19
(defn [replace] gone [])



; line 24
(setv oll (fn [m] m))
(setv tll (fn [g] (and g g g)))
(setv tlli (fn [d] (and d d)))




; line 32
(defn onelinefunc [])





; line 39
(defn manyargs [arg1 arg2 arg3 arg4])


; line 43
(defn twolinefunc [m]
  (return (and m m)))

; line 47
(setv a [None (fn [x] x) None])



; line 52
(defn setfunc [func]
  (setv (get (globals) "anonymous") func))


; line 57
(setfunc (fn [x y] (* x y)))
(defn with_comment [] world)

; line 61
(setv multiline_sig [
                     (fn [x
                          y]
                       (+ x y)) None])


; line 68
(defn func69 []
  (defclass cls70 []
    (defn func71 []))
  (return cls70))

(setv extra74 74)

; line 76
(defn func77 [])
(setv #(extra78 stuff78) "xy")
(setv extra79 "stop")

; line 81
(defclass cls82 []
  (defn func83 []))
(setv #(extra84 stuff84) "xy")
(setv extra85 "stop")

; line 87
(defn func88 []
  ; comment
  (return 90))

; line 92
(defn f []
  (defclass X []
    (defn g []
      "doc"
      (return 42)))
  (return X))
(setv method_in_dynamic_class (. (f) g))

; line 101
(defn keyworded [#* arg1 [arg2 1]])


; line 105
(defn annotated [(annotate arg1 list)])


; line 109
(defn keyword_only_arg [* arg])
(defn [(wrap (fn [] None))] func114 []
  (return 115))

(defclass ClassWithMethod []
  (defn method [self]))

(import functools [wraps])

(defn decorator [func]
  (defn [(wraps func)] fake []
    (return 42))
  (return fake))






; line 129
(defn [decorator] real []
  (return 20))


; line 134
(defclass cls135 []

  (defn func136 []
    (defn func137 []
      never_reached1
      never_reached2)))

; line 141
(defclass cls142 []
  (setv a "
class cls149:\n    ...
"))

; line 148
(defclass cls149 []
  (defn func151 [self]))
"
class cls160:
    pass
"




; line 159
(defclass cls160 []
  (defn func162 [self]))



; lien 165
(defclass cls166 []
  (setv a "
        ...
    "))


; line 172
(defclass cls173 []
  (defclass cls175 []))



; line 178
(defclass cls179 [])


; line 182
(defclass cls183 []

  (defclass cls185 []
    (defn func186 [self])))

(defn class_decorator [cls]
  (return cls))



; line 193
(defclass [class_decorator class_decorator]
  cls196 []

  (defclass [class_decorator class_decorator]
    cls200 []))

(defclass cls203 []

  (defclass cls204 []
    (defclass cls205 []))

  (defclass cls207 []
    (defclass cls205 [])))




; line 211
(defn func212 []
  (defclass cls213 [])
  (return cls213))


; line 217
(defclass cls213 []

  (defn func219 [self]
    (defclass cls220 [])
    (return cls220)))

; line 224
(defn :async func225
  []
  (defclass cls226 [])
  (return cls226))

; line 230
(defclass cls226 []

  (defn :async func232
    [self]
    (defclass cls233 [])
    (return cls233)))

(if True
  (do (defclass cls238 [] (defclass cls239 [] "if clause cls239")))
  (do (defclass cls238 [] (defclass cls239 [] "else clause 239"))))






; lien 247
(defn positional_only_arg [a /])


; line 251
(defn all_markers [a b / c d * e f])


; line 255
(defn all_markers_with_args_and_kwargs [a b #* args c d e f #** kwargs])


; line 259
(defn all_markers_with_defaults [a b / c [d 1] * [e 4] [f 5]])


; line 263
(defn deco_factory [#** kwargs]

  (defn deco [f]
    (defn [(wraps f)] wrapper [#* a #** kwd]
      (kwd.update kwargs)
      (return (f #* a #** kwd)))
    (return wrapper))
  (return deco))

(defn [(deco_factory :foo (+ 1 2) :bar (fn [] 1))] complex_decorated [foo bar]
  (return (+ foo (bar))))

; line 276
(setv parenthesized_lambda (fn [] #()))
(setv parenthesized_lambda2 (get [(fn [] #())] 0))
(setv parenthesized_lambda3 (get {0 (fn [] #())} 0))





; line 285
(setv post_line_parenthesized_lambda1 (fn [] #()))


; line 289
(setv nested_lambda (fn [right] ((. [] map) (fn [length] #()))))



; line 294
(if True
  (do
    (defclass cls296 []
      (defn f [])))
  (do
    (defclass cls296 []
      (defn g []))))


; line 304
(if False
  (do
    (defclass cls310 []
      (defn f [])))
  (do
    (defclass cls310 []
      (defn g []))))


; line 314
(defclass ClassWithCodeObject []
  (import sys)
  (setv code (. (sys._getframe 0) f_code)))
(import enum)


; line 321
(defclass enum322 [enum.Enum]
  (setv A "a"))

; line 325
(defclass enum326 [enum.IntEnum]
  (setv A 1))

; line 329
(defclass flag330 [enum.Flag]
  (setv A 1))

; line 333
(defclass flag334 [enum.IntFlag]
  (setv A 1))

; line 337
(setv simple_enum338 (enum.Enum "simple_enum338" "A"))
(setv simple_enum339 (enum.IntEnum "simple_enum339" "A"))
(setv simple_flag340 (enum.Flag "simple_flag340" "A"))
(setv simple_flag341 (enum.IntFlag "simple_flag341" "A"))
(import typing)


; line 345
(defclass nt346 [typing.NamedTuple]
  #^ int x
  #^ int y)

; line 350
(setv nt351 (typing.NamedTuple "nt351" #(#("x" int) #("y" int))))

; line 353
(defclass td354 [typing.TypedDict]
  #^ int x
  #^ int y)

; line 258
(setv td359 (typing.TypedDict "td359" #(#("x" int) #("y" int))))
(import dataclasses)


; line 363
(defclass [dataclasses.dataclass] dc364 []
  #^ int x
  #^ int y)


; line 359
(setv dc370 (dataclasses.make_dataclass "dc370" #(#("x" int) #("y" int))))
(setv dc371 (dataclasses.make_dataclass "dc370" #(#("x" int) #("y" int)) :module __name__))

(import inspect)
(import itertools)

; line 376
(setv ge377 (gfor i (itertools.count)
              (inspect.currentframe)))



; line 382
(defn func383 []
  ; line 384
  (setv ge385 (gfor i (itertools.count)
                (inspect.currentframe)))
  (return ge385))



; line 391
(defn [decorator]
  ; comment
  func394 [] (return 395))


; line 397
(defn
  [decorator]
  func400 []
  (return 401

          )) ; end of file
