function s = varsub(s,V,opt)
%VARSUB Variable substitution in string s using keys of structure V
%	VARSUB(STR,V) returns string STR after substition of any variable $xxx or ${xxx}
%	that matches fieldname in structure V.
%	Example:
%		V.report_date = datestr(now);
%		varsub('Report on ${report_date}',V)
%
%	VARSUB(STR,V,'tex') also subtitutes any unicode character to TeX markup.
%
%
%	Author: F. Beauducel / WEBOBS
%	Created: 2017-01-25, in Yogyakarta, Indonesia
%	Updated: 2019-02-15

for k = fieldnames(V)'
	s = regexprep(s,['\$',k{:},'\>'],V.(k{:}));	% $keyword (must be word isolated)
	s = regexprep(s,['\${',k{:},'}'],V.(k{:}));	% ${keyword}
	% keeps escaped underscores
	if ~isempty(strfind(V.(k{:}),'\_'))
		s = strrep(s,'_','\_');
	end
end

if nargin > 2 && strcmpi(opt,'tex')
	s = regexprep(s,'�','\\''e');
	s = regexprep(s,'�','\\`e');
	s = regexprep(s,'�','\\^e');
	s = regexprep(s,'�','\\^e');
	s = regexprep(s,'�','\\`a');
	s = regexprep(s,'�','\\^a');
end
