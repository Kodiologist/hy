import ast
import platform
import sys

PY3_9 = sys.version_info >= (3, 9)
PY3_10 = sys.version_info >= (3, 10)
PY3_11 = sys.version_info >= (3, 11)
PY3_12 = sys.version_info >= (3, 12)
PYPY = platform.python_implementation() == "PyPy"
PYODIDE = platform.system() == "Emscripten"


if not PY3_9:
    # Shim `ast.unparse`.
    import astor.code_gen

    ast.unparse = astor.code_gen.to_source


if "def" in ast.unparse(ast.parse("𝕕𝕖𝕗 = 1")):
    # Overwrite `ast.unparse` to backport https://github.com/python/cpython/pull/31012
    import copy
    import keyword

    true_unparse = ast.unparse

    def rewriting_unparse(ast_obj):
        ast_obj = copy.deepcopy(ast_obj)
        for node in ast.walk(ast_obj):
            if type(node) is ast.Constant:
                # Don't touch string literals.
                continue
            for field in node._fields:
                v = getattr(node, field, None)
                if (
                    type(v) is str
                    and keyword.iskeyword(v)
                    and v not in ("True", "False", "None")
                ):
                    # We refer to this transformation as "keyword mincing"
                    # in documentation.
                    setattr(node, field, chr(ord(v[0]) - ord("a") + ord("𝐚")) + v[1:])
        return true_unparse(ast_obj)

    ast.unparse = rewriting_unparse


if True:
    import pydoc, inspect, re
    true_getdoc = pydoc.getdoc
    if not PY3_9:
        pydoc._getdoc = inspect.getdoc
    def getdoc(object):
        """A monkey-patched `pydoc.getdoc` that tries to avoid calling
        `inspect.getcomments` for an object defined in Hy code, which would try
        to parse the Hy as Python. The implementation is based on Python
        3.12.3's `getdoc`."""
        result = pydoc._getdoc(object) or (
            None
            if inspect.getfile(object).endswith('.hy')
            else inspect.getcomments(object))
        return result and re.sub('^ *\n', '', result.rstrip()) or ''
    pydoc.getdoc = getdoc
