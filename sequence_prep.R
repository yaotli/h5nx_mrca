source( "./functions.R" )
require( ape )
require( tidyverse )
require( ggtree )
require( lubridate )
require( ggpubr )
require( seqinr )

sub.ls = gsub( "'", "", read.nexus( "source/sub_c2344.tre" )$tip.label )
leafEx( filedir = "source/pH5_7326_gsgd.fasta", leaflist = sub.ls )

rmDup( "./source/pH5_7326_gsgd_1865.fasta", rmdup = TRUE )
rmdup_plus( "./source/pH5_7326_gsgd_1865_cr.fasta" )

faslist_2344      <- taxaInfo( "./source/pH5_7326_gsgd_1865_cr_rmdP.fasta" )
faslist_2344[[8]] <- geoID( faslist_2344[[2]] )

cladeSampling( trefile   = "./source/iqtree_c2344.tre", 
               fasfile   = "./source/pH5_7326_gsgd_1865_cr_rmdP.fasta", 
               suppList  = TRUE, 
               listinput = faslist_2344,
               grid      = 0.5, 
               list.x    = c( 6, 4, 8 ), 
               saveFasta = TRUE )

tip.ac   <- str_match( gsub( "'", "", read.nexus( "./source/sub_iqtree_c2344_cs.tre" )$tip.label ), "^[A-Za-z0-9]+" )
toremove <- which( as.numeric( str_match( gsub( "'", "", read.nexus( "./source/sub_iqtree_c2344_cs.tre" )$tip.label ), "_([0-9.]+)$" )[,2] ) > 2016.5 )
tip.ac   <- tip.ac[ - toremove ] 

subfastaSeq( AC = TRUE, AC_list = tip.ac, filedir = "./source/pH5_7326_gsgd_1865_cr_rmdP_s.fasta" )

