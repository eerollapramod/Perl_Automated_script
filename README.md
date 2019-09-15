# Pipeline to report information about BRCA1(Q3B891)

This script retrieves gene name of BRCA1, its sequence, isoelectric point, 20 interacting proteins with quality score higher than 900 and PDB IDs of proteins with more than 10 structures available. It also provides the user with a column chart of amino acid composition and frequency, a network graph of its interaction partners and a bar chart of proteins with more than 10 structures available.

# Dependencies

1. User must input the protein of interest "Q3B891" when prompted. This initiates the pipeline to retrieve the information.
2. This script requires the Perl 5.24.3 or later and Bio Perl installed. 
3. It also requires libraries [Vis](../Vis), [LWP](../LWP) and the file [LWP.pm](../LWP.pm) (provided within this repository). Make sure these are available from the running directory.
4. Program uses necessary modules from Bio Perl such as "pICalculator". Therefore,installing these modules is essential.
5. Script can be run from Command line, Perl command line interpreter or on Linux with Perl version 5.24.3 or later installed including all related modules of Bio Perl.
6. The HTML files generated from this running this script can be opened using any browser.

# Output

The user can retrieve information such as gene name, sequence, isoelectric point, 20 interacting proteins with quality score higher than 900 and PDB IDs of proteins with more than 10 structures available on the terminal as standard output. However it produces three HTML scripts to visualise the amino acid composition and frequency in column chart, a network graph of BRCA1 and its interacting proteins and a bar chart of proteins with more than 10 structures available. These HTML scripts are combined together ([Combined_File.html](https://github.com/eerollapramod/Perl_Automated_script/blob/master/Combined_File.html)) and available within the repository. This HTML file must be downloaded in order to open using browsers.
