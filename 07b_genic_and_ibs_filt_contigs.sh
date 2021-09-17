#!/bin/bash
#
#  Replace the USER name in this script with your username and
#  call your project whatever you want
#
#  This script must be made executable like this
#    chmod +x my_script
#
#  Submit this script to the queue with a command like this
#    run_script my_script.sh

##  Set username
USER=aubaxh002

## Set project name
PROJ=07_genic_and_ibs

## Create a directory on /scratch
mkdir /scratch/${USER}_${PROJ}/

## Set permissions for directory
chmod 700 /scratch/${USER}_${PROJ}/

## cd into working scratch directory
cd /scratch/${USER}_${PROJ}/


## --------------------------------
## Load module 
module load anaconda/3-2020.11
module load vcftools/0.1.14


## --------------------------------
## Keep only SNPs located on filtered contigs (n=652);
## Ugly but more reliable than filtering separately then merging
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	vcftools \
# 	--out ${i}_filtcontigs \
# 	--gzvcf ${i}.recode.vcf.gz \
# 	--recode --recode-INFO-all \
# 	--chr ptg000002l \
# 	--chr ptg000095l \
# 	--chr ptg000054l \
# 	--chr ptg000140l \
# 	--chr ptg000043l \
# 	--chr ptg000096l \
# 	--chr ptg000001l \
# 	--chr ptg000032l \
# 	--chr ptg000024l \
# 	--chr ptg000009l \
# 	--chr ptg000783l \
# 	--chr ptg000019l \
# 	--chr ptg000069l \
# 	--chr ptg000145l \
# 	--chr ptg000098l \
# 	--chr ptg000081l \
# 	--chr ptg000157l \
# 	--chr ptg000125l \
# 	--chr ptg000018l \
# 	--chr ptg000051l \
# 	--chr ptg000108l \
# 	--chr ptg000147l \
# 	--chr ptg000297l \
# 	--chr ptg000089l \
# 	--chr ptg000094l \
# 	--chr ptg000006l \
# 	--chr ptg000234l \
# 	--chr ptg000163l \
# 	--chr ptg000017l \
# 	--chr ptg000175l \
# 	--chr ptg000197l \
# 	--chr ptg000003l \
# 	--chr ptg000365l \
# 	--chr ptg000042l \
# 	--chr ptg000004l \
# 	--chr ptg000115l \
# 	--chr ptg000053l \
# 	--chr ptg000039l \
# 	--chr ptg000207l \
# 	--chr ptg000092l \
# 	--chr ptg000026l \
# 	--chr ptg000301l \
# 	--chr ptg000138l \
# 	--chr ptg000050l \
# 	--chr ptg000187l \
# 	--chr ptg000066l \
# 	--chr ptg000015l \
# 	--chr ptg000136l \
# 	--chr ptg000075l \
# 	--chr ptg000178l \
# 	--chr ptg000137l \
# 	--chr ptg000179l \
# 	--chr ptg000273l \
# 	--chr ptg000030l \
# 	--chr ptg000034l \
# 	--chr ptg000173l \
# 	--chr ptg000436l \
# 	--chr ptg000076l \
# 	--chr ptg000228l \
# 	--chr ptg000141l \
# 	--chr ptg000215l \
# 	--chr ptg000046l \
# 	--chr ptg000174l \
# 	--chr ptg000085l \
# 	--chr ptg000264l \
# 	--chr ptg000045l \
# 	--chr ptg000289l \
# 	--chr ptg000021l \
# 	--chr ptg000121l \
# 	--chr ptg000102l \
# 	--chr ptg000169l \
# 	--chr ptg000241l \
# 	--chr ptg000067l \
# 	--chr ptg000210l \
# 	--chr ptg000073l \
# 	--chr ptg000422l \
# 	--chr ptg000231l \
# 	--chr ptg000107l \
# 	--chr ptg000158l \
# 	--chr ptg000669l \
# 	--chr ptg000023l \
# 	--chr ptg000052l \
# 	--chr ptg000118l \
# 	--chr ptg000288l \
# 	--chr ptg000070l \
# 	--chr ptg000233l \
# 	--chr ptg000295l \
# 	--chr ptg000266l \
# 	--chr ptg000190l \
# 	--chr ptg000312l \
# 	--chr ptg000227l \
# 	--chr ptg000012l \
# 	--chr ptg000078l \
# 	--chr ptg000363l \
# 	--chr ptg000307l \
# 	--chr ptg000516l \
# 	--chr ptg000203l \
# 	--chr ptg000242l \
# 	--chr ptg000463l \
# 	--chr ptg000148l \
# 	--chr ptg000230l \
# 	--chr ptg000063l \
# 	--chr ptg000335l \
# 	--chr ptg000262l \
# 	--chr ptg000205l \
# 	--chr ptg000188l \
# 	--chr ptg000329l \
# 	--chr ptg000219l \
# 	--chr ptg000152l \
# 	--chr ptg000057l \
# 	--chr ptg000240l \
# 	--chr ptg000059l \
# 	--chr ptg000127l \
# 	--chr ptg000201l \
# 	--chr ptg000080l \
# 	--chr ptg000129l \
# 	--chr ptg000183l \
# 	--chr ptg000038l \
# 	--chr ptg000258l \
# 	--chr ptg000287l \
# 	--chr ptg000193l \
# 	--chr ptg000274l \
# 	--chr ptg000119l \
# 	--chr ptg000112l \
# 	--chr ptg000421l \
# 	--chr ptg000225l \
# 	--chr ptg000276l \
# 	--chr ptg000360l \
# 	--chr ptg000036l \
# 	--chr ptg000155l \
# 	--chr ptg000097l \
# 	--chr ptg000126l \
# 	--chr ptg000239l \
# 	--chr ptg000116l \
# 	--chr ptg000083l \
# 	--chr ptg000449l \
# 	--chr ptg000362l \
# 	--chr ptg000105l \
# 	--chr ptg000065l \
# 	--chr ptg000268l \
# 	--chr ptg000235l \
# 	--chr ptg000010l \
# 	--chr ptg000505l \
# 	--chr ptg000199l \
# 	--chr ptg000351l \
# 	--chr ptg000143l \
# 	--chr ptg000165l \
# 	--chr ptg000298l \
# 	--chr ptg000327l \
# 	--chr ptg000191l \
# 	--chr ptg000040l \
# 	--chr ptg000309l \
# 	--chr ptg000047l \
# 	--chr ptg000185l \
# 	--chr ptg000008l \
# 	--chr ptg000483l \
# 	--chr ptg000306l \
# 	--chr ptg000263l \
# 	--chr ptg000278l \
# 	--chr ptg000333l \
# 	--chr ptg000420l \
# 	--chr ptg000457l \
# 	--chr ptg000504l \
# 	--chr ptg000547l \
# 	--chr ptg000159l \
# 	--chr ptg000064l \
# 	--chr ptg000166l \
# 	--chr ptg000361l \
# 	--chr ptg000344l \
# 	--chr ptg000029l \
# 	--chr ptg000532l \
# 	--chr ptg000162l \
# 	--chr ptg000480l \
# 	--chr ptg000387l \
# 	--chr ptg000014l \
# 	--chr ptg000130l \
# 	--chr ptg000499l \
# 	--chr ptg000373l \
# 	--chr ptg000506l \
# 	--chr ptg000172l \
# 	--chr ptg000250l \
# 	--chr ptg000279l \
# 	--chr ptg000284l \
# 	--chr ptg000200l \
# 	--chr ptg000299l \
# 	--chr ptg000144l \
# 	--chr ptg000134l \
# 	--chr ptg000214l \
# 	--chr ptg000599l \
# 	--chr ptg000355l \
# 	--chr ptg000386l \
# 	--chr ptg000440l \
# 	--chr ptg000481l \
# 	--chr ptg000487l \
# 	--chr ptg000033l \
# 	--chr ptg000323l \
# 	--chr ptg000529l \
# 	--chr ptg000304l \
# 	--chr ptg000600l \
# 	--chr ptg000259l \
# 	--chr ptg000267l \
# 	--chr ptg000285l \
# 	--chr ptg000224l \
# 	--chr ptg000104l \
# 	--chr ptg000229l \
# 	--chr ptg000404l \
# 	--chr ptg000477l \
# 	--chr ptg000428l \
# 	--chr ptg000320l \
# 	--chr ptg000366l \
# 	--chr ptg000007l \
# 	--chr ptg000238l \
# 	--chr ptg000167l \
# 	--chr ptg000303l \
# 	--chr ptg000416l \
# 	--chr ptg000260l \
# 	--chr ptg000300l \
# 	--chr ptg000062l \
# 	--chr ptg000388l \
# 	--chr ptg000226l \
# 	--chr ptg000192l \
# 	--chr ptg000170l \
# 	--chr ptg000232l \
# 	--chr ptg000272l \
# 	--chr ptg000146l \
# 	--chr ptg000171l \
# 	--chr ptg000204l \
# 	--chr ptg000558l \
# 	--chr ptg000058l \
# 	--chr ptg000302l \
# 	--chr ptg000270l \
# 	--chr ptg000472l \
# 	--chr ptg000189l \
# 	--chr ptg000455l \
# 	--chr ptg000294l \
# 	--chr ptg000122l \
# 	--chr ptg000714l \
# 	--chr ptg000415l \
# 	--chr ptg000498l \
# 	--chr ptg000186l \
# 	--chr ptg000256l \
# 	--chr ptg000569l \
# 	--chr ptg000220l \
# 	--chr ptg000342l \
# 	--chr ptg000212l \
# 	--chr ptg000106l \
# 	--chr ptg000491l \
# 	--chr ptg000628l \
# 	--chr ptg000408l \
# 	--chr ptg000247l \
# 	--chr ptg000318l \
# 	--chr ptg000349l \
# 	--chr ptg000405l \
# 	--chr ptg000177l \
# 	--chr ptg000581l \
# 	--chr ptg000275l \
# 	--chr ptg000341l \
# 	--chr ptg000396l \
# 	--chr ptg000049l \
# 	--chr ptg000139l \
# 	--chr ptg000611l \
# 	--chr ptg000068l \
# 	--chr ptg000527l \
# 	--chr ptg000378l \
# 	--chr ptg000160l \
# 	--chr ptg000079l \
# 	--chr ptg000020l \
# 	--chr ptg000418l \
# 	--chr ptg000282l \
# 	--chr ptg000290l \
# 	--chr ptg000513l \
# 	--chr ptg000545l \
# 	--chr ptg000391l \
# 	--chr ptg000255l \
# 	--chr ptg000086l \
# 	--chr ptg000149l \
# 	--chr ptg000359l \
# 	--chr ptg000343l \
# 	--chr ptg000380l \
# 	--chr ptg000576l \
# 	--chr ptg000667l \
# 	--chr ptg000022l \
# 	--chr ptg000317l \
# 	--chr ptg000055l \
# 	--chr ptg000195l \
# 	--chr ptg000213l \
# 	--chr ptg000559l \
# 	--chr ptg000150l \
# 	--chr ptg000589l \
# 	--chr ptg000469l \
# 	--chr ptg000402l \
# 	--chr ptg000570l \
# 	--chr ptg000257l \
# 	--chr ptg000206l \
# 	--chr ptg000037l \
# 	--chr ptg000454l \
# 	--chr ptg000376l \
# 	--chr ptg000458l \
# 	--chr ptg000679l \
# 	--chr ptg000512l \
# 	--chr ptg000123l \
# 	--chr ptg000594l \
# 	--chr ptg000555l \
# 	--chr ptg000310l \
# 	--chr ptg000334l \
# 	--chr ptg000305l \
# 	--chr ptg000536l \
# 	--chr ptg000514l \
# 	--chr ptg000211l \
# 	--chr ptg000473l \
# 	--chr ptg000340l \
# 	--chr ptg000128l \
# 	--chr ptg000394l \
# 	--chr ptg000322l \
# 	--chr ptg000117l \
# 	--chr ptg000114l \
# 	--chr ptg000534l \
# 	--chr ptg000248l \
# 	--chr ptg000099l \
# 	--chr ptg000044l \
# 	--chr ptg000409l \
# 	--chr ptg000566l \
# 	--chr ptg000601l \
# 	--chr ptg000161l \
# 	--chr ptg000511l \
# 	--chr ptg000434l \
# 	--chr ptg000218l \
# 	--chr ptg000621l \
# 	--chr ptg000072l \
# 	--chr ptg000281l \
# 	--chr ptg000375l \
# 	--chr ptg000508l \
# 	--chr ptg000124l \
# 	--chr ptg000336l \
# 	--chr ptg000286l \
# 	--chr ptg000142l \
# 	--chr ptg000551l \
# 	--chr ptg000494l \
# 	--chr ptg000474l \
# 	--chr ptg000575l \
# 	--chr ptg000699l \
# 	--chr ptg000395l \
# 	--chr ptg000314l \
# 	--chr ptg000293l \
# 	--chr ptg000427l \
# 	--chr ptg000432l \
# 	--chr ptg000252l \
# 	--chr ptg000590l \
# 	--chr ptg000556l \
# 	--chr ptg000528l \
# 	--chr ptg000196l \
# 	--chr ptg000728l \
# 	--chr ptg000265l \
# 	--chr ptg000671l \
# 	--chr ptg000209l \
# 	--chr ptg000246l \
# 	--chr ptg000445l \
# 	--chr ptg000430l \
# 	--chr ptg000609l \
# 	--chr ptg000557l \
# 	--chr ptg000531l \
# 	--chr ptg000379l \
# 	--chr ptg000478l \
# 	--chr ptg000109l \
# 	--chr ptg000350l \
# 	--chr ptg000554l \
# 	--chr ptg000316l \
# 	--chr ptg000074l \
# 	--chr ptg000517l \
# 	--chr ptg000693l \
# 	--chr ptg000005l \
# 	--chr ptg000653l \
# 	--chr ptg000614l \
# 	--chr ptg000442l \
# 	--chr ptg000184l \
# 	--chr ptg000495l \
# 	--chr ptg000503l \
# 	--chr ptg000588l \
# 	--chr ptg000088l \
# 	--chr ptg000519l \
# 	--chr ptg000460l \
# 	--chr ptg000315l \
# 	--chr ptg000686l \
# 	--chr ptg000249l \
# 	--chr ptg000661l \
# 	--chr ptg000657l \
# 	--chr ptg000620l \
# 	--chr ptg000354l \
# 	--chr ptg000448l \
# 	--chr ptg000542l \
# 	--chr ptg000443l \
# 	--chr ptg000496l \
# 	--chr ptg000544l \
# 	--chr ptg000103l \
# 	--chr ptg000291l \
# 	--chr ptg000321l \
# 	--chr ptg000520l \
# 	--chr ptg000216l \
# 	--chr ptg000649l \
# 	--chr ptg000451l \
# 	--chr ptg000202l \
# 	--chr ptg000826l \
# 	--chr ptg000652l \
# 	--chr ptg000222l \
# 	--chr ptg000578l \
# 	--chr ptg000623l \
# 	--chr ptg000011l \
# 	--chr ptg000413l \
# 	--chr ptg000634l \
# 	--chr ptg000692l \
# 	--chr ptg000419l \
# 	--chr ptg000025l \
# 	--chr ptg000540l \
# 	--chr ptg000253l \
# 	--chr ptg000384l \
# 	--chr ptg000393l \
# 	--chr ptg000016l \
# 	--chr ptg000502l \
# 	--chr ptg000552l \
# 	--chr ptg000466l \
# 	--chr ptg000332l \
# 	--chr ptg000371l \
# 	--chr ptg000651l \
# 	--chr ptg000261l \
# 	--chr ptg000441l \
# 	--chr ptg000640l \
# 	--chr ptg000606l \
# 	--chr ptg000425l \
# 	--chr ptg000417l \
# 	--chr ptg000746l \
# 	--chr ptg000488l \
# 	--chr ptg000446l \
# 	--chr ptg000539l \
# 	--chr ptg000374l \
# 	--chr ptg000277l \
# 	--chr ptg000133l \
# 	--chr ptg000208l \
# 	--chr ptg000635l \
# 	--chr ptg000773l \
# 	--chr ptg000571l \
# 	--chr ptg000710l \
# 	--chr ptg000470l \
# 	--chr ptg000435l \
# 	--chr ptg000702l \
# 	--chr ptg000587l \
# 	--chr ptg000313l \
# 	--chr ptg000392l \
# 	--chr ptg000541l \
# 	--chr ptg000438l \
# 	--chr ptg000644l \
# 	--chr ptg000493l \
# 	--chr ptg000616l \
# 	--chr ptg000337l \
# 	--chr ptg000518l \
# 	--chr ptg000198l \
# 	--chr ptg000546l \
# 	--chr ptg000296l \
# 	--chr ptg000439l \
# 	--chr ptg000510l \
# 	--chr ptg000636l \
# 	--chr ptg000646l \
# 	--chr ptg000027l \
# 	--chr ptg000598l \
# 	--chr ptg000523l \
# 	--chr ptg000456l \
# 	--chr ptg000452l \
# 	--chr ptg000637l \
# 	--chr ptg000639l \
# 	--chr ptg000665l \
# 	--chr ptg000485l \
# 	--chr ptg000243l \
# 	--chr ptg000662l \
# 	--chr ptg000656l \
# 	--chr ptg000597l \
# 	--chr ptg000338l \
# 	--chr ptg000613l \
# 	--chr ptg000658l \
# 	--chr ptg000771l \
# 	--chr ptg000331l \
# 	--chr ptg000592l \
# 	--chr ptg000358l \
# 	--chr ptg000471l \
# 	--chr ptg000772l \
# 	--chr ptg000245l \
# 	--chr ptg000429l \
# 	--chr ptg000610l \
# 	--chr ptg000509l \
# 	--chr ptg000035l \
# 	--chr ptg000475l \
# 	--chr ptg000453l \
# 	--chr ptg000668l \
# 	--chr ptg000705l \
# 	--chr ptg000237l \
# 	--chr ptg000406l \
# 	--chr ptg000648l \
# 	--chr ptg000090l \
# 	--chr ptg000725l \
# 	--chr ptg000706l \
# 	--chr ptg000461l \
# 	--chr ptg000654l \
# 	--chr ptg000579l \
# 	--chr ptg000385l \
# 	--chr ptg000630l \
# 	--chr ptg000326l \
# 	--chr ptg000631l \
# 	--chr ptg000467l \
# 	--chr ptg000562l \
# 	--chr ptg000696l \
# 	--chr ptg000596l \
# 	--chr ptg000561l \
# 	--chr ptg000756l \
# 	--chr ptg000168l \
# 	--chr ptg000643l \
# 	--chr ptg000792l \
# 	--chr ptg000641l \
# 	--chr ptg000577l \
# 	--chr ptg000760l \
# 	--chr ptg000934l \
# 	--chr ptg000674l \
# 	--chr ptg000521l \
# 	--chr ptg000784l \
# 	--chr ptg000684l \
# 	--chr ptg000486l \
# 	--chr ptg000401l \
# 	--chr ptg000763l \
# 	--chr ptg000535l \
# 	--chr ptg000633l \
# 	--chr ptg000683l \
# 	--chr ptg000217l \
# 	--chr ptg000550l \
# 	--chr ptg000383l \
# 	--chr ptg000713l \
# 	--chr ptg000814l \
# 	--chr ptg000604l \
# 	--chr ptg000695l \
# 	--chr ptg000431l \
# 	--chr ptg000755l \
# 	--chr ptg000501l \
# 	--chr ptg000330l \
# 	--chr ptg000608l \
# 	--chr ptg000591l \
# 	--chr ptg000733l \
# 	--chr ptg000711l \
# 	--chr ptg000762l \
# 	--chr ptg000617l \
# 	--chr ptg000398l \
# 	--chr ptg000737l \
# 	--chr ptg000697l \
# 	--chr ptg000690l \
# 	--chr ptg000723l \
# 	--chr ptg000854l \
# 	--chr ptg000595l \
# 	--chr ptg000691l \
# 	--chr ptg000563l \
# 	--chr ptg000500l \
# 	--chr ptg000292l \
# 	--chr ptg000251l \
# 	--chr ptg000712l \
# 	--chr ptg000719l \
# 	--chr ptg000761l \
# 	--chr ptg000530l \
# 	--chr ptg000785l \
# 	--chr ptg000789l \
# 	--chr ptg000629l \
# 	--chr ptg000681l \
# 	--chr ptg000548l \
# 	--chr ptg000672l \
# 	--chr ptg000829l \
# 	--chr ptg000663l \
# 	--chr ptg000537l \
# 	--chr ptg000650l \
# 	--chr ptg000465l \
# 	--chr ptg000618l \
# 	--chr ptg000647l \
# 	--chr ptg000476l \
# 	--chr ptg000687l \
# 	--chr ptg000729l \
# 	--chr ptg000815l \
# 	--chr ptg000775l \
# 	--chr ptg000747l \
# 	--chr ptg000497l \
# 	--chr ptg000447l \
# 	--chr ptg000800l \
# 	--chr ptg000796l \
# 	--chr ptg000574l \
# 	--chr ptg000553l \
# 	--chr ptg000685l \
# 	--chr ptg000722l \
# 	--chr ptg000615l \
# 	--chr ptg000802l \
# 	--chr ptg000382l \
# 	--chr ptg000776l \
# 	--chr ptg000280l \
# 	--chr ptg000847l \
# 	--chr ptg000694l \
# 	--chr ptg000624l \
# 	--chr ptg000786l \
# 	--chr ptg000700l \
# 	--chr ptg000100l \
# 	--chr ptg000682l \
# 	--chr ptg000688l \
# 	--chr ptg000743l \
# 	--chr ptg000585l \
# 	--chr ptg000799l \
# 	--chr ptg000838l \
# 	--chr ptg000407l \
# 	--chr ptg000381l \
# 	--chr ptg000720l \
# 	--chr ptg000867l \
# 	--chr ptg000759l \
# 	--chr ptg000754l \
# 	--chr ptg000602l \
# 	--chr ptg000726l \
# 	--chr ptg000752l \
# 	--chr ptg000724l \
# 	--chr ptg000816l \
# 	--chr ptg000936l \
# 	--chr ptg000645l \
# 	--chr ptg000951l \
# 	--chr ptg000730l \
# 	--chr ptg000767l \
# 	--chr ptg000797l \
# 	--chr ptg000717l \
# 	--chr ptg000605l \
# 	--chr ptg000852l \
# 	--chr ptg000703l \
# 	--chr ptg000721l \
# 	--chr ptg000805l \
# 	--chr ptg000942l \
# 	--chr ptg000774l \
# 	--chr ptg000777l \
# 	--chr ptg000953l \
# 	--chr ptg000855l \
# 	--chr ptg000812l \
# 	--chr ptg000893l \
# 	--chr ptg000748l \
# 	--chr ptg000871l \
# 	--chr ptg001007l \
# 	--chr ptg000745l \
# 	--chr ptg000907l \
# 	--chr ptg000675l \
# 	--chr ptg000803l \
# 	--chr ptg000750l \
# 	--chr ptg000397l \
# 	--chr ptg000731l \
# 	--chr ptg000715l \
# 	--chr ptg000833l \
# 	--chr ptg000766l \
# 	--chr ptg000765l \
# 	--chr ptg000603l \
# 	--chr ptg000839l \
# 	--chr ptg000811l
# 	done


## --------------------------------
## Convert VCF to PLINK format(s)
# module load samtools
# 
# 
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	bgzip ${i}_filtcontigs.recode.vcf
# 	
# 	plink \
# 	--vcf ${i}_filtcontigs.recode.vcf.gz \
# 	--allow-extra-chr \
# 	--out ${i}_filtcontigs
# 	done
# 
# 
# ## --------------------------------
# ## Produce .ped and .map files for PLINK
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	vcftools --plink \
# 	--out ${i}_filtcontigs \
# 	--gzvcf ${i}_filtcontigs.recode.vcf.gz
# 	done
# 
# 
# ## --------------------------------
# ## Run PLINK to calculate IBS -- produces a matrix of proportions of sites identical 
# ## between samples
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	plink \
# 	--file ${i}_filtcontigs \
# 	--out ${i}_filtcontigs \
# 	--distance ibs flat-missing 
# 	done
# 	
# 
# ## Run PLINK to calculate IBD -- see Ch. 8 here: 
# ## https://zzz.bwh.harvard.edu/plink/dist/plink-doc-1.07.pdf, but using v1.9 
# for i in allsamps_het_filt \
# 		 allsamps_het_filt_genicSNPs \
# 		 allsamps_het_filt_intergenicSNPs \
# 		 allsamps_het_filt_genicSNPs_5kbbuffer \
# 		 allsamps_het_filt_intergenicSNPs_5kbbuffer
# 	do
# 	plink \
# 	--file ${i}_filtcontigs \
# 	--out ${i}_filtcontigs \
# 	--genome full
# 	done
	
## --------------------------------
## Copy VCF files back to project output directory (in home) (downstream steps are fast)
