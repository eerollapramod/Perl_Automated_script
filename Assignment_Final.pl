#!/usr/bin/perl
# Building pipeline to report information about BRCA1(Q3B891)

use LWP::Simple;
print "Enter a Gene name:";

my $protein = <STDIN>;

$url1 = "http://www.uniprot.org/uniprot/?query=organism:9606+AND+accession:$protein&format=tab&columns=genes(PREFERRED)";
$url2 = "http://www.uniprot.org/uniprot/?query=organism:9606+AND+accession:$protein&format=tab&columns=sequence";

$protein_name = get $url1;
$protein_sequence = get $url2;

# getting rid of substring "sequence" and white spaces
$protein_sequence =~s/Sequence//;
$protein_name =~s/Gene names  \(primary \)//;
$protein_sequence=~s/\s//g;
$protein_name =~s/\n//g;

# Printing gene name of Q3B891
print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%	Step 1 : Printing Gene name		  	  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";
print "Gene Name:\n";
print "$protein_name\n";

print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%		 Printing the Sequence		  	  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";
#printing the sequence	
print "\nProtein Sequence:\n","$protein_sequence\n",;

#Calculating the isoelectric point
print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%	Step 2 : Calculating the isoelectric point	  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";

# Used Bio::Seq to turn the protein sequence into an object for Bio::Tools::pICalculator to calculate teh isoelectric point	
print "\n\nisoelectric point:\n";
use Bio::Seq;
use Bio::Tools::pICalculator;
$in_sequence = Bio::Seq->new(-seq=>$protein_sequence);
$calc = Bio::Tools::pICalculator->new(-places => 2);
$calc->seq($in_sequence);
          
$iso_electric_point = $calc->iep;

print  "\n$iso_electric_point\n\n";

# Counting the Amino acid composition and frequency
# And plotting a Bar Chart

print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%	Step 3 : Column Chart of amino acid Composition & frequency 	  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";

@split_protein_sequence = split(//, $protein_sequence);
$count_a=0;$count_c=0;$count_d=0;$count_e=0;$count_f=0;$count_g=0;$count_h=0;$count_i=0;$count_k=0;$count_l=0;$count_m=0;$count_n=0;$count_p=0;$count_q=0;$count_r=0;$count_s=0;$count_t=0;$count_w=0;$count_y=0;$count_v=0;

foreach $aminoacid (@split_protein_sequence){
	if($aminoacid eq 'A') {
		$count_a++;;
	}
	elsif($aminoacid eq 'C') {
		$count_c++;;
	}
	elsif($aminoacid eq 'D') {
		$count_d++;;
	}
	elsif($aminoacid eq 'E') {
		$count_e++;;
	}
	elsif($aminoacid eq 'F') {
		$count_f++;;
	}
	elsif($aminoacid eq 'G') {
		$count_g++;;
	}
	elsif($aminoacid eq 'H') {
		$count_h++;;
	}
	elsif($aminoacid eq 'I') {
		$count_i++;;
	}
	elsif($aminoacid eq 'K') {
		$count_k++;;
	}
	elsif($aminoacid eq 'L') {
		$count_l++;;
	}
	elsif($aminoacid eq 'M') {
		$count_m++;;
	}
	elsif($aminoacid eq 'N') {
		$count_n++;;
	}
	elsif($aminoacid eq 'P') {
		$count_p++;;
	}
	elsif($aminoacid eq 'Q') {
		$count_q++;;
	}
	elsif($aminoacid eq 'R') {
		$count_r++;;
	}
	elsif($aminoacid eq 'S') {
		$count_s++;;
	}
	elsif($aminoacid eq 'T') {
		$count_t++;;
	}
	elsif($aminoacid eq 'W') {
		$count_w++;;
	}
	elsif($aminoacid eq 'Y') {
		$count_y++;;
	}
	elsif($aminoacid eq 'V') {
		$count_v++;;
	}
};

#HTML script for Column Chart

print "HTML script for Column Chart:\n\n";
print<<END_HTML;
<HTML>
<head>
</head>

<body>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		function drawChart() {
		var data = google.visualization.arrayToDataTable([
			['Protein', 'Structures'],
END_HTML


print "['A', $count_a],\n";
print "['C', $count_c],\n";
print "['D', $count_d],\n";
print "['E', $count_e],\n";
print "['F', $count_f],\n";
print "['G', $count_g],\n";
print "['H', $count_h],\n";
print "['I', $count_i],\n";
print "['K', $count_k],\n";
print "['L', $count_l],\n";
print "['M', $count_m],\n";
print "['N', $count_n],\n";
print "['P', $count_p],\n";
print "['Q', $count_q],\n";
print "['R', $count_r],\n";
print "['S', $count_s],\n";
print "['T', $count_t],\n";
print "['W', $count_w],\n";
print "['Y', $count_y],\n";
print "['V', $count_v],\n";


print<<END_HTML
		]);
	var options = {
	title: 'Number of structures available for proteins',
	width: 700,
	height: 700,
	legend: { position: 'top', maxLines: 1 },
	bar: { groupWidth: '80%' },
	};

	var chart = new
	google.visualization.ColumnChart(document.getElementById('chart_div'));
	chart.draw(data, options);
	}
      </script>
      <div id="chart_div" style="width: 700px; height: 700px;"></div>

</body>
</HTML>

END_HTML
;
# step 4 :20 interacting proteins with quality score >=900

print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%	Step 4 : 20 Interacting	proteins(quality score over 900)	  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";

print "\n20 interacting proteins with quality score over 900:\n\n";

my $new_protein = "$protein_name";

$url3 = "http://string-db.org/api/tsv-no-header/interaction_partners?identifier=$new_protein&species=9606&limit=20&required_score=900";

$interaction_proteins = get $url3;

@my_array = split(/\n/,$interaction_proteins);

foreach $line(@my_array){
	@linearray = split(/\t/, $line);
	print "$linearray[2]\t =>  $linearray[3]\t => \t(Quality Score=> $linearray[5])\n";
}

# Creating network graph and highlighting the node RED

print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%	Step 5 : Network Graph & highlighting the node RED	  %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";

print "\nHTML script for Creating network graph and highlighting the BRCA1 node RED:\n\n";

print<<END_HTML;
<HTML>
<head>
	<script type="text/javascript" src="./vis/dist/vis.js"></script>
</head>
<body>

<div id="mygraph"></div>

<script type="text/javascript">
END_HTML

$url4 = "http://string-db.org/api/psi-mi-tab/interactions?identifier=$new_protein&species=9606&required_score=900&limit=20";

$network_content = get $url4;

@line_array = split(/\n/,$network_content);

foreach $line(@line_array){
	@new_element = split(/\t/,$line);
	
	#makeing protein list
	if(!grep $_ eq $new_element[2], @initnodearray){
		unshift @initnodearray, $new_element[2];
	}
	if(!grep $_ eq $new_element[3], @initnodearray){
		unshift @initnodearray, $new_element[3];
	}
}

print qq(var nodes = [);

for ($i=0; $i<@initnodearray; $i++){
	
	$nodeNum = $i+1;
	if ($initnodearray[$i] eq $protein_name){
		print qq({id: $nodeNum, label: '$initnodearray[$i]', color:'red'},);
	}
	else{ 
	print qq({id: $nodeNum, label: '$initnodearray[$i]'},);
}
}


print qq(];\n);

$nodeCount = 1;
foreach $node(@initnodearray){
	$nodeHash{$node} = $nodeCount;
	$nodeCount++;
}


print qq(var edges = [);

foreach $line(@line_array){
	@new_element = split(/\t/,$line);

	print qq({from: $nodeHash{$new_element[2]}, to:
	$nodeHash{$new_element[3]}},);
}

print qq(];);
print<<END_HTML;
		
	var container = document.getElementById('mygraph');
	var data = {
		nodes: nodes,
		edges: edges
};

	var options = {physics: {barnesHut: {gravitationalConstant: -9300,
	centralGravity: 0.55, springLength: 150, springConstant: 0.03,
	damping: 0.085}}, smoothCurves: false};

	var graph = new vis.Graph(container, data, options);
</script>

</body>
</HTML>
END_HTML

#step 6 : Getting PDB IDs from uniprot

print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%	Step 6 : Getting PDB Structure identifiers from Uniprot     %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";

# First get String IDs and from string database and turn it into an array
$url5 = "http://string-db.org/api/psi-mi-tab/interaction_partners?identifier=$new_protein&species=9606&limit=20&required_score=900";

$interaction_proteins = get $url5;

@my_array = split(/\n/,$interaction_proteins);

foreach $line(@my_array){
	@linearray = split(/\t/, $line);
	
	$string_IDs .= $linearray[1] ."\t";
}

$string_IDs .= $linearray[0]. "\t"; 
$string_IDs =~ s/string://g;
$string_IDs =~ s/9606.//g;

@array= split(/\t/, $string_IDs);

foreach $element_new (@array){
	$url6 = "https://www.uniprot.org/uniprot/?query=$element_new&sort=score&format=tab&columns=database(PDB)";
	
	$url7 = "https://www.uniprot.org/uniprot/?query=$element_new&sort=score&format=tab&columns=genes(PREFERRED)";
$my_pdb_ids = get $url6;
$my_gene_names = get $url7;

# Rearrange the gene names and pdb IDs in a user friendly order
@pdb_array = split(/\n/, $my_pdb_ids);
@genes_array = split(/\n/ , $my_gene_names);

print "Gene name: $genes_array[1]\n";
if (@pdb_array <=1) {
	print "\n";
	}
	else{
		print "PDB IDs: \n$pdb_array[1]\n\n";
		}
};

# Bar Chart for PDB IDs

print  "\n\t%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
	%		Step 7 : Bar Chart 	     %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n";

print "\nHTML script for creating Bar Chart:\n\n";

print<<END_HTML;
<HTML>
<head>
</head>

<body>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
     <script type="text/javascript">
	google.load("visualization", "1", {packages:["corechart"]});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
	var data = google.visualization.arrayToDataTable([
		['Protein', 'Structures'],
END_HTML

foreach $protein(@array){
	
	$url8 = "https://www.uniprot.org/uniprot/?query=$protein&organism:9606&database:pdb&format=tab&columns=database(PDB)";
	$url9 = "https://www.uniprot.org/uniprot/?query=$protein&sort=score&format=tab&columns=genes(PREFERRED)";

$my_pdb_content = get "$url8";
$my_pdb_content2 = get "$url9";
	
	@my_pdb_linearray = split(/\n/,$my_pdb_content);
	@my_pdb_linearray2 = split(/\n/,$my_pdb_content2);
	
	$my_pdb_list = $my_pdb_linearray[1];
	$my_pdb_list2 = $my_pdb_linearray2[1];
		
	@my_pdbIDs = split(/;/, $my_pdb_list);
	@my_pdbIDs2 = split(/;/, $my_pdb_list2);
	
	$my_pdb_Count = $#my_pdbIDs+1;

	if ($my_pdb_Count>=10){print  "['$my_pdb_list2', $my_pdb_Count],\n"};
}

print<<END_HTML
		]);
	var options = {
	title: 'Number of structures available for proteins',
	width: 700,
	height: 700,
	legend: { position: 'top', maxLines: 1 },
	bar: { groupWidth: '80%' },
	};
	
	var chart = new
	google.visualization.BarChart(document.getElementById('chart_div'));
	chart.draw(data, options);
	}
      </script>

	<div id="chart_div" style="width: 700px; height: 700px;"></div>

</body>
</HTML>

END_HTML
