# -*- Mode: Perl; indent-tabs-mode: nil; -*-

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
              NAME         => 'libservlet',
              VERSION_FROM => 'lib/Servlet.pm',
              PREREQ_PM    => { 'Exception::Class' => 0 },
             );

package MY;

sub MY::postamble {
    q(

POD2HTML=pod2html

TOPFILES=TODO

APIFILES=`$(FULLPERL) -MFile::Find -e 'sub trim { return unless m|\.pm$$|; s|\.pm$$||; $$name = "$$File::Find::dir/$$_"; $$name =~ s|^\./lib/||; print "$$name\n" }; find\(\&trim, "./lib"\)'`

html:  html-top html-api

html-top:
	@(for f in $(TOPFILES); do \
		echo generating doc/$$f.html; \
		$(POD2HTML) --htmlroot=./ \
		            --css=./libservlet.css \
		            --infile=$$f \
		            --outfile=doc/$$f.html; \
	done)

html-api:
	@(for f in $(APIFILES); do \
		echo generating doc/api/$$f.html; \
		slashes=`$(FULLPERL) -e 'print "../" x (split /\//, $$ARGV[0])' $$f`; \
		$(POD2HTML) --htmlroot=$${slashes}api \
		            --css=$${slashes}libservlet.css \
		            --infile=lib/$$f.pm \
		            --outfile=doc/api/$$f.html; \
	done)
);
}
