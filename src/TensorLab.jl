module TensorLab
	import MATLAB: mxarray
	using MATLAB
	include("matlabTypes.jl")
	export Options, MatFcn

	# Create a table of functions and the number of outputs they return.
	# Also include the data types to get a minimal amount of type stability.
	# TODO: These functions have a variable number of outputs
	# - cpd (probably variants as well) (1 or 2)
	# - similar mechanism for lmlra
	# - mlsvd and variants (2 or 3)
	functions = [
		(:cpd, 1, cpd_type),
		(:cpd_als, 1, cpd_type),
		(:cpd_els, 1, cpd_type),
		(:cpd_gevd, 1, cpd_type),
		(:cpd_minf, 1, cpd_type),
		(:cpd_rbs, 1, cpd_type),
		(:cpd_rnd, 1, cpd_type),
		(:cpd3_sd, 1, cpd_type),
		(:cpd3_sgsd, 1, cpd_type),
		(:cpderr, 1, Float64),
		(:cpdgen, 1, Array{MatlabNum}),
		(:cpdres, 1, Array{MatlabNum}),
		(:fmt, 1, fmt_type),
		(:frob, 1, Float64),
		(:frobcpdres, 1, Float64),
		(:frobmlrares, 1, Float64),
		(:fromll1res, 1, Float64),
		(:ful, 1, Array{MatlabNum}),
		(:hankelize, 1, fmt_type),
		(:isvalidtensor, 1, Bool),
		(:kr, 1, Matrix{MatlabNum}),
		(:kron, 1, Matrix{MatlabNum}),
		(:ll1, 1, ll1_type),
		(:ll1_gevd, 1, ll1_type),
		(:ll1_minf, 1, ll1_type),
		(:ll1_rnd, 1, ll1_type),
		(:ll1convert, 1, ll1_type),
		(:ll1gen, 1, Array{MatlabNum}),
		(:ll1res, 1, Array{MatlabNum}),
		(:lmlra, 2, lmlra_type),
		(:lmlra3_dgn, 2, lmlra_type),
		(:lmlra3_rtr, 2, lmlra_type),
		(:lmlra_aca, 2, lmlra_type),
		(:lmlra_hooi, 2, lmlra_type),
		(:lmlra_minf, 2, lmlra_type),
		(:lmlra_nls, 2, lmlra_type),
		(:lmlra_rnd, 2, lmlra_type),
		(:lmlraerr, 1, Float64),
		(:lmlragen, 1, Array{MatlabNum}),
		(:lmlrares, 1, Array{MatlabNum}),
		(:mat2tens, 1, Array{MatlabNum}),
		(:mlrank, 1, Matrix{MatlabNum}),
		(:mlrankest, 0, Nothing),
		(:mlsvd, 3, mlsvd_type),
		(:mlsvd_rsi, 3, mlsvd_type),
		(:mlsvds, 3, mlsvd_type),
		(:rankest, 0, Nothing),
		(:surf3, 0, Nothing),
		(:slice3, 0, Nothing),
		(:tens2mat, 1, Matrix{MatlabNum}),
		(:tmprod, 1, Array{MatlabNum}),
		(:visualize, 0, Nothing),
		(:voxel3, 0, Nothing),
	]

	for (fcn, numout, tp) in functions
		@eval $fcn(args...) :: $tp = mxcall(Symbol($fcn), $numout, args...)
		@eval export $fcn
	end
end

