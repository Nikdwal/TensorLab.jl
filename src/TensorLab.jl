module TensorLab
	import MATLAB: mxarray
	using MATLAB

	# Actual ints are rare in MATLAB: integers are usually stored as doubles.
	# Sometimes you get into trouble if the datatype of an integer value
	# is actually an int.
	mxarray(a :: Int) = mxarray(MatlabNum(a))

	# data types frequently returned by Tensorlab functions
	MatlabNum  = Float64
	cpd_type   = Matrix{Matrix{MatlabNum}}
	lmlra_type = Tuple{Matrix{Matrix{MatlabNum}}, Array{MatlabNum}}
	mlsvd_type = Tuple{Matrix{Matrix{MatlabNum}}, Array{MatlabNum}, Matrix{Vector{MatlabNum}}}
	fmt_type   = Union{Array{MatlabNum}, Dict{String, Any}}

	disableFigures() = mxcall(:set, 0, 0, "DefaultFigureVisible", "off")
	enableFigures()  = mxcall(:set, 0, 0, "DefaultFigureVisible", "on")

	# Create a table of functions and the number of outputs they return.
	# Also include the data types to get a minimal amount of type stability.
	# TODO: These functions have a variable number of outputs
	# - cpd (probably variants as well) (1 or 2)
	# - similar mechanism for lmlra
	# - mlsvd and variants (2 or 3)
	functions = Set([
		(:cpd, 1, cpd_type),
		(:cpd_als, 1, cpd_type),
		(:cpd_els, 1, cpd_type),
		(:cpd_gevd, 1, cpd_type),
		(:cpd_minf, 1, cpd_type),
		(:cpd_rbs, 1, cpd_type),
		(:cpd_rnd, 1, cpd_type),
		(:cpd3_sd, 1, cpd_type),
		(:cpd3_sgsd, 1, cpd_type),
		(:cpderr, 1, MatlabNum),
		(:cpdgen, 1, Array{MatlabNum}),
		(:cpdres, 1, Array{MatlabNum}),
		(:fmt, 1, fmt_type),
		(:frob, 1, MatlabNum),
		(:frobcpdres, 1, MatlabNum),
		(:frobmlrares, 1, MatlabNum),
		(:ful, 1, Array{MatlabNum}),
		(:hankelize, 1, fmt_type),
		(:isvalidtensor, 1, Bool),
		(:kr, 1, Matrix{MatlabNum}),
		(:kron, 1, Matrix{MatlabNum}),
		(:lmlra, 2, lmlra_type),
		(:lmlra3_dgn, 2, lmlra_type),
		(:lmlra3_rtr, 2, lmlra_type),
		(:lmlra_aca, 2, lmlra_type),
		(:lmlra_hooi, 2, lmlra_type),
		(:lmlra_minf, 2, lmlra_type),
		(:lmlra_nls, 2, lmlra_type),
		(:lmlra_rnd, 2, lmlra_type),
		(:lmlraerr, 1, MatlabNum),
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
	])

	for (fcn, numout, tp) in functions
		@eval $fcn(args...) :: $tp = mxcall(Symbol($fcn), $numout, args...)
		@eval export $fcn
	end
end

