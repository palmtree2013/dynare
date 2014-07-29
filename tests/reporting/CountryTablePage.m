function rep = CountryTablePage(rep, countryAbbr, countryName, db_q, dc_q, db_a, dc_a, trange, vline_after)
% Copyright (C) 2013-2014 Dynare Team
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

seriesNames = {{'RS_', 'Short Term Interest Rate'}, ...
               {'RR_', 'Real Interest Rate'}, ...
               {'BLT_','Bank Lending Tightening' }, ...
               {'PCH_GROWTH_', 'Real GDP Growth (@q ar)'}, ...
               {'PCH_GROWTH4_', '\% y-o-y'}, ...
               {'PCH_GROWTH_BAR_', 'Potential GDP Growth (@q ar)'}, ...
               {'PCH_GROWTH4_BAR_', '\% y-o-y'}, ...
               {'PCH_PIE_', 'Headline CPI Inflation (@q ar)'}, ...
               {'PCH_PIE4_', '\% y-o-y'}, ...
               {'PCH_PIEX_', 'Core CPI Inflation (@q ar)'}, ...
               {'PCH_PIEX4_', '\% y-o-y'}, ...
               {'PCH_PIE_GAS_', 'Gas Inflation (@q ar)'}, ...
               {'PCH_PIE4_GAS_', '\% y-o-y'}, ...
               {'PCH_PIE_CONSFOOD_', 'Food Inflation (@q ar)'}, ...
               {'PCH_PIE4_CONSFOOD_', '\% y-o-y'}, ...
               {'PCH_DOT_REER_T_', 'REER Depreciation (@q ar)'}, ...
               {'PCH_DOT4_REER_T_', '\% y-o-y'}, ...
               {'Y_', 'Output Gap'}, ...
               {'UNR_', 'Unemployment Rate'}, ...
               {'UNR_BAR_', 'NAIRU'}, ...
               {'UNR_GAP_', 'Unemployment Gap'}};

otherThree = {'EA6','LA6','RC6'};
notForOtherThree = {'BLT_', 'UNR_', 'UNR_BAR_', 'UNR_GAP_'};

rep = rep.addTable('title', countryName, ...
                   'range', {trange, dates('2012a'):dates('2014a')}, ...
                   'vlineAfter', {vline_after dates('2014q4')}, ...
                   'writeCSV', true);



for i=1:length(seriesNames)
    if any(strcmp(countryAbbr, otherThree)) && ...
            any(strcmp(seriesNames{i}{1}, notForOtherThree))
        continue
    end
    db_q = db_q.tex_rename([seriesNames{i}{1} countryAbbr], seriesNames{i}{2});
    rep = rep.addSeries('data', db_q{[seriesNames{i}{1} countryAbbr]}, ...
                        'tableDataRhs', db_a{[seriesNames{i}{1} countryAbbr]});
    delta = db_q{[seriesNames{i}{1} countryAbbr]}-dc_q{[seriesNames{i}{1} countryAbbr]};
    delta = delta.tex_rename('$\Delta$');

    deltaa = db_a{[seriesNames{i}{1} countryAbbr]}-dc_a{[seriesNames{i}{1} countryAbbr]};
    deltaa = delta.tex_rename('$\Delta$');
    rep = rep.addSeries('data', delta, ...
                        'tableShowMarkers', true, ...
                        'tableRowIndent', 2, ...
                        'tableDataRhs', deltaa);
end
end
