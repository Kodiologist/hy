(import pytest)
(import sys)
(import os.path [normcase])

;; inspect should have been monkey-patched
(import inspect)
(import inspect [getfile
                 getcomments
                 getsource
                 getsourcelines])

(import hy.compat [PY3_13])


;; --- Modules translated from the python inspect's test suite ---


(import tests.resources.hy-inspect [fodder-1 fodder-3 fodder-4])
(when PY3_13
  ; can't import before 3.13
  (import tests.resources.hy-inspect [fodder-2]))


;; --- Data ---

(setv modfile fodder-1.__file__)
(when (.endswith modfile #("c" "o"))
  (setv modfile (cut modfile -1)))

; Normalize file names: on Windows, the case of file names of compiled
; modules depends on the path used to start the python executable.
(setv modfile (normcase modfile))

(setv git (fodder-1.StupidGit))


;; --- Hy-specific reader macro tests ---

(defn test-reader []
  (assert (= (getsource fodder-4.f-with-reader)
             "(defn f-with-reader [] (setv #m \"x was assigned\") x)\n"))
  (assert (= (get (.split (.strip (getsource fodder-4)) "\n") -1)
             "#do-twice (setv x \"x is assigned twice\")"))
  (assert (= (getsource fodder-4.multiform-reader-macro)
             "(defn multiform-reader-macro [#* xs] (hy.repr #< #* xs >))\n")))


;; --- docstrings

(defn test-getdoc []

  (defclass SlotUser []
    "Docstrings for __slots__"
    (setv __slots__ {"power" "measured in kilowatts"
                     "distance" "measured in kilometers"}))

  ;; NB the indenting removal rules seem to be different to the python version.
  ;; The results below seem to be consistent with PEP 257 though.
  (assert (= (inspect.getdoc fodder-1) "A module docstring."))
  (assert (= (inspect.getdoc fodder-1.StupidGit) "A longer,\nindented\n\n   docstring."))
  (assert (= (inspect.getdoc git.abuse) "Another\n\n    docstring\n\n containing\n        \n\ntabs\n\n "))
  (assert (= (inspect.getdoc SlotUser.power) "measured in kilowatts"))
  (assert (= (inspect.getdoc SlotUser.distance) "measured in kilometers")))


(defn test_getdoc_inherited []
  (assert (= (inspect.getdoc fodder-1.FesteringGob) "A longer,\nindented\n\n   docstring."))
  (assert (= (inspect.getdoc fodder-1.FesteringGob.abuse) "Another\n\n    docstring\n\n containing\n        \n\ntabs\n\n "))
  (assert (= (inspect.getdoc fodder-1.FesteringGob.abuse) "Another\n\n    docstring\n\n containing\n        \n\ntabs\n\n ")))


(defn test_getdoc_inherited_class_doc []
  (defclass A [] "Common base class")
  (defclass B [A])
  (setv a (A))
  (assert (= (inspect.getdoc A) "Common base class"))
  (assert (= (inspect.getdoc a) "Common base class"))
  (setv a.__doc__ "Instance")
  (setv b (B))
  (assert (= (inspect.getdoc B) "Common base class"))
  (assert (is (inspect.getdoc b) None))
  (setv b.__doc__ "Instance")
  (assert (= (inspect.getdoc b) "Instance")))
    

(defn test_getdoc_nodoc_inherited []
  (assert (is (inspect.getdoc fodder-3.ChildNoDoc.foo) None)))


(defn [(pytest.mark.skipif (not PY3_13)
                           :reason "relies on hy.hy_inspect.findsource which is not available before 3.13")]
  test_getcomments []
  (assert (= (inspect.getcomments fodder-1) "; line 1\n"))
  (assert (= (inspect.getcomments fodder-1.StupidGit) "; line 20\n"))
  (assert (= (inspect.getcomments fodder-2.cls160) "; line 159\n")))
    

(defn test_getsource []

  (setv source (with [fp (open (inspect.getsourcefile fodder-1) "rt")]
    (.split (.read fp) "\n")))
  (defn sourcerange [top bottom]
    (return (+
      (.join "\n" (cut source (- top 1) bottom))
      (if bottom "\n" ""))))

  (assert (= (inspect.getsource git.abuse) (sourcerange 28 39)))
  (assert (= (inspect.getsource fodder-1.lobbest) (sourcerange 71 71)))
  (assert (= (inspect.getsource fodder-1.after_closing) (sourcerange 120 120)))
  (when PY3_13
    (assert (= (inspect.getsource fodder-1.StupidGit) (sourcerange 21 50))))
  (assert (= (inspect.getsource fodder-1.eggs.__code__) (sourcerange 12 18))))


(defn test_getsourcefile []
  ;; There is no test here for a non-existent filename (as per python's inspect)
  ;; as the python test's use of `compile` lacks a direct equivalent.
  ;; This should be covered in the python tests anyway.
  (assert (= (normcase (inspect.getsourcefile fodder-1.spam)) modfile)))


(defn [(pytest.mark.skipif (not PY3_13) :reason "Locating class method.")]
  test_getsourcefile_classmethod []
  (assert (= (normcase (inspect.getsourcefile git.abuse)) modfile)))


(defn test_getsource_empty_file [tmp_path monkeypatch]
  (.write-text (/ tmp_path "empty_file.hy") "")
  (monkeypatch.syspath_prepend (str tmp_path))
  (import empty_file)
  ;; behaviour changed in 3.13
  (assert (= (inspect.getsource empty_file) (if PY3_13 "\n" "")))
  (assert (= (inspect.getsourcelines empty_file) #((if PY3_13 ["\n"] []) 0))))


(defn test_getfile []
  (assert (= (inspect.getfile fodder-1.StupidGit) fodder-1.__file__)))
    

(defn test_getfile_class_without_module []
      
  (defclass CM [type]
    (defn [property] __module__ [cls] (raise AttributeError)))

  (defclass C [])
  (with [(pytest.raises TypeError)]
    (inspect.getfile C
    
      (defn test_getfile_broken_repr []
      
        (defclass ErrorRepr []
        
          (defn __repr__ []
            (raise (Exception "xyz"))))

        (setv er (ErrorRepr))

        (with [(pytest.raises TypeError)]
          (inspect.getfile er))))))
