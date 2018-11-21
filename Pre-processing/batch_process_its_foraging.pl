# How to run this script: perl batch_process_its_foraging.pl 

# Written by Anne S. Warlaumont

use strict;
use warnings;

# Open the metadata file for this project
# open ORIGMETAFILE, "<", "/Users/awarlau/LENAInteraction/meta_foraging.txt" or die "Could not open the input file meta_foraging.txt\n";
open ORIGMETAFILE, "<", "/Users/awarlau/LENAInteraction/meta_foraging_new.txt" or die "Could not open the input file meta_foraging_new.txt\n";

# Create a new metadata file which gives data in terms of subrecordings (i.e. splitting at pauses)
# open NEWMETAFILE, ">", "/Users/awarlau/LENAInteraction/metanopauses_foraging.txt" or die "Could not open the output file metanopauses_foraging.txt\n";
open NEWMETAFILE, ">", "/Users/awarlau/LENAInteraction/metanopauses_foraging_new.txt" or die "Could not open the output file metanopauses_foraging_new.txt\n";

print NEWMETAFILE "id\tbirthdate\trecordingdate\tageindays\tfilebase\titsdir\twavdir\tsubrecnum\tsubrecstart\tsubrecend\tsubrecgmtstart\tsubrecgmtend\n";

# repeat for each file listed in the meta data file
while (my $line = <ORIGMETAFILE>){ 
	
	if ($line =~ /BASE/){
		$line = <ORIGMETAFILE>;
	}
	if ($line =~ /filebase/){
		$line = <ORIGMETAFILE>;
	}
	
	print $line; print "\n";
	
	chomp $line; # clean up line endings
	my @columns = split(/\s+/,$line); # make each column a separate element of an array
	
	my $filenameNoExtNoPath = $columns[4]; # this column of the meta file gives the base of the its filename 
	my $itsPath = $columns[5]; # this column of the meta file gives the directory (must have a final slash) where the ITS file can be found
	my $wavPath = $columns[6]; # this column of the meta file gives the directory (must have a final slash) where the WAV file can be found
	
	my $outPath = "/Users/awarlau/LENAInteraction/postitsfiles_foraging/"; # this is the location where new recording-specific output files will be saved
	
	# create a variable that has the path plus filename base (no ".its" extension), into which outputs will be saved
	my $filenameNoExt = $outPath . $filenameNoExtNoPath;
	
	# my $filenameIts = "/Users/awarlau/LENAInteraction/MemphisLENARecordings/itsfiles/" . $filenameNoExtNoPath . ".its"; # add the path and append the .its
	my $filenameIts = $itsPath . $filenameNoExtNoPath . ".its"; # Full path and filename for the ITS file
	
	my $pauseTimesFile = $filenameNoExt . "_PauseTimes.txt";
	system($^X,"recorderpauses.pl",$filenameIts,$pauseTimesFile);

	open PAUSEINPUTFILE, "<", $pauseTimesFile or die "Could not open the input file $pauseTimesFile\n";
	my $subreccount = 0;
	while (my $subrecline = <PAUSEINPUTFILE>){
		$subreccount++;
		chomp $subrecline;
		print NEWMETAFILE "$line\t$subreccount\t$subrecline\n";
	}
	close(PAUSEINPUTFILE);
	
	# Get a clean list of all the LENA speaker labeled segments and their start and end times.
	my $segmentsFile = $filenameNoExt . "_Segments.csv";
	system($^X,"segments.pl",$filenameIts,$segmentsFile);
	
	# Break down those lists of segments and start and end times into separate files for each subrecording.
	system($^X,"segmentsbysubrecording.pl",$pauseTimesFile,$segmentsFile,2,1);
	
	# my $bigwavfile = "/chroot/lab/LENAInteraction/MemphisLENARecordings/wavfiles/" . $filenameNoExtNoPath;
	# $bigwavfile = $bigwavfile . ".wav";
	my $bigwavfile = $wavPath . $filenameNoExtNoPath . ".wav";
	
	# For each subrecording, get the child and adult response info., extract the individual audio segments, get acoustic measures for the child segments, then write those measures to a child acoustics time series.
	for (my $subrecnum=1; $subrecnum<=$subreccount; $subrecnum++){
		
		my $subrecordingSegmentsFile = $filenameNoExt . "_Segments" . $subrecnum . ".txt";
		
		my $adultResponsesToChildFile = $filenameNoExt . "_AdultResponsesToChild_" . $subrecnum . ".txt";
		my $childResponsesToAdultFile = $filenameNoExt . "_ChildResponsesToAdult_" . $subrecnum . ".txt";
		my $response_t = 1;
		system($^X,"responses.pl",$subrecordingSegmentsFile,$adultResponsesToChildFile,$childResponsesToAdultFile,$response_t);
		
		# Get individual audio segments
		my $indwavdir = $filenameNoExt . '_' . $subrecnum . "_individualSounds/";
		mkdir($indwavdir) unless -d ($indwavdir);
		my $indwavbaseNoPath = $filenameNoExtNoPath . '_' . $subrecnum;
		my $indwavbase = $indwavdir . $indwavbaseNoPath;
		open MATLABSCRIPT, ">", "matlabscript.txt" or die "Could not open output file matlabscript.txt\n";
		print MATLABSCRIPT "getIndividualAudioSegments(\'" . $subrecordingSegmentsFile . "\',\'" . $bigwavfile . "\',\'" . $indwavbase . "\',0,{\'CHNSP\',\'FAN\',\'MAN\'})";
		close MATLABSCRIPT;
		system("/Applications/MATLAB_R2014a.app/bin/matlab -nodesktop -nojvm < matlabscript.txt >& matlabscript.log");
		unlink 'matlabscript.txt';
		unlink 'matlabscript.log';
		
		# Get acoustics time series
		my $acousticsTsFile = $filenameNoExt . "_acousticsTS_" . $subrecnum . ".csv";
		open MATLABSCRIPT_GET_TS, ">", "matlabscriptGetTs.txt" or die "Could not open output file matlabscriptGetTs.txt\n";
		print MATLABSCRIPT_GET_TS "getAcousticsTS(\'" . $subrecordingSegmentsFile . "\',\'" . $indwavdir . "\',\'" . $indwavbaseNoPath . "\',\'" . $acousticsTsFile . "\',{\'CHNSP\',\'FAN\',\'MAN\'})";
		system("/Applications/MATLAB_R2014a.app/bin/matlab -nodesktop -nojvm < matlabscriptGetTs.txt >& matlabscriptGetTs.log");
		unlink 'matlabscriptGetTs.txt';
		unlink 'matlabscriptGetTs.log';
	}
	
}

close(NEWMETAFILE);
close(ORIGMETAFILE);

# To do: Append meta_foraging_new.txt and metanopauses_foraging_new.txt to main meta_foraging.txt and metanopauses_foraging.txt?
