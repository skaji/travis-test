test:
	curl -o cpanm --compressed -sSL http://cpanmin.us
	/usr/bin/perl -V
	/usr/bin/perl cpanm -V
	/usr/bin/perl cpanm -l perl5 --self-contained forks || { cat ~/.cpanm/build.log; false }
	find perl5 | grep List/MoreUtils
