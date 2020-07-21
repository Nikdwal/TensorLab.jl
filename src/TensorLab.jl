module TensorLab
	import MATLAB: mxarray
	using MATLAB
	include("matlabTypes.jl")
	export Options, MatFcn

	# Create a table of functions and the number of outputs they return.
	# TODO: These functions have a variable number of outputs
	# - cpd (probably variants as well) (1 or 2)
	# - similar mechanism for lmlra
	# - mlsvd and variants (2 or 3)
	functions = [
		(:cpd, 1),
		(:cpd_als, 1),
		(:cpd_els, 1),
		(:cpd_gevd, 1),
		(:cpd_minf, 1),
		(:cpd_rbs, 1),
		(:cpd_rnd, 1),
		(:cpd3_sd, 1),
		(:cpd3_sgsd, 1),
		(:cpderr, 1),
		(:cpdgen, 1),
		(:cpdres, 1),
		(:fmt, 1),
		(:frob, 1),
		(:frobcpdres, 1),
		(:frobmlrares, 1),
		(:fromll1res, 1),
		(:ful, 1),
		(:hankelize, 1),
		(:isvalidtensor, 1),
		(:kr, 1),
		(:kron, 1),
		(:ll1, 1),
		(:ll1_gevd, 1),
		(:ll1_minf, 1),
		(:ll1_rnd, 1),
		(:ll1convert, 1),
		(:ll1gen, 1),
		(:ll1res, 1),
		(:lmlra, 2),
		(:lmlra3_dgn, 2),
		(:lmlra3_rtr, 2),
		(:lmlra_aca, 2),
		(:lmlra_hooi, 2),
		(:lmlra_minf, 2),
		(:lmlra_nls, 2),
		(:lmlra_rnd, 2),
		(:lmlraerr, 1),
		(:lmlragen, 1),
		(:lmlrares, 1),
		(:mat2tens, 1),
		(:mlrank, 1),
		(:mlrankest, 0),
		(:mlsvd, 3),
		(:mlsvd_rsi, 3),
		(:mlsvds, 3),
		(:rankest, 0),
		(:surf3,0),
		(:slice3,0),
		(:tens2mat, 1),
		(:tmprod, 1),
		(:visualize, 0),
		(:voxel3,0),
	]

	for (fcn, numout) in functions
		@eval $fcn(args...) = mxcall(Symbol($fcn), $numout, args...)
		@eval export $fcn
	end
end

