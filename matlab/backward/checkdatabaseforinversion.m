function [dbase, info] = checkdatabaseforinversion(dbase, DynareModel)

% Check that dbase contains all the endogenous variables of the model, and
% reorder the endogenous variables as declared in the mod file. If Dynare
% adds auxiliary variables, for lags greater than 1 on endogebnous variables
% or lags on the exogenous variables.

% Copyright (C) 2017-2018 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

[dbase, info] = checkdatabase(dbase, DynareModel, true);