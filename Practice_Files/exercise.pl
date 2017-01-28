use strict;
use warnings;

# Exercise: THE ANXIETY ANALYZER
# 	Read from an input file containing the names of people, their worry levels on a scale of 10 about 3 different things, the three different things that 
# 	they worry about, whether or not they have anxiety, and compute their anxiety level. Their anxiety level should be ranked from top to bottom, with a 
# 	section for recommendations (i.e. if their anxiety level is above 5,120 (or a related number), then they should seek therapy. If less, try meditation, 
# 	stress relief, distractions, etc...)

# Open the file
my $anxiety_file = $ARGV[0] or die "Please include a .csv file on the command line as the first argument.\n";
my $outfile = $ARGV[1] or die "Please include an output file name on the command line as the second argument.\n";

open (my $anxiety_data, "<", $anxiety_file) or die "Could not open '$anxiety_file' $!";
open (my $out_handle, ">", $outfile) or die "Could not open '$outfile'! Error: $!";
# Write headers of output file
print $out_handle "NAME\t\tTOTAL ANXIETY LEVEL\t\tCOMMENTS\n--------------\t------------------------------\t----------------------\n";

#Read a line of the file
while (my $line = <$anxiety_data>){
	my @values = split(/,/, $line);
	my $name = $values[0];
	my $worry1 = $values[1];
	my $worry2 = $values[2];
	my $worry3 = $values[3];
	my $anx_flag = substr($values[7], 0, 1); # works
	my $anxiety_level;
	
	# If has anxiety, use the calculator. If not, use regular way
	if ($anx_flag eq 'y') {
		$anxiety_level = anx_calculator("value1" => $worry1, "value2" => $worry2, "value3" => $worry3);
	} else {
		$anxiety_level = $worry1 * $worry2 * $worry3 * 1.5;
	}
	
	if ($anxiety_level > 2000) {
		print $out_handle $name."\t\t$anxiety_level\t\t\t\tPlease get help. Maybe medication should ease some of those worries.\n";
	} elsif ($anxiety_level > 1000) {
		print $out_handle $name."\t\t$anxiety_level\t\t\t\tMaybe some therapy would help?\n";
	} else {
		print $out_handle $name."\t\t$anxiety_level\t\t\t\tGood job managing your worries. Keep it up!\n";
	}
}

close $out_handle;
close $anxiety_data;

sub anx_calculator{
	my %args = @_;
	my $return_number = ($args{"value1"} * $args{"value2"} * $args{"value3"}) * 3;
	return $return_number;
}