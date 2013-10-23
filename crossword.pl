#!/usr/bin/perl

use Text::CSV;

#my @rows;
my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
                 or die "Cannot use CSV: ".Text::CSV->error_diag ();

my $count = 0;
my $iter = 0;
my $min = 0;
my $cities = {};
 
open my $fh, "citycsv.txt" or die "csv file: $!";
while ( my $row = $csv->getline( $fh ) ) 
{
	if ($row->[6] =~ /.* (city|town)$/  && $row->[8] > $min)
	{
		if (not exists $cities->{ $row->[6].$row->[7] })
		{
			$cities->{$row->[6].$row->[7]} = $row->[8];
			print "$row->[6] \n";
			$count += $row->[8];
		}
		$iter++;
		#if( $iter==20) {exit;}
	}
    #push @rows, $row;
}

print "total population equals $count\n";

exit;
