TensorLab.jl
==============
This is a Julia port of The [Tensorlab](https://tensorlab.net) library.

You must have [MATLAB](https://www.mathworks.com/products/matlab.html) installed with Tensorlab in its default path, e.g. in `pathdef.m`.

## Getting started

The main functions implemented in Tensorlab can be accessed as a Julia function with the same name. The following Julia code is used to compute the CPD of a 5x5x5 tensor.

```
A = randn(5,5,5);
options = Options();
options.Display          = true;
options.Initialization   = MatFcn("cpd_rnd");
options.Algorithm        = MatFcn("cpd_als");
options.AlgorithmOptions = Options();
options.AlgorithmOptions.LineSearch = MatFcn("cpd_els");
options.AlgorithmOptions.TolFun     = 1e-12;
options.AlgorithmOptions.TolX       = 1e-12;
Uhat = cpd(A, 10, options)
```
Or we could have just used `cpd(A, 10)` without the options, as in Tensorlab.
The original MATLAB code is the following. 
```
A = randn(5,5,5);
options.Display = true; 
options.Initialization = @cpd_rnd; 
options.Algorithm = @cpd_als; 
options.AlgorithmOptions.LineSearch = @cpd_els; 
options.AlgorithmOptions.TolFun = 1e-12; 
options.AlgorithmOptions.TolX   = 1e-12; 
Uhat = cpd(A,10,options);
```

## Modifications for interoperability

- Function handles are encoded in the `MatFcn` type. Thus, whenever you wish to pass a function handle for the MATLAB function `f` to Tensorlab from Julia, pass it as `MatFcn("f")`. This is equivalent to `@f` in MATLAB.
- The `Options` object is the proper way to pass a struct with options to Tensorlab. First, initialise an object as `options = Options()`. From then onwards, you can add fields as you would in MATLAB. If one of those fields is another `Options` objects, it must be explicitly initialised as such. See the example above.

<hr>

If any functionality is missing, you may alternatively use the MATLAB.jl package and write the MATLAB code yourself within a Julia environment.

