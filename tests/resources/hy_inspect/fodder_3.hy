;; This fodder was initially generated from cPython's inspect module's test suite using py2hy.

(import functools [cached_property])

(defclass ParentInheritDoc []
  (defn [cached_property] foo [self]
    "docstring for foo defined in parent"))

(defclass ChildInheritDoc [ParentInheritDoc])

(defclass ChildInheritDefineDoc [ParentInheritDoc]
  (defn [cached_property] foo [self]))

(defclass ChildPropertyFoo [ParentInheritDoc]
  (defn [property] foo [self]
    "docstring for the property foo"))

(defclass ChildMethodFoo [ParentInheritDoc]
  (defn foo [self]
    "docstring for the method foo"))

(defclass ParentNoDoc []
  (defn [cached_property] foo [self]))

(defclass ChildNoDoc [ParentNoDoc])

(defclass ChildDefineDoc [ParentNoDoc]
  (defn [cached_property] foo [self]
    "docstring for foo defined in child"))

