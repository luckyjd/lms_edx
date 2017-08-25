import fnmatch
from itertools import chain
import re


class BatchError(Exception):
    pass


def _params(*args, **kwargs):
    return (args, kwargs)


class BatchBase(object):
    
    def __init__(self):
        self._stack = []
        self._eval_cache = None
        self._eval_level = 0
    
    
    def _eval(self, paths):
                       
        operations = []
        for cmd in self._stack[::-1]:
            cmd_name, (args, kwargs) = cmd
            cmd_func = getattr(self, '_cmd_' + cmd_name, None)
            assert cmd_func is not None, "Unknown batch command"
            operations.append(lambda paths:cmd_func(paths, *args, **kwargs))                           
        
        def recurse_operations(op_index=0):            
            if op_index >= len(operations):
                for fs, path in paths:
                    yield fs, path
            else:
                for fs, path in operations[op_index](recurse_operations(op_index+1), ):
                    yield fs, path
         
        for fs, path in recurse_operations():
            yield fs, path            
    
    
    def filter(self, *wildcards):        
        cmd = ('filter', _params(wildcards))
        self._stack.append(cmd)
        return self
        
    def exclude(self, *wildcards):
        
        cmd = ('exclude', _params(wildcards))
        self._stack.append(cmd)
        return self
        
    def _cmd_filter(self, fs_paths, wildcards):   
        wildcard_res = [re.compile(fnmatch.translate(w)) for w in wildcards]            
        for fs, path in fs_paths:            
            for wildcard_re in wildcard_res:                
                if wildcard_re.match(path):
                    yield fs, path                        
            
    def _cmd_exclude(self, fs_paths, wildcards):   
        wildcard_res = [re.compile(fnmatch.translate(w)) for w in wildcards]            
        for fs, path in fs_paths:            
            for wildcard_re in wildcard_res:                
                if wildcard_re.match(path):                    
                    break
            else:
                yield fs, path        
        
    

class Batch(BatchBase):
    
    def __init__(self, *fs, **kwargs):
        super(Batch, self).__init__()
        self.fs_list = fs
        self.recursive = kwargs.get('recursive', False)
        
    def path_iter(self, fs_list):        
        if self.recursive:
            for fs in fs_list:
                for path in fs.walkfiles():
                    yield fs, path                
        else:
            for fs in fs_list:
                for path in fs.listdir(full=True, absolute=True):
                    yield fs, path                            
    
    def __iter__(self):
        return self._eval(self.path_iter(self.fs_list))
    
    def paths(self):
        for fs, path in self:
            yield path
        
class BatchList(BatchBase):
    
    def __init__(self, fs, paths):
        self.fs_list = [(fs, path) for path in paths]
    
    def __iter__(self):
        return self.fs_list
    
class BatchOp(Batch):
    
    def __init__(self):
        super(BatchBase, self).__init__(None)
        self._op_stack = []
        
    def remove(self):
        cmd = ('remove', _params())
        self._op_stack.append(cmd)
        return self
        
    def _op_remove(self, fs, path):
        fs.remove(path)
        
    def apply(self, fs=None, ignore_errors=False):
        
        def do_call(func, *args, **kwargs):
            return func(*args, **kwargs)
            
        def ignore_exceptions(func, *arg, **kwargs):
            try:
                return func(*args, **kwargs)
            except:
                return None
        
        if ignore_errors:
            call_cmd = ignore_exceptions
        else:
            call_cmd = do_call
        
        
        for fs, path in self.path_iter():
            for cmd in self._op_stack:
                cmd_name, (args, kwargs) = cmd
                cmd_func = getattr(self, '_op_' + cmd_name)
                call_cmd(cmd_func, fs, path, *args, **kwargs)
          
if __name__ == "__main__":
    
    from fs.osfs import OSFS  
    test_fs = OSFS("/home/will/projects/meshminds/meshminds")
    b = Batch(test_fs, recursive=True).exclude("*.py", "*.html")
    print list(b.paths())
    
      
    
    #b=BatchBase()
    #b.filter('*.py')
    
    #print b._eval([[None, 'a/b/c.py'],
    #        [None, 'a/b/c.pyw']])
            