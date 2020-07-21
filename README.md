TensorLab.jl
==============
This is a Julia port of The [Tensorlab](https://tensorlab.net) library.

You must have [MATLAB](https://www.mathworks.com/products/matlab.html) installed with Tensorlab in its default path, e.g. in `pathdef.m`.

The main functions implemented in Tensorlab can be accessed as a Julia function with the same name.

```
julia> using LinearAlgebra, TensorLab

julia> A = randn(3,3,3)
3×3×3 Array{Float64,3}:
[:, :, 1] =
  0.649902  -0.109534    0.907078
 -1.26111   -0.0176002  -0.51236
 -1.59414   -0.434985   -0.752411

[:, :, 2] =
  0.0618039  -0.0255968  0.338745
  0.714425   -0.950121   0.131247
 -0.590256    0.575201   0.165245

[:, :, 3] =
  1.0065    1.13356   0.434658
 -0.110719  1.3273    0.328556
 -0.120059  0.740077  0.262104

julia> rankest(A) # shows an L-curve in a figure window

julia> decomp = cpd(A, 5)
1×3 Array{Array{Float64,2},2}:
 [-0.554402 -0.274693 … 0.554957 -0.714528; -0.362088 -0.945013 … 0.823353 0.45704; -0.396067 0.422924 … 0.867864 0.586782]  …  [-0.24136 -0.272803 … 0.686578 -0.95215; -0.772441 1.09266 … 0.338223 -0.0838138; -0.932652 -0.436686 … -1.07673 0.174959]

julia> backward_err = norm(A - cpdgen(decomp)) / norm(A)
1.5599461118370736e-16
```

If anything is missing, you may alternatively use the MATLAB.jl package and write the MATLAB code yourself.
