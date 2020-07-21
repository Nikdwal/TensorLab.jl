import Base: show, getindex, setindex!, getproperty, setproperty!
import MATLAB: mxarray, put_variable
using MATLAB

# Actual ints are rare in MATLAB: integers are usually stored as doubles.
# Sometimes you get into trouble if the datatype of an integer value
# is actually an int.
mxarray(a :: Int) = mxarray(Float64(a))

# data types frequently returned by Tensorlab functions
MatlabNum    = Union{Float64, ComplexF64}
MatlabStruct = Dict{String, Any}
cpd_type     = Matrix{Matrix{MatlabNum}}
lmlra_type   = Tuple{Matrix{Matrix{MatlabNum}}, Array{MatlabNum}}
mlsvd_type   = Tuple{Matrix{Matrix{MatlabNum}}, Array{MatlabNum}, Matrix{Vector{MatlabNum}}}
fmt_type     = Union{Array{MatlabNum}, Dict{String, Any}}
ll1_type     = Matrix{Matrix{Array{MatlabNum}}}

# equivalent of a function handle in MATLAB 
mutable struct MatFcn
	funcName :: String
end

# make an options type whose syntax is very similar to that of MATLAB structs 
struct Options
	dict :: Dict{String, Any}
	Options() = new(Dict([]))
end

show(io :: IO, options :: Options) = show(io, options.dict)
getindex(options :: Options, key...) = getindex(options.dict, key...)
setindex!(options :: Options, value, key...) = setindex!(options.dict, value, key...)
getproperty(options :: Options, name :: Symbol) = name == :dict ? getfield(options, name) : getindex(options.dict, string(name))
setproperty!(options :: Options, name :: Symbol, x) = setindex!(options.dict, x, string(name))

# When we put a MatFcn into MATLAB, make it serve as a function handle
function convertMatFcn(sess :: MSession, name :: Symbol, fcn :: MatFcn)
	eval_string(sess, string(name, " = str2func('", fcn.funcName, "');"))
end

function put_variable(sess :: MSession, name :: Symbol, fcn :: MatFcn)
	put_variable(sess, name, fcn.funcName)
	convertMatFcn(sess, name, fcn)
end

function put_variable(sess :: MSession, name :: Symbol, options :: Options)
	put_variable(sess, name, options.dict)
	for (option, value) in options.dict
		if typeof(value) <: MatFcn
			convertMatFcn(sess, Symbol(string(string(name), ".", option)), value)
		end
	end
end



