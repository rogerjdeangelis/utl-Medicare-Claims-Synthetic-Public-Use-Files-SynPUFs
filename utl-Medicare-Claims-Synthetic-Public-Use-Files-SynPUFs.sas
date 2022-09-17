%stop_submission;

%let pgm =utl-Medicare-Claims-Synthetic-Public-Use-Files-SynPUFs;

%let pgm=rad_010get;

/********************************************************************************************************************************************************************/
/*                                                                                                                                                                  */
/* Medicare Claims Synthetic Public Use Files SynPUFs                                                                                                               */
/*                                                                                                                                                                  */
/* CMS has spilt up the each of the following claim files into 20 very small pieces for a total of 140 files                                                        */
/*                                                                                                                                                                  */
/* https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample01                                                        */
/* https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample02                                                        */
/* ...                                                                                                                                                              */
/* https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample20                                                        */
/*                                                                                                                                                                  */
/*  DE1.0 Sample 1-20 2008 Beneficiary Summary File (ZIP)     (20 very small files)                                                                                 */
/*  DE1.0 Sample 1-20 2008-2010 Carrier Claims 1              ...                                                                                                   */
/*  DE1.0 Sample 1-20 2008-2010 Carrier Claims 2                                                                                                                    */
/*  DE1.0 Sample 1-20 2008-2010 Inpatient Claims (ZIP)                                                                                                              */
/*  DE1.0 Sample 1-20 2008-2010 Outpatient Claims (ZIP)                                                                                                             */
/*  DE1.0 Sample 1-20 2008-2010 Prescription Drug Events                                                                                                            */
/*  DE1.0 Sample 1-20 2009 Beneficiary Summary File (ZIP)                                                                                                           */
/*  DE1.0 Sample 1-20 2010 Beneficiary Summary File (ZIP)                                                                                                           */
/*                                                                                                                                                                  */
/*  I have combined all 140+ csvz files into five small SAS files                                                                                                   */
/*                                                                                                                                                                  */
/*  ./rad/rad_010inpatient,rad.rad_010inpatient.sas7bdat                                                                                                            */
/*  ./rad/rad_010bne,rad.rad_010bne.sas7bdat                                                                                                                        */
/*  ./rad/rad_010outpatient,rad.rad_010outpatient.sas7bdat                                                                                                          */
/*  ./rad/rad_010drug,rad.rad_010drug.sas7bdat                                                                                                                      */
/*  ./rad/rad_010carier,rad.rad_010carier.sas7bdat                                                                                                                  */
/*                                                                                                                                                                  */
/*  Summaries and SAS code for all cliam types          DOWNLOAD SAS TABLES (data from the 150+ CMS FILES CSVs                                                      */
/*                                                                                                                                                                  */
/*  DE 1.0 Codebook (PDF)                                                                                                                                           */
/*  DE 1.0 Frequently Asked Questions (PDF)             https://1drv.ms/u/s!AovFHZtMPA-7gQ6XtydpkgqQY2SS?e=hFR3ra                                                   */
/*                                                                                                                                                                  */
                                                                                                                                                                    */
/*  DE 1.0 Inpatient Claims SAS Code (ZIP)              https://1drv.ms/u/s!AovFHZtMPA-7gQqtAdkmkX6eJ9wp?e=YQEnw3    inpatient        75 mb                         */
/*  DE 1.0 Beneficiary Summary File SAS Code (ZIP)      https://1drv.ms/u/s!AovFHZtMPA-7gQkQhQeYRoKMljJt?e=wwcaCU    beneficiary     139 mb                         */
/*  DE 1.0 Outpatient Claims SAS Code (ZIP)             https://1drv.ms/u/s!AovFHZtMPA-7gQsUKt8KzRTBRnMR?e=klVHC1    outpatient      624 mb                         */
/*  DE 1.0 Prescription Drug Event SAS Code (ZIP)       https://1drv.ms/u/s!AovFHZtMPA-7gQwj2Y_5siTOQZcH?e=NFgIbS    drug           1200 mb                         */
/*  DE 1.0 Carrier Claims File SAS Code (ZIP)           https://1drv.ms/u/s!AovFHZtMPA-7gQ2BAd0ofRgCpQLw?e=rI42Ou    carrier        4260 mb                         */
/*                                                                                                                                                                  */
/*  If the location changes go to https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample01 and hover over          */
/*  one of the claim files, right click, copy link and replace the link below                                                                                       */
/*                                                                                                                                                                  */
/*  https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_Beneficiary_Summary_File_Sample_1.zip       */
/*   _                                                                                                                                                              */
/*  (_)___ ___ _   _  ___  ___                                                                                                                                      */
/*  | / __/ __| | | |/ _ \/ __|                                                                                                                                     */
/*  | \__ \__ \ |_| |  __/\__ \                                                                                                                                     */
/*  |_|___/___/\__,_|\___||___/                                                                                                                                     */
/*   _                   _   _            _                                                                                                                         */
/*  (_)_ __  _ __   __ _| |_(_) ___ _ __ | |_                                                                                                                       */
/*  | | `_ \| `_ \ / _` | __| |/ _ \ `_ \| __|                                                                                                                      */
/*  | | | | | |_) | (_| | |_| |  __/ | | | |_                                                                                                                       */
/*  |_|_| |_| .__/ \__,_|\__|_|\___|_| |_|\__|                                                                                                                      */
/*          |_|                                                                                                                                                     */
/*                                                                                                                                                                  */
/* 1. Inpatient - all HCPCS_CDs are missing                                                                                                                         */
/*                                                                                                                                                                  */
/* The following variables are missing or unevaluated for all occurances                                                                                            */
/*                                                                                                                                                                  */
/*   #    Variable Name     Label                                                                                                                                   */
/* ---    ---------------   ----------------------------------------                                                                                                */
/*                                                                                                                                                                  */
/*   1    HCPCS_CD_1        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   2    HCPCS_CD_10       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   3    HCPCS_CD_11       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   4    HCPCS_CD_12       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   5    HCPCS_CD_13       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   6    HCPCS_CD_14       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   7    HCPCS_CD_15       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   8    HCPCS_CD_16       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*   9    HCPCS_CD_17       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  10    HCPCS_CD_18       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  11    HCPCS_CD_19       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  12    HCPCS_CD_2        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  13    HCPCS_CD_20       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  14    HCPCS_CD_21       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  15    HCPCS_CD_22       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  16    HCPCS_CD_23       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  17    HCPCS_CD_24       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  18    HCPCS_CD_25       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  19    HCPCS_CD_26       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  20    HCPCS_CD_27       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  21    HCPCS_CD_28       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  22    HCPCS_CD_29       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  23    HCPCS_CD_3        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  24    HCPCS_CD_30       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  25    HCPCS_CD_31       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  26    HCPCS_CD_32       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  27    HCPCS_CD_33       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  28    HCPCS_CD_34       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  29    HCPCS_CD_35       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  30    HCPCS_CD_36       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  31    HCPCS_CD_37       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  32    HCPCS_CD_38       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  33    HCPCS_CD_39       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  34    HCPCS_CD_4        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  35    HCPCS_CD_40       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  36    HCPCS_CD_41       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  37    HCPCS_CD_42       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  38    HCPCS_CD_43       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  39    HCPCS_CD_44       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  40    HCPCS_CD_45       DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  41    HCPCS_CD_5        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  42    HCPCS_CD_6        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  43    HCPCS_CD_7        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  44    HCPCS_CD_8        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*  45    HCPCS_CD_9        DESYNPUF: Revenue Center HCFA Common Pro                                                                                                */
/*                                                                                                                                                                  */
/*                                                                                                                                                                  */
/* 2. Missing Claim thru dates (Tis is probably ok)                                                                                                                 */
/*                                                                                                                                                                  */
/*  DESYNPUF: Claim Thru Data                                                                                                                                       */
/*                                                                                                                                                                  */
/*  YEAR_CLM_                                                                                                                                                       */
/*  THRU_DT      Frequency     Percent                                                                                                                              */
/*  ----------------------------------                                                                                                                              */
/*  2008           547465       41.08                                                                                                                               */
/*  2009           504375       37.84                                                                                                                               */
/*  2010           279693       20.99                                                                                                                               */
/*     .             1289        0.10                                                                                                                               */
/*                                                                                                                                                                  */
/*      _                                         _                                                                                                                 */
/*   __| |_ __ _   _  __ _    _____   _____ _ __ | |_ ___                                                                                                           */
/*  / _` | `__| | | |/ _` |  / _ \ \ / / _ \ `_ \| __/ __|                                                                                                          */
/* | (_| | |  | |_| | (_| | |  __/\ V /  __/ | | | |_\__ \                                                                                                          */
/*  \__,_|_|   \__,_|\__, |  \___| \_/ \___|_| |_|\__|___/                                                                                                          */
/*                   |___/                                                                                                                                          */
/*                                                                                                                                                                  */
/*   PDE_ID is not a primary key                                                                                                                                    */
/*                                                                                                                                                                  */
/*   DE1_0_2008_to_2010_Prescription_Drug_Events_Sample                                                                                                             */
/*                                                                                                                                                                  */
/*   Variable     Observations     Unique Values       Label                                                                                                        */
/*   --------     ------------     -------------       -----                                                                                                        */
/*                                                                                                                                                                  */
/*   PDE_ID       111,090,000      111,085,969        DESYNPUF: CCW Part D Event Number                                                                             */
/*                                                                                                                                                                  */
/********************************************************************************************************************************************************************/

/*                                    __ _
 _ __  _ __ ___   ___ ___  ___ ___   / _| | _____      __
| `_ \| `__/ _ \ / __/ _ \/ __/ __| | |_| |/ _ \ \ /\ / /
| |_) | | | (_) | (_|  __/\__ \__ \ |  _| | (_) \ V  V /
| .__/|_|  \___/ \___\___||___/___/ |_| |_|\___/ \_/\_/
|_|
*/

*x 'tree "d:/rad" /F /A | clip';

Beneficiary file example  )others are similar)

  1. Download each of the 20 tiny Benificiary Zip Files
  2. Unzip each of the 20 files into csv files
  3. Convert each of the csv to a SAS dataset
  4. Combine all 20 SAS datasets into one sas dataset

/*
 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/
/*                             _
 ___  __ _ ___    ___ ___   __| | ___
/ __|/ _` / __|  / __/ _ \ / _` |/ _ \
\__ \ (_| \__ \ | (_| (_) | (_| |  __/
|___/\__,_|___/  \___\___/ \__,_|\___|

*/

/*************************************************************************************************************************
/*  DE 1.0 Codebook (PDF)                                                                                                                                           */
/*  DE 1.0 Frequently Asked Questions (PDF)                                                                                                                         */
/*  DE 1.0 Beneficiary Summary File SAS Code (ZIP)                                                                                                                  */
/*  DE 1.0 Carrier Claims File SAS Code (ZIP)                                                                                                                       */
/*  DE 1.0 Inpatient Claims SAS Code (ZIP)                                                                                                                          */
/*  DE 1.0 Outpatient Claims SAS Code (ZIP)                                                                                                                         */
/*  DE 1.0 Prescription Drug Event SAS Code (ZIP)                                                                                                                   */

%macro rad_010sasPdf(fyl);

    %utlfkil(d:/rad/zip/&fyl);

    filename out "d:/rad/zip/&fyl";
    proc http
      method = 'GET'
      url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/&fyl"
      out    =  out;
    run;quit;

%mend  rad_010sasPdf;

%rad_010sasPdf(Bene_SAS.zip);
%rad_010sasPdf(Carrier_SAS.zip);
%rad_010sasPdf(Outpatient_SAS.zip);
%rad_010sasPdf(PDE_SAS.zip);

* INPATIENT HAS A DIFFERENT LOCATION;

%utlfkil(d:/rad/zip/de-10-inpatient-claims-sas-code.zip);
filename out "d:/rad/zip/de-10-inpatient-claims-sas-code.zip";
proc http
  method = 'GET'
  url    = "https://www.cms.gov/files/zip/de-10-inpatient-claims-sas-code.zip"
  out    =  out;
run;quit;

* CODEBOOK;

%utlfkil(d:/rad/pdf/de-10-codebook.pdf-0.pdf);
filename out "d:/rad/pdf/de-10-codebook.pdf-0.pdf";
proc http
  method = 'GET'
  url    = "https://www.cms.gov/files/document/de-10-codebook.pdf-0"
  out    =  out;
run;quit;

* DATA USE AGREEMENT;

%utlfkil(d:/rad/pdf/SynPUF_DUG.pdf);
filename out "d:/rad/pdf/SynPUF_DUG.pdf";
proc http
  method = 'GET'
  url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/SynPUF_DUG.pdf"
  out    =  out;
run;quit;

/*                        __            _         _       _
| |__   ___ _ __   ___   / _| __ _  ___| |_    __| | __ _| |_ __ _
| `_ \ / _ \ `_ \ / _ \ | |_ / _` |/ __| __|  / _` |/ _` | __/ _` |
| |_) |  __/ | | |  __/ |  _| (_| | (__| |_  | (_| | (_| | || (_| |
|_.__/ \___|_| |_|\___| |_|  \__,_|\___|\__|  \__,_|\__,_|\__\__,_|

*/

* I DECIDED NOT TO LOOP BECAUSE I THINK SUBMITTING A FEW AT A TIME AND CHECKING THE LOG IS USEFUL;

%macro rad_010bne(idx);

   %utlfkil(d:/rad/zip/DE1_0_2008_Beneficiary_Summary_File_Sample_&idx..zip);
   %utlfkil(d:/rad/zip/DE1_0_2009_Beneficiary_Summary_File_Sample_&idx..zip);
   %utlfkil(d:/rad/zip/DE1_0_2010_Beneficiary_Summary_File_Sample_&idx..zip);

   filename out "d:/rad/zip/DE1_0_2008_Beneficiary_Summary_File_Sample_&idx..zip";
   proc http
     method = 'GET'
     url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_Beneficiary_Summary_File_Sample_&idx..zip"
     out    =  out;
   run;quit;

   filename out "d:/rad/zip/DE1_0_2009_Beneficiary_Summary_File_Sample_&idx..zip";
   proc http
     method = 'GET'
     url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2009_Beneficiary_Summary_File_Sample_&idx..zip"
     out    =  out;
   run;quit;

   /* first 1 of 20 could not be downloaded programatically. Ypu need to do it manually */
   %if &idx ^= 1 %then %do;
     filename out "d:/rad/zip/DE1_0_2010_Beneficiary_Summary_File_Sample_&idx..zip";
     proc http
        method = 'GET'
        url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2010_Beneficiary_Summary_File_Sample_&idx..zip"
        out    =  out;
     run;quit;
     filename out clear;
   %end;

%mend rad_010bne;


%rad_010bne(1);
%rad_010bne(2);
%rad_010bne(3);
%rad_010bne(4);
%rad_010bne(5);
%rad_010bne(6);
%rad_010bne(7);
%rad_010bne(8);
%rad_010bne(9);
%rad_010bne(10);
%rad_010bne(11);
%rad_010bne(12);
%rad_010bne(13);
%rad_010bne(14);
%rad_010bne(15);
%rad_010bne(16);
%rad_010bne(17);
%rad_010bne(18);
%rad_010bne(19);
%rad_010bne(20);

/*                                 _
 _ __ ___   __ _ _ __  _   _  __ _| |  _ __  _ __ ___   ___ ___  ___ ___
| `_ ` _ \ / _` | `_ \| | | |/ _` | | | `_ \| `__/ _ \ / __/ _ \/ __/ __|
| | | | | | (_| | | | | |_| | (_| | | | |_) | | | (_) | (_|  __/\__ \__ \
|_| |_| |_|\__,_|_| |_|\__,_|\__,_|_| | .__/|_|  \___/ \___\___||___/___/
                                      |_|
*/

/********************************************************************************************************************************************************************/
/*  ISSUE: I WAS ABLE TO DOWNLOAD ALL 140+ ZIP FILES EXCEPT THIS ONE 2010 BENEFICIARY SUMMARY FILE                                                                  */
/*                                                                                                                                                                  */
/*  Go to https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/DESample01                                                 */
/*  Click on DE1.0 Sample 1 2010 Beneficiary Summary File (ZIP)                                                                                                     */
/*  Copy the downloaded file to d:/rad/zip/DE1_0_2010_Beneficiary_Summary_File_Sample_1..zip                                                                        */
/*                                                                                                                                                                  */
/********************************************************************************************************************************************************************/

/*               _
 _   _ _ __  ___(_)_ __
| | | | `_ \|_  / | `_ \
| |_| | | | |/ /| | |_) |
 \__,_|_| |_/___|_| .__/
                  |_|
*/

%macro rad_010unz(idx);

   %utlfkil(d:\rad\csv\DE1_0_2008_Beneficiary_Summary_File_Sample_&idx..csv);

   %let zip=d:/rad/zip/DE1_0_2008_Beneficiary_Summary_File_Sample_&idx..zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath d:\rad\csv\;);
   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

   %let zip=d:/rad/zip/DE1_0_2009_Beneficiary_Summary_File_Sample_&idx..zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath d:\rad\csv\;);
   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;


   %let zip=d:/rad/zip/DE1_0_2010_Beneficiary_Summary_File_Sample_&idx..zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath d:\rad\csv\;);
   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

%mend rad_010unz;

%rad_010unz(1);
%rad_010unz(2);
%rad_010unz(3);
%rad_010unz(4);
%rad_010unz(5);
%rad_010unz(6);
%rad_010unz(7);
%rad_010unz(8);
%rad_010unz(9);
%rad_010unz(10);
%rad_010unz(11);
%rad_010unz(12);
%rad_010unz(13);
%rad_010unz(14);
%rad_010unz(15);
%rad_010unz(16);
%rad_010unz(17);
%rad_010unz(18);
%rad_010unz(19);
%rad_010unz(20);

/*                   _     _
  ___ ___  _ __ ___ | |__ (_)_ __   ___    ___ _____   _____
 / __/ _ \| `_ ` _ \| `_ \| | `_ \ / _ \  / __/ __\ \ / / __|
| (_| (_) | | | | | | |_) | | | | |  __/ | (__\__ \\ V /\__ \   DE1_0_2008_2010_Beneficiary_Summary_File_Sample
 \___\___/|_| |_| |_|_.__/|_|_| |_|\___|  \___|___/ \_/ |___/

*/

* PUT CSVS TOGETHER - COMBINE ALL THE CSVS INTO ONE CSV;

%array(_bs,values=1-20);

%put &=_bs1;
%put &=_bs20;

%utlfkil(d:/rad/csv/DE1_0_2008_2010_Beneficiary_Summary_File_Sample.csv);

data _null_;

  retain dne 0;
  file "d:/rad/csv//DE1_0_2008_2010_Beneficiary_Summary_File_Sample.csv";

  %do_over(_bs,phrase=%str(
     dne=0;
     do until (dne);
        infile  "d:/rad/csv/DE1_0_2008_Beneficiary_Summary_File_Sample_?.csv" lrecl=600 firstobs=2 end=dne;
        input;
        _infile_ = catx(',','2008',put(input("?",2.),z2.),_infile_);
        put _infile_;
     end;
     dne=0;
  ));

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:/rad/csv/DE1_0_2009_Beneficiary_Summary_File_Sample_?.csv" lrecl=600 firstobs=2 end=dne;
        input;
        _infile_ = catx(',','2009',put(input("?",2.),z2.),_infile_);
        put _infile_;
     end;
     dne=0;
   ));

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:/rad/csv/DE1_0_2010_Beneficiary_Summary_File_Sample_?.csv" lrecl=600 firstobs=2 end=dne;
        input;
        _infile_ = catx(',','2010',put(input("?",2.),z2.),_infile_);
        put _infile_;
     end;
     dne=0;
  ));
  stop;
run;quit;

/*               _                       _        _     _
 ___  __ _ ___  | |__   ___ _ __   ___  | |_ __ _| |__ | | ___
/ __|/ _` / __| | `_ \ / _ \ `_ \ / _ \ | __/ _` | `_ \| |/ _ \
\__ \ (_| \__ \ | |_) |  __/ | | |  __/ | || (_| | |_) | |  __/  frqh PPPYMT_CAR
|___/\__,_|___/ |_.__/ \___|_| |_|\___|  \__\__,_|_.__/|_|\___|

*/
options ps=200;

libname rad "d:/rad";

data rad.rad_010Bne (label="from d:/rad/csv/DE1_0_2008_Beneficiary_Summary_File_Sample.csv");

   infile "d:/rad/csv/DE1_0_2008_2010_Beneficiary_Summary_File_Sample.csv" dsd dlm=',' lrecl=500 stopover;

   attrib
          YEAR            length=$4  informat=$4.      label='DESYNPUF: Year of Claim'
          SAMPLE_NO       length=$2  informat=$2.      label='DESYNPUF: Sample Number'
          DESYNPUF_ID     length=$16 format=$16.       label='DESYNPUF: Beneficiary Code'
          BENE_BIRTH_DT   length=4 format=YYMMDDN8.    informat=yymmdd8.  label='DESYNPUF: Date of birth'
          BENE_DEATH_DT   length=4 format=YYMMDDN8.    informat=yymmdd8.  label='DESYNPUF: Date of death'
          BENE_SEX_IDENT_CD  length=$1 format=$1.      label='DESYNPUF: Sex'
          BENE_RACE_CD    length=$1 format=$1.         label='DESYNPUF: Beneficiary Race Code'
          BENE_ESRD_IND   length=$1 format=$1.         label='DESYNPUF: End stage renal disease Indicator'
          SP_STATE_CODE   length=$2 format=$2.         label='DESYNPUF: State Code'
          BENE_COUNTY_CD  length=$3 format=$3.         label='DESYNPUF: County Code'
          BENE_HI_CVRAGE_TOT_MONS  length=3 format=2.  label='DESYNPUF: Total number of months of part A coverage for the beneficiary.'
          BENE_SMI_CVRAGE_TOT_MONS length=3 format=2.  label='DESYNPUF: Total number of months of part B coverage for the beneficiary.'
          BENE_HMO_CVRAGE_TOT_MONS length=3 format=2.  label='DESYNPUF: Total number of months of HMO coverage for the beneficiary.'
          PLAN_CVRG_MOS_NUM  length=$2 format=$2.      label='DESYNPUF: Total number of months of part D plan coverage for the beneficiary.'
          SP_ALZHDMTA     length=3 format=1.           label='DESYNPUF: Chronic Condition: Alzheimer or related disorders or senile'
          SP_CHF          length=3 format=1.           label='DESYNPUF: Chronic Condition: Heart Failure'
          SP_CHRNKIDN     length=3 format=1.           label='DESYNPUF: Chronic Condition: Chronic Kidney Disease'
          SP_CNCR         length=3 format=1.           label='DESYNPUF: Chronic Condition: Cancer'
          SP_COPD         length=3 format=1.           label='DESYNPUF: Chronic Condition: Chronic Obstructive Pulmonary Disease'
          SP_DEPRESSN     length=3 format=1.           label='DESYNPUF: Chronic Condition: Depression'
          SP_DIABETES     length=3 format=1.           label='DESYNPUF: Chronic Condition: Diabetes'
          SP_ISCHMCHT     length=3 format=1.           label='DESYNPUF: Chronic Condition: Ischemic Heart Disease'
          SP_OSTEOPRS     length=3 format=1.           label='DESYNPUF: Chronic Condition: Osteoporosis'
          SP_RA_OA        length=3 format=1.           label='DESYNPUF: Chronic Condition: RA/OA'
          SP_STRKETIA     length=3 format=1.           label='DESYNPUF: Chronic Condition: Stroke/transient Ischemic Attack'
          MEDREIMB_IP     length=8 format=10.2         label='DESYNPUF: Inpatient annual Medicare reimbursement amount'
          BENRES_IP       length=8 format=10.2         label='DESYNPUF: Inpatient annual beneficiary responsibility amount'
          PPPYMT_IP       length=8 format=10.2         label='DESYNPUF: Inpatient annual primary payer reimbursement amount'
          MEDREIMB_OP     length=8 format=10.2         label='DESYNPUF: Outpatient Institutional annual Medicare reimbursement amount'
          BENRES_OP       length=8 format=10.2         label='DESYNPUF: Outpatient Institutional annual beneficiary responsibility amount'
          PPPYMT_OP       length=8 format=10.2         label='DESYNPUF: Outpatient Institutional annual primary payer reimbursement amount'
          MEDREIMB_CAR    length=8 format=10.2         label='DESYNPUF: Carrier annual Medicare reimbursement amount'
          BENRES_CAR      length=8 format=10.2         label='DESYNPUF: Carrier annual beneficiary responsibility amount'
          PPPYMT_CAR      length=8 format=10.2         label='DESYNPUF: Carrier annual primary payer reimbursement amount'
       ;

   input
         YEAR
         SAMPLE_NO
         DESYNPUF_ID
         BENE_BIRTH_DT
         BENE_DEATH_DT
         BENE_SEX_IDENT_CD
         BENE_RACE_CD
         BENE_ESRD_IND
         SP_STATE_CODE
         BENE_COUNTY_CD
         BENE_HI_CVRAGE_TOT_MONS
         BENE_SMI_CVRAGE_TOT_MONS
         BENE_HMO_CVRAGE_TOT_MONS
         PLAN_CVRG_MOS_NUM
         SP_ALZHDMTA
         SP_CHF
         SP_CHRNKIDN
         SP_CNCR
         SP_COPD
         SP_DEPRESSN
         SP_DIABETES
         SP_ISCHMCHT
         SP_OSTEOPRS
         SP_RA_OA
         SP_STRKETIA
         MEDREIMB_IP
         BENRES_IP
         PPPYMT_IP
         MEDREIMB_OP
         BENRES_OP
         PPPYMT_OP
         MEDREIMB_CAR
         BENRES_CAR
         PPPYMT_CAR;

run;

* EDIT CHECK;

%*inc "c:/macros_rjd/oto_voodoo.sas";

%*utlvdoc
    (
    libname        = rad         /* libname of input dataset */
    ,data          = rad_010bne  /* name of input dataset */
    ,key           = year DESYNPUF_ID            /* 0 or variable */
    ,ExtrmVal      = 10           /* display top and bottom 30 frequencies */
    ,UniPlot       = 0            /* 0 or univariate plots    */
    ,UniVar        = 0            /* 0 or univariate analysis */
    ,chart         = 0            /* 0 or proc chart horizontal histograme */
    ,misspat       = 0            /* 0 or 1 missing patterns */
    ,taball        = 0            /* 0 crosstabs of all pairwise combinations of vriables */
    ,tabone        = 0            /* 0 or all pairwise cross tabs with limits */
    ,mispop        = 0            /* 0 0 negative positive or missing on each variable */
    ,mispoptbl     = 0            /* 0 missing populated table */
    ,dupcol        = 0            /* 0 do two columns have the same values in all rows */
    ,unqtwo        = 0            /* 0 only use to find primary key unique leveels of compund keys */
    ,vdocor        = 0            /* 0 or all pairwise parametric and non parametric collolations */
    ,oneone        = 0            /* 0 or 1:1  1:many many:many */
    ,cramer        = 0            /* 0 or cramer V variable crossed with all others */
    ,optlength     = 0            /* 0 optimum length for character and numeric variables */
    ,maxmin        = 0            /* 0 or max min for every varuiable */
    ,unichr        = 0            /* 0 univariate analysis of character variiables */
    ,outlier       = 0            /* 0 robust regression determination of outliers */
    ,rsquare       = 0            /* 0 robust regression determination of outliers */
    ,printto       = d:\rad\vdo\&data..txt  /* save the voluminous output */
    ,Cleanup       = 0
    );


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Agrees with Documentation for 2008 (2009-2010 not in doc                                                              */
/*                                                                                                                        */
/*  Dataset=rad.rad_010Bne frequencies and distinct count for year sample_no 11SEP2022:08:02:45                           */
/*                                                                                                                        */
/*                 UNIQUE_                                                                                                */
/*                 SAMPLE_                                                                                                */
/*  Obs    YEAR       NO      OBSEVATIONS                                                                                 */
/*                                                                                                                        */
/*   1     2008       20        2326856                                                                                   */
/*   2     2009       20        2291320                                                                                   */
/*   3     2010       20        2255098                                                                                   */
/*                                                                                                                        */
/*  Frequency of year*sample_no datasets rad.rad_010Bne 11SEP2022:08:16:57                                                */
/*                                                                                                                        */
/*             Number of Variable Levels                                                                                  */
/*                                                                                                                        */
/*  Variable     Label                        Levels                                                                      */
/*  ------------------------------------------------                                                                      */
/*  YEAR         DESYNPUF: Year of Claim           3                                                                      */
/*  SAMPLE_NO    DESYNPUF: Sample Number          20                                                                      */
/*                                                                                                                        */
/*                                                Cumulative    Cumulative                                                */
/*  YEAR    SAMPLE_NO    Frequency     Percent     Frequency      Percent                                                 */
/*  ----------------------------------------------------------------------                                                */
/*  2008    01             116352        1.69        116352         1.69                                                  */
/*  2008    02             116395        1.69        232747         3.39                                                  */
/*  2008    03             116390        1.69        349137         5.08                                                  */
/*  2008    04             116279        1.69        465416         6.77                                                  */
/*  2008    05             116364        1.69        581780         8.46                                                  */
/*  2008    06             116234        1.69        698014        10.16                                                  */
/*  2008    07             116352        1.69        814366        11.85                                                  */
/*  2008    08             116330        1.69        930696        13.54                                                  */
/*  2008    09             116287        1.69       1046983        15.23                                                  */
/*  2008    10             116353        1.69       1163336        16.93                                                  */
/*  2008    11             116339        1.69       1279675        18.62                                                  */
/*  2008    12             116387        1.69       1396062        20.31                                                  */
/*  2008    13             116363        1.69       1512425        22.00                                                  */
/*  2008    14             116374        1.69       1628799        23.70                                                  */
/*  2008    15             116391        1.69       1745190        25.39                                                  */
/*  2008    16             116377        1.69       1861567        27.08                                                  */
/*  2008    17             116285        1.69       1977852        28.78                                                  */
/*  2008    18             116405        1.69       2094257        30.47                                                  */
/*  2008    19             116224        1.69       2210481        32.16                                                  */
/*  2008    20             116375        1.69       2326856        33.85                                                  */
/*                                                                                                                        */
/*  2009    01             114538        1.67       2441394        35.52                                                  */
/*  2009    02             114618        1.67       2556012        37.19                                                  */
/*  2009    03             114644        1.67       2670656        38.86                                                  */
/*  2009    04             114528        1.67       2785184        40.52                                                  */
/*  2009    05             114539        1.67       2899723        42.19                                                  */
/*  2009    06             114532        1.67       3014255        43.85                                                  */
/*  2009    07             114569        1.67       3128824        45.52                                                  */
/*  2009    08             114589        1.67       3243413        47.19                                                  */
/*  2009    09             114495        1.67       3357908        48.85                                                  */
/*  2009    10             114588        1.67       3472496        50.52                                                  */
/*  2009    11             114459        1.67       3586955        52.19                                                  */
/*  2009    12             114646        1.67       3701601        53.85                                                  */
/*  2009    13             114511        1.67       3816112        55.52                                                  */
/*  2009    14             114637        1.67       3930749        57.19                                                  */
/*  2009    15             114612        1.67       4045361        58.86                                                  */
/*  2009    16             114626        1.67       4159987        60.52                                                  */
/*  2009    17             114422        1.66       4274409        62.19                                                  */
/*  2009    18             114638        1.67       4389047        63.86                                                  */
/*  2009    19             114488        1.67       4503535        65.52                                                  */
/*  2009    20             114641        1.67       4618176        67.19                                                  */
/*                                                                                                                        */
/*  2010    01             112754        1.64       4730930        68.83                                                  */
/*  2010    02             112845        1.64       4843775        70.47                                                  */
/*  2010    03             112812        1.64       4956587        72.11                                                  */
/*  2010    04             112699        1.64       5069286        73.75                                                  */
/*  2010    05             112687        1.64       5181973        75.39                                                  */
/*  2010    06             112713        1.64       5294686        77.03                                                  */
/*  2010    07             112747        1.64       5407433        78.67                                                  */
/*  2010    08             112777        1.64       5520210        80.31                                                  */
/*  2010    09             112685        1.64       5632895        81.95                                                  */
/*  2010    10             112769        1.64       5745664        83.59                                                  */
/*  2010    11             112586        1.64       5858250        85.23                                                  */
/*  2010    12             112886        1.64       5971136        86.87                                                  */
/*  2010    13             112665        1.64       6083801        88.51                                                  */
/*  2010    14             112786        1.64       6196587        90.15                                                  */
/*  2010    15             112809        1.64       6309396        91.80                                                  */
/*  2010    16             112901        1.64       6422297        93.44                                                  */
/*  2010    17             112615        1.64       6534912        95.08                                                  */
/*  2010    18             112876        1.64       6647788        96.72                                                  */
/*  2010    19             112675        1.64       6760463        98.36                                                  */
/*  2010    20             112811        1.64       6873274       100.00                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Middle Observation(1163428 ) of Last dataset = RAD.RAD_010BNE - Total Obs 2326856                                     */
/*                                                                                                                        */
/*   -- CHARACTER --                                                                                                      */
/*  YEAR                       C4   2009      DESYNPUF: Year                                                              */
/*  SAMPLE_N)                  C2   10        DESYNPUF: SAMPLE_NO                                                         */
/*  DESYNPUF_ID                C16  0036C...  DESYNPUF: Beneficiary Code                                                  */
/*  BENE_SEX_IDENT_CD          C1   2         DESYNPUF: Sex                                                               */
/*  BENE_RACE_CD               C1   1         DESYNPUF: Beneficiary Race Code                                             */
/*  BENE_ESRD_IND              C1   0         DESYNPUF: End stage renal disease Indicator                                 */
/*  SP_STATE_CODE              C2   11        DESYNPUF: State Code                                                        */
/*  BENE_COUNTY_CD             C3   860       DESYNPUF: County Code                                                       */
/*  PLAN_CVRG_MOS_NUM          C2   12        DESYNPUF: Total number of months of part D plan coverage for the beneficiary*/ .
/*                                                                                                                        */
/*   -- NUMERIC --                                                                                                        */
/*  BENE_BIRTH_DT              N4   -8919     DESYNPUF: Date of birth                                                     */
/*  BENE_DEATH_DT              N4   .         DESYNPUF: Date of death                                                     */
/*  BENE_HI_CVRAGE_TOT_MONS    N3   12        DESYNPUF: Total number of months of part A coverage for the beneficiary.    */
/*  BENE_SMI_CVRAGE_TOT_MONS   N3   12        DESYNPUF: Total number of months of part B coverage for the beneficiary.    */
/*  BENE_HMO_CVRAGE_TOT_MONS   N3   12        DESYNPUF: Total number of months of HMO coverage for the beneficiary.       */
/*  SP_ALZHDMTA                N3   2         DESYNPUF: Chronic Condition: Alzheimer or related disorders or senile       */
/*  SP_CHF                     N3   2         DESYNPUF: Chronic Condition: Heart Failure                                  */
/*  SP_CHRNKIDN                N3   2         DESYNPUF: Chronic Condition: Chronic Kidney Disease                         */
/*  SP_CNCR                    N3   2         DESYNPUF: Chronic Condition: Cancer                                         */
/*  SP_COPD                    N3   2         DESYNPUF: Chronic Condition: Chronic Obstructive Pulmonary Disease          */
/*  SP_DEPRESSN                N3   2         DESYNPUF: Chronic Condition: Depression                                     */
/*  SP_DIABETES                N3   2         DESYNPUF: Chronic Condition: Diabetes                                       */
/*  SP_ISCHMCHT                N3   2         DESYNPUF: Chronic Condition: Ischemic Heart Disease                         */
/*  SP_OSTEOPRS                N3   2         DESYNPUF: Chronic Condition: Osteoporosis                                   */
/*  SP_RA_OA                   N3   2         DESYNPUF: Chronic Condition: RA/OA                                          */
/*  SP_STRKETIA                N3   2         DESYNPUF: Chronic Condition: Stroke/transient Ischemic Attack               */
/*  MEDREIMB_IP                N8   0         DESYNPUF: Inpatient annual Medicare reimbursement amount                    */
/*  BENRES_IP                  N8   0         DESYNPUF: Inpatient annual beneficiary responsibility amount                */
/*  PPPYMT_IP                  N8   0         DESYNPUF: Inpatient annual primary payer reimbursement amount               */
/*  MEDREIMB_OP                N8   40        DESYNPUF: Outpatient Institutional annual Medicare reimbursement amount     */
/*  BENRES_OP                  N8   20        DESYNPUF: Outpatient Institutional annual beneficiary responsibility amount */
/*  PPPYMT_OP                  N8   0         DESYNPUF: Outpatient Institutional annual primary payer reimbursement amount*/
/*  MEDREIMB_CAR               N8   200       DESYNPUF: Carrier annual Medicare reimbursement amount                      */
/*  BENRES_CAR                 N8   70        DESYNPUF: Carrier annual beneficiary responsibility amount                  */
/*  PPPYMT_CAR                 N8   0         DESYNPUF: Carrier annual primary payer reimbursement amount                 */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*                   _   _            _          _       _
(_)_ __  _ __   __ _| |_(_) ___ _ __ | |_    ___| | __ _(_)_ __ ___  ___
| | `_ \| `_ \ / _` | __| |/ _ \ `_ \| __|  / __| |/ _` | | `_ ` _ \/ __|
| | | | | |_) | (_| | |_| |  __/ | | | |_  | (__| | (_| | | | | | | \__ \
|_|_| |_| .__/ \__,_|\__|_|\___|_| |_|\__|  \___|_|\__,_|_|_| |_| |_|___/
        |_|
*/

* I DECIDED NOT TO LOOP BECAUSE I THINK SUBMITTING A FEW AT A TIME AND CHECKING THE LOG IS USEFUL;

%macro rad_010inp(idx);

 %utlfkil(d:/rad/zip/DE1_0_2008_to_2010_Inpatient_Claims_Sample_&idx..zip);
 filename out "d:/rad/zip/DE1_0_2008_to_2010_Inpatient_Claims_Sample_&idx..zip";
 proc http
   method = 'GET'
   url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_to_2010_Inpatient_Claims_Sample_&idx..zip"
   out    =  out;
 run;quit;
 filename out clear;

%mend rad_010inp;


%rad_010inp(1);
%rad_010inp(2);
%rad_010inp(3);
%rad_010inp(4);
%rad_010inp(5);
%rad_010inp(6);
%rad_010inp(7);
%rad_010inp(8);
%rad_010inp(9);
%rad_010inp(10);
%rad_010inp(11);
%rad_010inp(12);
%rad_010inp(13);
%rad_010inp(14);
%rad_010inp(15);
%rad_010inp(16);
%rad_010inp(17);
%rad_010inp(18);
%rad_010inp(19);
%rad_010inp(20);

/*               _
 _   _ _ __  ___(_)_ __
| | | | `_ \|_  / | `_ \
| |_| | | | |/ /| | |_) |
 \__,_|_| |_/___|_| .__/
                  |_|
*/

%macro rad_010unz(idx);

   %utlfkil(d:/rad/csv/DE1_0_2008_to_2010_Inpatient_Claims_Sample_&idx..csv);
   %let zip=d:/rad/zip/DE1_0_2008_to_2010_Inpatient_Claims_Sample_&idx..zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath d:\rad\csv\;);

   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

%mend rad_010unz;

%rad_010unz(1);
%rad_010unz(2);
%rad_010unz(3);
%rad_010unz(4);
%rad_010unz(5);
%rad_010unz(6);
%rad_010unz(7);
%rad_010unz(8);
%rad_010unz(9);
%rad_010unz(10);
%rad_010unz(11);
%rad_010unz(12);
%rad_010unz(13);
%rad_010unz(14);
%rad_010unz(15);
%rad_010unz(16);
%rad_010unz(17);
%rad_010unz(18);
%rad_010unz(19);
%rad_010unz(20);

/*                   _     _
  ___ ___  _ __ ___ | |__ (_)_ __   ___    ___ _____   _____
 / __/ _ \| `_ ` _ \| `_ \| | `_ \ / _ \  / __/ __\ \ / / __|
| (_| (_) | | | | | | |_) | | | | |  __/ | (__\__ \\ V /\__ \
 \___\___/|_| |_| |_|_.__/|_|_| |_|\___|  \___|___/ \_/ |___/

*/

* PUT CSVS TOGETHER - COMBINE ALL THE CSVS INTO ONE CSV;

%array(_bs,values=1-20);

%put &=_bs1;
%put &=_bs20;

%utlfkil(d:/rad/csv/DE1_0_2008_to_2010_Inpatient_Claims_Sample.csv);

data _null_;
  length lyn $700;
  retain dne 0;
  file "d:/rad/csv/DE1_0_2008_to_2010_Inpatient_Claims_Sample.csv";

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:/rad/csv/DE1_0_2008_to_2010_Inpatient_Claims_Sample_?.csv" lrecl=700 firstobs=2 end=dne length=len;
        input lyn $varying700. len;
        lyn = catx(',',put(input("?",2.),z2.),lyn);
        put lyn;
     end;
     dne=0;
  ));
  putlog _infile_;
  putlog lyn;
  stop;
run;quit;

/*               _                   _   _            _
 ___  __ _ ___  (_)_ __  _ __   __ _| |_(_) ___ _ __ | |_
/ __|/ _` / __| | | `_ \| `_ \ / _` | __| |/ _ \ `_ \| __|   frqh HCPCS_CD_1
\__ \ (_| \__ \ | | | | | |_) | (_| | |_| |  __/ | | | |_
|___/\__,_|___/ |_|_| |_| .__/ \__,_|\__|_|\___|_| |_|\__|
                        |_|
*/

%macro addseqattrib(varname=,nvars=,varlength=,varinformat=,varformat=,labeltext=);

  %******************************************************************************;
  %* This macro program is called by macro program DESYNPUF_IP_READIN. It        ;
  %* generates ATTRIB information for a series of variables. The parameters are  ;
  %*                                                                             ;
  %* The VARNAME= and NVARS= parameters are required.                            ;
  %* VARNAME=  name of series of variables (everything but the numeric suffix)   ;
  %* NVARS=    number of variables in the series                                 ;
  %*                                                                             ;
  %* The remaining parameters are optional.                                      ;
  %* VARLENGTH=  length of each variable in the series. If the series is         ;
  %*             character type, precede the length with a dollar sign ($)       ;
  %* VARINFORMAT= informat to use to read in the series. If the informat ends in ;
  %*              a period, include the period.                                  ;
  %* VARFORMAT=   format to use to display the values of the series. If the      ;
  %*              format ends in a period, include the period.                   ;
  %* LABELTEXT=   label to assing to series. The program adds the variable number;
  %*              to the end of the label. Be careful of quotation marks or other;
  %*              special characters. You may need to hardcode labels that       ;
  %*              special characters.                                            ;
  %******************************************************************************;

  %local a;

  %do a=1 %to &nvars;
     &varname&a %if &varlength ne %then %do;
                  length=&varlength
                %end;
                %if &varinformat ne %then %do;
                  informat=&varinformat
                %end;
                %if &varformat ne %then %do;
                  format=&varformat
                %end;
                %if %nrbquote(&labeltext) ne %then %do;
                  label="&labeltext &a"
                %end;
  %end;

%mend addseqattrib;

libname rad "d:/rad";  /* unqh YEAR_CLM_THRU_DT SAMPLE_NO */

data rad.rad_010Inpatient (label="from d:/rad/csv/DE1_0_2008_to_2010_Inpatient_Claims_Sample.csv");

   infile "d:/rad/csv/DE1_0_2008_to_2010_Inpatient_Claims_Sample.csv" dsd dlm=',' lrecl=1300 stopover;

    attrib
      YEAR_CLM_THRU_DT                 length=$4  informat=$4.      label='DESYNPUF: Claim Thru Data'
      SAMPLE_NO                        length=$2  informat=$2.      label='DESYNPUF: Sample Number'
      DESYNPUF_ID                      length=$16 format=$16.       label='DESYNPUF: Beneficiary Code'
      CLM_ID                           length=$15 format=$15.       label='DESYNPUF: Claim ID'
      SEGMENT                          length=3   format=2.         label='DESYNPUF: Claim Line Segment'
      CLM_FROM_DT                      length=4   informat=yymmdd8. label='DESYNPUF: Claims start date'    format=yymmddn8.
      CLM_THRU_DT                      length=4   informat=yymmdd8. label='DESYNPUF: Claims end date'      format=yymmddn8.
      PRVDR_NUM                        length=$6  format=$6.        label='DESYNPUF: Provider Institution'
      CLM_PMT_AMT                      length=8   format=12.2       label='DESYNPUF: Claim Payment Amount'
      NCH_PRMRY_PYR_CLM_PD_AMT         length=8   format=12.2       label='DESYNPUF: NCH Primary Payer Claim Paid Amount'
      AT_PHYSN_NPI                     length=$10 format=$10.       label='DESYNPUF: Attending Physician - National Provider Identifier Number'
      OP_PHYSN_NPI                     length=$10 format=$10.       label='DESYNPUF: Operating Physician - National Provider Identifier Number'
      OT_PHYSN_NPI                     length=$10 format=$10.       label='DESYNPUF: Other Physician - - National Provider Identifier Number'
      CLM_ADMSN_DT                     length=4   informat=yymmdd8. label='DESYNPUF: Inpatient admission date' format=yymmddn8.
      ADMTNG_ICD9_DGNS_CD              length=$5  format=$5.        label='DESYNPUF: Claim Admitting Diagnosis Code'
      CLM_PASS_THRU_PER_DIEM_AMT       length=8   format=12.2       label='DESYNPUF: Claim Pass Thru Per Diem Amount'
      NCH_BENE_IP_DDCTBL_AMT           length=8   format=12.2       label='DESYNPUF: NCH Beneficiary Inpatient Deductible Amount'
      NCH_BENE_PTA_COINSRNC_LBLTY_AM   length=8   format=12.2       label='DESYNPUF: NCH Beneficiary Part A Coinsurance Liability Amount'
      NCH_BENE_BLOOD_DDCTBL_LBLTY_AM   length=8   format=12.2       label='DESYNPUF: NCH Beneficiary Blood Deductible Liability Amount'
      CLM_UTLZTN_DAY_CNT               length=3   format=3.         label='DESYNPUF: Claim Utilization Day Count'
      NCH_BENE_DSCHRG_DT               length=4   informat=yymmdd8. label='DESYNPUF: Inpatient discharged date' format=yymmddn8.
      CLM_DRG_CD                       length=$3  format=$3.        label='DESYNPUF: Claim Diagnosis Related Group Code'

      %addseqattrib(varname=ICD9_DGNS_CD_,nvars=10,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Diagnosis Code)
      %addseqattrib(varname=ICD9_PRCDR_CD_,nvars=6,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Procedure Code)
      %addseqattrib(varname=HCPCS_CD_,nvars=45,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Revenue Center HCFA Common Procedure Coding System)
      ;

    input
          SAMPLE_NO
          DESYNPUF_ID
          CLM_ID
          SEGMENT
          CLM_FROM_DT
          CLM_THRU_DT
          PRVDR_NUM
          CLM_PMT_AMT
          NCH_PRMRY_PYR_CLM_PD_AMT
          AT_PHYSN_NPI
          OP_PHYSN_NPI
          OT_PHYSN_NPI
          CLM_ADMSN_DT
          ADMTNG_ICD9_DGNS_CD
          CLM_PASS_THRU_PER_DIEM_AMT
          NCH_BENE_IP_DDCTBL_AMT
          NCH_BENE_PTA_COINSRNC_LBLTY_AM
          NCH_BENE_BLOOD_DDCTBL_LBLTY_AM
          CLM_UTLZTN_DAY_CNT
          NCH_BENE_DSCHRG_DT
          CLM_DRG_CD
          ICD9_DGNS_CD_1-ICD9_DGNS_CD_10
          ICD9_PRCDR_CD_1-ICD9_PRCDR_CD_6
          HCPCS_CD_1-HCPCS_CD_45
        ;
        YEAR_CLM_THRU_DT = PUT(YEAR(CLM_THRU_DT),4.);
  run;


%*inc "c:/macros_rjd/oto_voodoo.sas";

*Options ls=171;
%*utlvdoc
    (
    libname        = rad         /* libname of input dataset */
    ,data          = rad_010Inpatient  /* name of input dataset */
    ,key           = year desynpuf_id     /* 0 or variable */
    ,ExtrmVal      = 10           /* display top and bottom 30 frequencies */
    ,UniPlot       = 0            /* 0 or univariate plots    */
    ,UniVar        = 0            /* 0 or univariate analysis */
    ,chart         = 0            /* 0 or proc chart horizontal histograme */
    ,misspat       = 0            /* 0 or 1 missing patterns */
    ,taball        = 0            /* 0 crosstabs of all pairwise combinations of vriables */
    ,tabone        = 0            /* 0 or all pairwise cross tabs with limits */
    ,mispop        = 0            /* 0 0 negative positive or missing on each variable */
    ,mispoptbl     = 0            /* 0 missing populated table */
    ,dupcol        = 0            /* 0 do two columns have the same values in all rows */
    ,unqtwo        = 0            /* 0 only use to find primary key unique leveels of compund keys */
    ,vdocor        = 0            /* 0 or all pairwise parametric and non parametric collolations */
    ,oneone        = 0            /* 0 or 1:1  1:many many:many */
    ,cramer        = 0            /* 0 or cramer V variable crossed with all others */
    ,optlength     = 0            /* 0 optimum length for character and numeric variables */
    ,maxmin        = 0            /* 0 or max min for every varuiable */
    ,unichr        = 0            /* 0 univariate analysis of character variiables */
    ,outlier       = 0            /* 0 robust regression determination of outliers */
    ,rsquare       = 0            /* 0 robust regression determination of outliers */
    ,printto       = d:\rad\vdo\&data..txt  /* save the voluminous output */
    ,Cleanup       = 0
    );


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  PERFECT MATCH                                                                                                         */
/*                                                                                                                        */
/*  INPATIENT                                                                                                             */
/*                          CURRENT                                                                                       */
/*   SUBSAMPLE      DOC     IMPATIENT                                                                                     */
/*                                                                                                                        */
/*        1        66,773   66,773                                                                                        */
/*        2        66,494   66,494                                                                                        */
/*        3        66,672   66,672                                                                                        */
/*        4        66,253   66,253                                                                                        */
/*        5        66,414   66,414                                                                                        */
/*        6        66,977   66,977                                                                                        */
/*        7        66,791   66,791                                                                                        */
/*        8        66,490   66,490                                                                                        */
/*        9        66,763   66,763                                                                                        */
/*       10        66,585   66,585                                                                                        */
/*       11        66,425   66,425                                                                                        */
/*       12        66,717   66,717                                                                                        */
/*       13        66,324   66,324                                                                                        */
/*       14        67,024   67,024                                                                                        */
/*       15        66,846   66,846                                                                                        */
/*       16        66,800   66,800                                                                                        */
/*       17        66,495   66,495                                                                                        */
/*       18        66,428   66,428                                                                                        */
/*       19        67,037   67,037                                                                                        */
/*       20        66,514   66,514                                                                                        */
/*              1,332,822                                                                                                 */
/*  INPATIENT                                                                                                             */
/*                                                                                                                        */
/*  Dataset=rad.rad_010Inpatient frequencies and distinct count for YEAR_CLM_THRU_DT SAMPLE_NO 11SEP2022:09:45:55         */
/*                                                                                                                        */
/*  YEAR_CLM_THRU_DT SAMPLE_NO                                                                                            */
/*                                                                                                                        */
/*                      UNIQUE_                                                                                           */
/*         YEAR_CLM_    SAMPLE_                                                                                           */
/*  Obs     THRU_DT        NO      OBSEVATIONS                                                                            */
/*                                                                                                                        */
/*   1          .          20           1289                                                                              */
/*   2       2008          20         547465                                                                              */
/*   3       2009          20         504375                                                                              */
/*   4       2010          20         279693                                                                              */
/*                                                                                                                        */
/*                                                                                                                        */
/*  NCH_BENE_DSCHRG_DT                                                                                                    */
/*                                                                                                                        */
/*                 UNIQUE_                                                                                                */
/*                 SAMPLE_                   DO NOT KNOW WHAT THIS IS                                                     */
/*  Obs    YEAR       NOS      OBSEVATIONS   DOC                                                                          */
/*                                                                                                                        */
/*   1     2008       20         547869     547800  diff                                                                  */
/*   2     2009       20         504908     504941  diff                                                                  */
/*   3     2010       20         280045     280081  diff                                                                  */
/*                            1,332,822  1,332,822                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _   _            _           _       _
  ___  _   _| |_ _ __   __ _| |_(_) ___ _ __ | |_     ___| | __ _(_)_ __ ___  ___
 / _ \| | | | __| `_ \ / _` | __| |/ _ \ `_ \| __|   / __| |/ _` | | `_ ` _ \/ __|
| (_) | |_| | |_| |_) | (_| | |_| |  __/ | | | |_   | (__| | (_| | | | | | | \__ \
 \___/ \__,_|\__| .__/ \__,_|\__|_|\___|_| |_|\__|   \___|_|\__,_|_|_| |_| |_|___/
                |_|
*/

* I DECIDED NOT TO LOOP BECAUSE I THINK SUBMITTING A FEW AT A TIME AND CHECKING THE LOG IS USEFUL;

%macro rad_010out(idx);

 %utlfkil(d:/rad/zip/DE1_0_2008_to_2010_Outpatient_Claims_Sample_&idx..zip);

 filename out "d:/rad/zip/DE1_0_2008_to_2010_Outpatient_Claims_Sample_&idx..zip";

 proc http
   method = 'GET'
   url    = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/SynPUFs/Downloads/DE1_0_2008_to_2010_Outpatient_Claims_Sample_&idx..zip"
   out    =  out;
 run;quit;

 filename out clear;

%mend rad_010out;


%rad_010out(1);
%rad_010out(2);
%rad_010out(3);
%rad_010out(4);
%rad_010out(5);
%rad_010out(6);
%rad_010out(7);
%rad_010out(8);
%rad_010out(9);
%rad_010out(10);
%rad_010out(11);
%rad_010out(12);
%rad_010out(13);
%rad_010out(14);
%rad_010out(15);
%rad_010out(16);
%rad_010out(17);
%rad_010out(18);
%rad_010out(19);
%rad_010out(20);

/*               _
 _   _ _ __  ___(_)_ __
| | | | `_ \|_  / | `_ \
| |_| | | | |/ /| | |_) |
 \__,_|_| |_/___|_| .__/
                  |_|
*/

%macro rad_010unz(idx);

   %utlfkil(d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample_&idx..csv);
   %let zip=d:/rad/zip/DE1_0_2008_to_2010_Outpatient_Claims_Sample_&idx..zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath d:\rad\csv\;);

   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

%mend rad_010unz;

%rad_010unz(1);
%rad_010unz(2);
%rad_010unz(3);
%rad_010unz(4);
%rad_010unz(5);
%rad_010unz(6);
%rad_010unz(7);
%rad_010unz(8);
%rad_010unz(9);
%rad_010unz(10);
%rad_010unz(11);
%rad_010unz(12);
%rad_010unz(13);
%rad_010unz(14);
%rad_010unz(15);
%rad_010unz(16);
%rad_010unz(17);
%rad_010unz(18);
%rad_010unz(19);
%rad_010unz(20);

/*                   _     _
  ___ ___  _ __ ___ | |__ (_)_ __   ___    ___ _____   _____
 / __/ _ \| `_ ` _ \| `_ \| | `_ \ / _ \  / __/ __\ \ / / __|
| (_| (_) | | | | | | |_) | | | | |  __/ | (__\__ \\ V /\__ \
 \___\___/|_| |_| |_|_.__/|_|_| |_|\___|  \___|___/ \_/ |___/

*/

* PUT CSVS TOGETHER - COMBINE ALL THE CSVS INTO ONE CSV;

%array(_bs,values=1-20);

%put &=_bs1;
%put &=_bs20;

%utlfkil(d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample.csv);

data _null_;

  retain dne 0;
  file "d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample.csv" lrecl=32750 recfm=v;

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample_?.csv" lrecl=32750 recfm=v firstobs=2 end=dne;
        input;
        _infile_ = catx(',',put(input("?",2.),z2.),_infile_);
        put _infile_;
     end;
     dne=0;
  ));

  stop;
run;quit;


/*
data _null_;
  infile  "d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample.csv" lrecl=32750 recfm=v ;
  file  "d:/rad/xls/DE1_0_2008_to_2010_Outpatient_Claims_Sample.csv" lrecl=32750 recfm=v ;
  input;
  cma=countc(_infile_,',');
  put _infile_;
  if _n_ =30 then stop;
run;quit;
*/

/*               _                   _   _            _
 ___  __ _ ___  (_)_ __  _ __   __ _| |_(_) ___ _ __ | |_
/ __|/ _` / __| | | `_ \| `_ \ / _` | __| |/ _ \ `_ \| __|
\__ \ (_| \__ \ | | | | | |_) | (_| | |_| |  __/ | | | |_   frqh HCPCS_CD_1
|___/\__,_|___/ |_|_| |_| .__/ \__,_|\__|_|\___|_| |_|\__|
                        |_|
*/

%macro addseqattrib(varname=,nvars=,varlength=,varinformat=,varformat=,labeltext=);
  %******************************************************************************;
  %* This macro program is called by macro program DESYNPUF_OP_READIN. It        ;
  %* generates ATTRIB information for a series of variables. The parameters are  ;
  %*                                                                             ;
  %* The VARNAME= and NVARS= parameters are required.                            ;
  %* VARNAME=  name of series of variables (everything but the numeric suffix)   ;
  %* NVARS=    number of variables in the series                                 ;
  %*                                                                             ;
  %* The remaining parameters are optional.                                      ;
  %* VARLENGTH=  length of each variable in the series. If the series is         ;
  %*             character type, precede the length with a dollar sign ($)       ;
  %* VARINFORMAT= informat to use to read in the series. If the informat ends in ;
  %*              a period, include the period.                                  ;
  %* VARFORMAT=   format to use to display the values of the series. If the      ;
  %*              format ends in a period, include the period.                   ;
  %* LABELTEXT=   label to assing to series. The program adds the variable number;
  %*              to the end of the label. Be careful of quotation marks or other;
  %*              special characters. You may need to hardcode labels that       ;
  %*              special characters.                                            ;
  %******************************************************************************;

  %local a;

  %do a=1 %to &nvars;
     &varname&a %if &varlength ne %then %do;
                  length=&varlength
                %end;
                %if &varinformat ne %then %do;
                  informat=&varinformat
                %end;
                %if &varformat ne %then %do;
                  format=&varformat
                %end;
                %if %nrbquote(&labeltext) ne %then %do;
                  label="&labeltext &a"
                %end;
  %end;

%mend addseqattrib;


libname rad "d:/rad";   /* unqh YEAR_CLM_THRU_DT SAMPLE_NO */

data rad.rad_010Outpatient (label="from d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample.csv");

   infile "d:/rad/csv/DE1_0_2008_to_2010_Outpatient_Claims_Sample.csv" dsd dlm=',' lrecl=1500 recfm=v stopover;

   attrib
           YEAR_CLM_THRU_DT  length=$4  informat=$4.      label='DESYNPUF: Claim Thru Data'
           SAMPLE_NO     length=$2  informat=$2.      label='DESYNPUF: Sample Number'
           DESYNPUF_ID   length=$2  format=$2.        label='DESYNPUF: Beneficiary Code'
           CLM_ID        length=$15 format=$15.       label='DESYNPUF: Claim ID'
           SEGMENT       length=3   format=2.         label='DESYNPUF: Claim Line Segment'
           CLM_FROM_DT   length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Claims start date'
           CLM_THRU_DT   length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Claims end date'
           PRVDR_NUM     length=$6  format=$6. label='DESYNPUF: Provider Institution'
           CLM_PMT_AMT   length=8   format=12.2 label='DESYNPUF: Claim Payment Amount'
           NCH_PRMRY_PYR_CLM_PD_AMT length=8 format=12.2 label='DESYNPUF: NCH Primary Payer Claim Paid Amount'
           AT_PHYSN_NPI  length=$10 format=$10.          label='DESYNPUF: Attending Physician - National Provider Identifier Number'
           OP_PHYSN_NPI  length=$10 format=$10.          label='DESYNPUF: Operating Physician - National Provider Identifier Number'
           OT_PHYSN_NPI  length=$10 format=$10.          label='DESYNPUF: Other Physician - - National Provider Identifier Number'
           NCH_BENE_BLOOD_DDCTBL_LBLTY_AM length=8 format=12.2  label='DESYNPUF: NCH Beneficiary Blood Deductible Liability Amount'
           %addseqattrib(varname=ICD9_DGNS_CD_,nvars=10,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Diagnosis Code)
           %addseqattrib(varname=ICD9_PRCDR_CD_,nvars=6,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Procedure Code)
           NCH_BENE_PTB_DDCTBL_AMT   length=8 format=12.2  label='DESYNPUF: NCH Beneficiary Part B Deductible Amount'
           NCH_BENE_PTB_COINSRNC_AMT length=8 format=12.2  label='DESYNPUF: NCH Beneficiary Part B Coinsurance Amount'
           ADMTNG_ICD9_DGNS_CD length=$5 format=$5. label='DESYNPUF: Claim Admitting Diagnosis Code'
           %addseqattrib(varname=HCPCS_CD_,nvars=45,varlength=$5,varformat=$5.,labeltext=DESYNPUF:Revenue Center HCFA Common Procedure Coding System)
           ;;

    input
          SAMPLE_NO
          DESYNPUF_ID
          CLM_ID
          SEGMENT
          CLM_FROM_DT
          CLM_THRU_DT
          PRVDR_NUM
          CLM_PMT_AMT
          NCH_PRMRY_PYR_CLM_PD_AMT
          AT_PHYSN_NPI
          OP_PHYSN_NPI
          OT_PHYSN_NPI
          NCH_BENE_BLOOD_DDCTBL_LBLTY_AM
          ICD9_DGNS_CD_1 - ICD9_DGNS_CD_10
          ICD9_PRCDR_CD_1 - ICD9_PRCDR_CD_6
          NCH_BENE_PTB_DDCTBL_AMT
          NCH_BENE_PTB_COINSRNC_AMT
          ADMTNG_ICD9_DGNS_CD
          HCPCS_CD_1 - HCPCS_CD_45
       ;;;

       YEAR_CLM_THRU_DT = PUT(YEAR(CLM_THRU_DT),4.);


  run;

*Options ls=171;
%*utlvdoc
    (
    libname        = rad         /* libname of input dataset */
    ,data          = rad_010Outpatient  /* name of input dataset */
    ,key           = CLM_ID SEGMENT     /* 0 or variable */
    ,ExtrmVal      = 10           /* display top and bottom 30 frequencies */
    ,UniPlot       = 0            /* 0 or univariate plots    */
    ,UniVar        = 0            /* 0 or univariate analysis */
    ,chart         = 0            /* 0 or proc chart horizontal histograme */
    ,misspat       = 0            /* 0 or 1 missing patterns */
    ,taball        = 0            /* 0 crosstabs of all pairwise combinations of vriables */
    ,tabone        = 0            /* 0 or all pairwise cross tabs with limits */
    ,mispop        = 0            /* 0 0 negative positive or missing on each variable */
    ,mispoptbl     = 0            /* 0 missing populated table */
    ,dupcol        = 0            /* 0 do two columns have the same values in all rows */
    ,unqtwo        = 0            /* 0 only use to find primary key unique leveels of compund keys */
    ,vdocor        = 0            /* 0 or all pairwise parametric and non parametric collolations */
    ,oneone        = 0            /* 0 or 1:1  1:many many:many */
    ,cramer        = 0            /* 0 or cramer V variable crossed with all others */
    ,optlength     = 0            /* 0 optimum length for character and numeric variables */
    ,maxmin        = 0            /* 0 or max min for every varuiable */
    ,unichr        = 0            /* 0 univariate analysis of character variiables */
    ,outlier       = 0            /* 0 robust regression determination of outliers */
    ,rsquare       = 0            /* 0 robust regression determination of outliers */
    ,printto       = d:\rad\vdo\&data..txt  /* save the voluminous output */
    ,Cleanup       = 0
    );

/**************************************************************************************************************************/
/*                                                                                                                        */
/* EXACT MATCH                                                                                                            */
/*                                                                                                                        */
/*                                                                                                                        */
/* SUBSAMPLE       DOC     CURRENT                                                                                        */
/*                         RUN                                                                                            */
/*      1        790,790   790,790                                                                                        */
/*      2        792,562   792,562                                                                                        */
/*      3        792,415   792,415                                                                                        */
/*      4        789,485   789,485                                                                                        */
/*      5        790,538   790,538                                                                                        */
/*      6        793,146   793,146                                                                                        */
/*      7        791,916   791,916                                                                                        */
/*      8        790,244   790,244                                                                                        */
/*      9        790,818   790,818                                                                                        */
/*     10        791,355   791,355                                                                                        */
/*     11        791,845   791,845                                                                                        */
/*     12        789,209   789,209                                                                                        */
/*     13        790,950   790,950                                                                                        */
/*     14        792,115   792,115                                                                                        */
/*     15        791,462   791,462                                                                                        */
/*     16        792,099   792,099                                                                                        */
/*     17        790,146   790,146                                                                                        */
/*     18        793,115   793,115                                                                                        */
/*     19        792,733   792,733                                                                                        */
/*     20        790,044   790,044                                                                                        */
/*                                                                                                                        */
/*   Dataset=rad.rad_010Outpatient frequencies and distinct count for YEAR_CLM_THRU_DT SAMPLE_NO 11SEP2022:09:50:25       */
/*                                                                                                                        */
/*                       UNIQUE_                                                                                          */
/*          YEAR_CLM_    SAMPLE_                                                                                          */
/*   Obs     THRU_DT        NO      OBSEVATIONS                                                                           */
/*                                                                                                                        */
/*    1          .          20         222803                                                                             */
/*    2       2008          20        5663993                                                                             */
/*    3       2009          20        6450859                                                                             */
/*    4       2010          20        3489332                                                                             */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

 /*  _                         _       _
  __| |_ __ _   _  __ _    ___| | __ _(_)_ __ ___  ___
 / _` | `__| | | |/ _` |  / __| |/ _` | | `_ ` _ \/ __|
| (_| | |  | |_| | (_| | | (__| | (_| | | | | | | \__ \
 \__,_|_|   \__,_|\__, |  \___|_|\__,_|_|_| |_| |_|___/
                  |___/
*/

* I DECIDED NOT TO LOOP BECAUSE I THINK SUBMITTING A FEW AT A TIME AND CHECKING THE LOG IS USEFUL;

%macro rad_010drg(idx);

 %utlfkil(d:/rad/zip/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_&idx..zip);

 filename out "d:/rad/zip/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_&idx..zip";

 proc http
   method = 'GET'
   url    = "http://downloads.cms.gov/files/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_&idx..zip"
   out    =  out;
 run;quit;

 filename out clear;

%mend rad_010drg;


%rad_010drg(1);
%rad_010drg(2);
%rad_010drg(3);
%rad_010drg(4);
%rad_010drg(5);
%rad_010drg(6);
%rad_010drg(7);
%rad_010drg(8);
%rad_010drg(9);
%rad_010drg(10);
%rad_010drg(11);
%rad_010drg(12);
%rad_010drg(13);
%rad_010drg(14);
%rad_010drg(15);
%rad_010drg(16);
%rad_010drg(17);
%rad_010drg(18);
%rad_010drg(19);
%rad_010drg(20);

/*               _
 _   _ _ __  ___(_)_ __
| | | | `_ \|_  / | `_ \
| |_| | | | |/ /| | |_) |
 \__,_|_| |_/___|_| .__/
                  |_|
*/

%macro rad_010unz(idx);

   %utlfkil(d:/rad/zip/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_&idx..csv);
   %let zip=d:/rad/zip/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_&idx..zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath d:\rad\csv\;);

   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

%mend rad_010unz;

%rad_010unz(1);
%rad_010unz(2);
%rad_010unz(3);
%rad_010unz(4);
%rad_010unz(5);
%rad_010unz(6);
%rad_010unz(7);
%rad_010unz(8);
%rad_010unz(9);
%rad_010unz(10);
%rad_010unz(11);
%rad_010unz(12);
%rad_010unz(13);
%rad_010unz(14);
%rad_010unz(15);
%rad_010unz(16);
%rad_010unz(17);
%rad_010unz(18);
%rad_010unz(19);
%rad_010unz(20);

/*                   _     _
  ___ ___  _ __ ___ | |__ (_)_ __   ___    ___ _____   _____
 / __/ _ \| `_ ` _ \| `_ \| | `_ \ / _ \  / __/ __\ \ / / __|
| (_| (_) | | | | | | |_) | | | | |  __/ | (__\__ \\ V /\__ \
 \___\___/|_| |_| |_|_.__/|_|_| |_|\___|  \___|___/ \_/ |___/

*/

* PUT CSVS TOGETHER - COMBINE ALL THE CSVS INTO ONE CSV;

%array(_bs,values=1-20);

%put &=_bs1;
%put &=_bs20;

%utlfkil(d:/rad/csv/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample.csv);

data _null_;

  retain dne 0;
  file "d:/rad/csv/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample.csv" lrecl=32750 recfm=v;

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:/rad/csv/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_?.csv" lrecl=32750 recfm=v firstobs=2 end=dne;
        input;
        _infile_ = catx(',',put(input("?",2.),z2.),_infile_);
        put _infile_;
     end;
     dne=0;
  ));

  putlog _infile_;
  stop;
run;quit;


/*                   _
 ___  __ _ ___    __| |_ __ _   _  __ _
/ __|/ _` / __|  / _` | `__| | | |/ _` |
\__ \ (_| \__ \ | (_| | |  | |_| | (_| | frqh tot_rx_cst_amt
|___/\__,_|___/  \__,_|_|   \__,_|\__, |
                                  |___/
*/
libname rad "d:/rad";

data rad.rad_010Drug (label="from d:/rad/csv/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample.csv");

  infile "d:/rad/csv/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample.csv" dsd dlm=',' lrecl=32750 recfm=v stopover;

  attrib
           YEAR_SRVC_DT  length=$4  informat=$4.      label='DESYNPUF: Year RX Service Date'
           SAMPLE_NO     length=$2  informat=$2.      label='DESYNPUF: Sample Number'

           DESYNPUF_ID     length=$16 format=$16. label='DESYNPUF: Beneficiary Code'
           PDE_ID          length=$15 format=$15. label='DESYNPUF: CCW Part D Event Number'
           SRVC_DT         length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: RX Service Date'
           PROD_SRVC_ID    length=$19 format=$19. label='DESYNPUF: Product Service ID'
           QTY_DSPNSD_NUM  length=8   format=12.3 label='DESYNPUF: Quantity Dispensed'
           DAYS_SUPLY_NUM  length=3   format=3.   label='DESYNPUF: Days Supply'
           PTNT_PAY_AMT    length=8   format=10.2 label='DESYNPUF: Patient Pay Amount'
           TOT_RX_CST_AMT  length=8   format=10.2 label='DESYNPUF: Gross Drug Cost'
        ;

    input
          sample_no
          desynpuf_id
          pde_id
          srvc_dt
          prod_srvc_id
          qty_dspnsd_num
          days_suply_num
          ptnt_pay_amt
          tot_rx_cst_amt ;

         year_srvc_dt  = put(year(srvc_dt ),4.);

  run;

*Options ls=171;
%*utlvdoc
    (
    libname        = rad         /* libname of input dataset */
    ,data          = rad_010Drug  /* name of input dataset */
    ,key           = 0     /* 0 or variable */
    ,ExtrmVal      = 10           /* display top and bottom 30 frequencies */
    ,UniPlot       = 0            /* 0 or univariate plots    */
    ,UniVar        = 0            /* 0 or univariate analysis */
    ,chart         = 0            /* 0 or proc chart horizontal histograme */
    ,misspat       = 0            /* 0 or 1 missing patterns */
    ,taball        = 0            /* 0 crosstabs of all pairwise combinations of vriables */
    ,tabone        = 0            /* 0 or all pairwise cross tabs with limits */
    ,mispop        = 0            /* 0 0 negative positive or missing on each variable */
    ,mispoptbl     = 0            /* 0 missing populated table */
    ,dupcol        = 0            /* 0 do two columns have the same values in all rows */
    ,unqtwo        = 0            /* 0 only use to find primary key unique leveels of compund keys */
    ,vdocor        = 0            /* 0 or all pairwise parametric and non parametric collolations */
    ,oneone        = 0            /* 0 or 1:1  1:many many:many */
    ,cramer        = 0            /* 0 or cramer V variable crossed with all others */
    ,optlength     = 0            /* 0 optimum length for character and numeric variables */
    ,maxmin        = 0            /* 0 or max min for every varuiable */
    ,unichr        = 0            /* 0 univariate analysis of character variiables */
    ,outlier       = 0            /* 0 robust regression determination of outliers */
    ,rsquare       = 0            /* 0 robust regression determination of outliers */
    ,printto       = d:\rad\vdo\&data..txt  /* save the voluminous output */
    ,Cleanup       = 0
    );


/**************************************************************************************************************************/
/*                                                                                                                        */
/* EXCACT MATCH                                                                                                           */
/*                                                                                                                        */
/* Frequency of sample_no datasets rad.rad_010Drug 11SEP2022:10:27:06                                                     */
/*                                                                                                                        */
/*                     DESYNPUF: Sample Number                                                                            */
/*                                                                                                                        */
/*           CMS           CURRENT                                                                                        */
/*  SAMPL    DOC           RUN                                                                                            */
/*                                                                                                                        */
/*  01      5,552,421     5,552,421                                                                                       */
/*  02      5,561,154     5,561,154                                                                                       */
/*  03      5,557,147     5,557,147                                                                                       */
/*  04      5,549,070     5,549,070                                                                                       */
/*  05      5,549,634     5,549,634                                                                                       */
/*  06      5,557,441     5,557,441                                                                                       */
/*  07      5,560,085     5,560,085                                                                                       */
/*  08      5,556,025     5,556,025                                                                                       */
/*  09      5,552,470     5,552,470                                                                                       */
/*  10      5,545,284     5,545,284                                                                                       */
/*  11      5,552,888     5,552,888                                                                                       */
/*  12      5,555,572     5,555,572                                                                                       */
/*  13      5,549,202     5,549,202                                                                                       */
/*  14      5,553,031     5,553,031                                                                                       */
/*  15      5,551,438     5,551,438                                                                                       */
/*  16      5,560,073     5,560,073                                                                                       */
/*  17      5,555,828     5,555,828                                                                                       */
/*  18      5,564,559     5,564,559                                                                                       */
/*  19      5,550,500     5,550,500                                                                                       */
/*  20      5,552,147     5,552,147                                                                                       */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*                   _                  _       _                 _
  ___ __ _ _ __ _ __(_) ___ _ __    ___| | __ _(_)_ __ ___  ___  / |
 / __/ _` | `__| `__| |/ _ \ `__|  / __| |/ _` | | `_ ` _ \/ __| | |
| (_| (_| | |  | |  | |  __/ |    | (__| | (_| | | | | | | \__ \ | |
 \___\__,_|_|  |_|  |_|\___|_|     \___|_|\__,_|_|_| |_| |_|___/ |_|

http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_1A.zip
http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_5B.zip
DE1.0 Sample 1 2008-2010 Carrier Claims 1
*/

* I DECIDED NOT TO LOOP BECAUSE I THINK SUBMITTING A FEW AT A TIME AND CHECKING THE LOG IS USEFUL;

%macro rad_010drg(idx);

 %utlfkil(http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.A.zip);
 %utlfkil(http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.B.zip);

 filename out "d:/rad/zip/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.A.zip";

 proc http
   method = 'GET'
   url    = "http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.A.zip"
   out    =  out;
 run;quit;

 filename out clear;

 filename out "d:/rad/zip/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.B.zip";

 proc http
   method = 'GET'
   url    = "http://downloads.cms.gov/files/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.B.zip"
   out    =  out;
 run;quit;

 filename out clear;

%mend rad_010drg;

%rad_010drg(1);
%rad_010drg(2);
%rad_010drg(3);
%rad_010drg(4);
%rad_010drg(5);
%rad_010drg(6);
%rad_010drg(7);
%rad_010drg(8);
%rad_010drg(9);
%rad_010drg(10);
%rad_010drg(11);
%rad_010drg(12);
%rad_010drg(13);
%rad_010drg(14);
%rad_010drg(15);
%rad_010drg(16);
%rad_010drg(17);
%rad_010drg(18);
%rad_010drg(19);
%rad_010drg(20);

/*               _
 _   _ _ __  ___(_)_ __
| | | | `_ \|_  / | `_ \
| |_| | | | |/ /| | |_) |
 \__,_|_| |_/___|_| .__/
                  |_|
*/

%macro rad_010unz(idx);

   %utlfkil(c:/rad/csv/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.A.csv);
   %let zip=d:/rad/zip/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.A.zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath c:\rad\csv\;);

   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

   %utlfkil(d:/rad/zip/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.B.csv);
   %let zip=d:/rad/zip/DE1_0_2008_to_2010_Carrier_Claims_Sample_&idx.B.zip;

   %put &=zip;
   %let cmd=%str(powershell expand-archive -path &zip -destinationpath c:\rad\csv\;);

   %put &=cmd;
   options xwait xsync;run;quit;
   systask kill _ps1;
   systask command "&cmd" taskname=_ps1;
   waitfor _ps1;

%mend rad_010unz;

%rad_010unz(1);
%rad_010unz(2);
%rad_010unz(3);
%rad_010unz(4);
%rad_010unz(5);
%rad_010unz(6);
%rad_010unz(7);
%rad_010unz(8);
%rad_010unz(9);
%rad_010unz(10);
%rad_010unz(11);
%rad_010unz(12);
%rad_010unz(13);
%rad_010unz(14);
%rad_010unz(15);
%rad_010unz(16);
%rad_010unz(17);
%rad_010unz(18);
%rad_010unz(19);
%rad_010unz(20);

/*                   _     _
  ___ ___  _ __ ___ | |__ (_)_ __   ___    ___ _____   _____
 / __/ _ \| `_ ` _ \| `_ \| | `_ \ / _ \  / __/ __\ \ / / __|
| (_| (_) | | | | | | |_) | | | | |  __/ | (__\__ \\ V /\__ \
 \___\___/|_| |_| |_|_.__/|_|_| |_|\___|  \___|___/ \_/ |___/

*/

* PUT CSVS TOGETHER - COMBINE ALL THE CSVS INTO ONE CSV;

%array(_bs,values=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20);

%put &=_bsn;
%put &=_bs19;

%utlfkil(d:\rad\csv\DE1_0_2008_to_2010_Carrier_Claims_Sample.csv);

data _null_;

  retain dne 0;
  length lyn $3300;

  file "d:\rad\csv\DE1_0_2008_to_2010_Carrier_Claims_Sample.csv" lrecl=32750 recfm=v;

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:\rad\csv\DE1_0_2008_to_2010_Carrier_Claims_Sample_?A.csv" lrecl=3300 recfm=v dsd delimiter=','  firstobs=2 end=dne length=len;
        input lyn $varying3200. len;
        if length(strip(_infile_)) < 3099 then do;
           lyn = catx(',','A',put(input("?",2.),z2.),lyn);
           put lyn;
        end;
     end;
     dne=0;
  ));

  dne=0;

  %do_over(_bs,phrase=%str(
     do until (dne);
        infile  "d:\rad\csv\DE1_0_2008_to_2010_Carrier_Claims_Sample_?B.csv" lrecl=3300 recfm=v dsd delimiter=','  firstobs=2 end=dne length=len;
        input lyn $varying3200. len;
        if length(strip(_infile_)) < 3099 then do;
           lyn = catx(',','B',put(input("?",2.),z2.),lyn);
           put lyn;
        end;
     end;
     dne=0;
  ));

  stop;
run;quit;


/*
data _null_;
  infile  "d:\rad\csv\DE1_0_2008_to_2010_Carrier_Claims_Sample.csv" dsd delimiter=',' lrecl=32750 recfm=v length=len;
  input;
  cma=countc(_infile_,',');
  putlog  cma=;
  putlog _infile_;
run;quit;

  if cma eq 141 ;
  if (_n_ ge 26004602) and  (_n_ le 26004606);
  put _infile_;
run;quit;

  cma=countc(_infile_,',');
  if cma ne 141 then do;  put _n_= cma=; stop; end;
run;quit;
*/

/*                                   _
 ___  __ _ ___    ___ __ _ _ __ _ __(_) ___ _ __
/ __|/ _` / __|  / __/ _` | `__| `__| |/ _ \ `__|
\__ \ (_| \__ \ | (_| (_| | |  | |  | |  __/ |
|___/\__,_|___/  \___\__,_|_|  |_|  |_|\___|_|

*/

%macro addseqattrib(varname=,nvars=,varlength=,varinformat=,varformat=,labeltext=);
  %******************************************************************************;
  %* This macro program is called by macro program DESYNPUF_CAR_READIN. It       ;
  %* generates ATTRIB information for a series of variables. The parameters are  ;
  %*                                                                             ;
  %* The VARNAME= and NVARS= parameters are required.                            ;
  %* VARNAME=  name of series of variables (everything but the numeric suffix)   ;
  %* NVARS=    number of variables in the series                                 ;
  %*                                                                             ;
  %* The remaining parameters are optional.                                      ;
  %* VARLENGTH=  length of each variable in the series. If the series is         ;
  %*             character type, precede the length with a dollar sign ($)       ;
  %* VARINFORMAT= informat to use to read in the series. If the informat ends in ;
  %*              a period, include the period.                                  ;
  %* VARFORMAT=   format to use to display the values of the series. If the      ;
  %*              format ends in a period, include the period.                   ;
  %* LABELTEXT=   label to assing to series. The program adds the variable number;
  %*              to the end of the label. Be careful of quotation marks or other;
  %*              special characters. You may need to hardcode labels that       ;
  %*              special characters.                                            ;
  %******************************************************************************;

  %local a;

  %do a=1 %to &nvars;
     &varname&a %if &varlength ne %then %do;
                  length=&varlength
                %end;
                %if &varinformat ne %then %do;
                  informat=&varinformat
                %end;
                %if &varformat ne %then %do;
                  format=&varformat
                %end;
                %if %nrbquote(&labeltext) ne %then %do;
                  label="&labeltext &a"
                %end;
  %end;

%mend addseqattrib;

/* frqh carrier_code*sample_no */

data rad.rad_010Carier (label="from d:/rad/csv/DE1_0_2008_to_2010_Carrier_Claims_Sample.csv");

  infile "d:/rad/csv/DE1_0_2008_to_2010_Carrier_Claims_Sample.csv" dsd dlm=',' lrecl=32750 recfm=v stopover length=len;

  if len < 3100 then do;

  attrib
           YEAR_CLM_THRU_DT                 length=$4  informat=$4.      label='DESYNPUF: Claim Thru Data'
           CARRIER_CODE                     length=$1  informat=$1.      label='DESYNPUF: Carrier Code'
           SAMPLE_NO                        length=$2  informat=$2.      label='DESYNPUF: Sample Number'

           DESYNPUF_ID   length=$16 format=$16. label='DESYNPUF: Beneficiary Code'
           CLM_ID        length=$15 format=$15. label='DESYNPUF: Claim ID'
           CLM_FROM_DT   length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Claims start date'
           CLM_THRU_DT   length=4   informat=yymmdd8. format=yymmddn8. label='DESYNPUF: Claims end date'
           %addseqattrib(varname=ICD9_DGNS_CD_,nvars=8,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Claim Diagnosis Code)
           %addseqattrib(varname=PRF_PHYSN_NPI_,nvars=13,varlength=$10,varformat=$10.,labeltext=DESYNPUF: Provider Physician - National Provider Identifier Number)
           %addseqattrib(varname=TAX_NUM_,nvars=13,varlength=$10,varformat=$10.,labeltext=DESYNPUF: Provider Institution Tax Number)
           %addseqattrib(varname=HCPCS_CD_,nvars=13,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Revenue Center HCFA Common Procedure Coding System)
           %addseqattrib(varname=LINE_NCH_PMT_AMT_,nvars=13,varlength=8,varformat=12.2,labeltext=DESYNPUF: Line NCH Payment Amount)
           %addseqattrib(varname=LINE_BENE_PTB_DDCTBL_AMT_,nvars=13,varlength=8,varformat=12.2,labeltext=DESYNPUF: Line Beneficiary Part B Deductible Amount)
           %addseqattrib(varname=LINE_BENE_PRMRY_PYR_PD_AMT_,nvars=13,varlength=8,varformat=12.2,labeltext=DESYNPUF: Line Beneficiary Primary Payer Paid Amount)
           %addseqattrib(varname=LINE_COINSRNC_AMT_,nvars=13,varlength=8,varformat=12.2,labeltext=DESYNPUF: Line Coinsurance Amount)
           %addseqattrib(varname=LINE_ALOWD_CHRG_AMT_,nvars=13,varlength=8,varformat=12.2,labeltext=DESYNPUF: Line Allowed Charge Amount)
           %addseqattrib(varname=LINE_PRCSG_IND_CD_,nvars=13,varlength=$1,varformat=$1.,labeltext=DESYNPUF: Line Processing Indicator Code)
           %addseqattrib(varname=LINE_ICD9_DGNS_CD_,nvars=13,varlength=$5,varformat=$5.,labeltext=DESYNPUF: Line Diagnosis Code)
           ;;


    input
          CARRIER_CODE
          SAMPLE_NO
          DESYNPUF_ID
          CLM_ID
          CLM_FROM_DT
          CLM_THRU_DT
          ICD9_DGNS_CD_1-ICD9_DGNS_CD_8
          PRF_PHYSN_NPI_1-PRF_PHYSN_NPI_13
          TAX_NUM_1-TAX_NUM_13
          HCPCS_CD_1-HCPCS_CD_13
          LINE_NCH_PMT_AMT_1-LINE_NCH_PMT_AMT_13
          LINE_BENE_PTB_DDCTBL_AMT_1-LINE_BENE_PTB_DDCTBL_AMT_13
          LINE_BENE_PRMRY_PYR_PD_AMT_1-LINE_BENE_PRMRY_PYR_PD_AMT_13
          LINE_COINSRNC_AMT_1-LINE_COINSRNC_AMT_13
          LINE_ALOWD_CHRG_AMT_1-LINE_ALOWD_CHRG_AMT_13
          LINE_PRCSG_IND_CD_1-LINE_PRCSG_IND_CD_13
          LINE_ICD9_DGNS_CD_1-LINE_ICD9_DGNS_CD_13
        ;
        YEAR_CLM_THRU_DT = PUT(YEAR(CLM_THRU_DT),4.);

  end;

  /*
  if _n_ le 5 then put len / _infile_;
  else stop;
  */

  run;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  ONLY Onr issue with SAMPLE_11                                                                                         */
/*                                                                                                                        */
/*              DOC        CURRENT  DOC          CURRENT frqh HCPCS_CD_1                                                  */
/*              CARRIER__   RUN     CARRIER__    RUN                                                                      */
/*   SUBSAMPLE      A_                   B_                                                                               */
/*                                                                                                                        */
/*        1      2370667   2370667   2370668     2370668                                                                  */
/*        2      2372957   2372957   2372957     2372957                                                                  */
/*        3      2372802   2372802   2372802     2372802                                                                  */
/*        4      2371539   2371539   2371540     2371540                                                                  */
/*        5      2367559   2367559   2367559     2367559                                                                  */
/*        6      2372842   2372842   2372842     2372842                                                                  */
/*        7      2370899   2370899   2370899     2370899                                                                  */
/*        8      2369216   2369216   2369216     2369216                                                                  */
/*        9      2367266   2367266   2367267     2367267                                                                  */
/*       10      2373682   2373682   2373683     2373683                                                                  */
/*       11      2371837   2295174*  2371837     2371837                                                                  */
/*       12      2372792   2372792   2372793     2372793                                                                  */
/*       13      2371418   2371418   2371418     2371418                                                                  */
/*       14      2372187   2372187   2372187     2372187                                                                  */
/*       15      2368641   2368641   2368641     2368641                                                                  */
/*       16      2372291   2372291   2372291     2372291                                                                  */
/*       17      2372948   2372948   2372948     2372948                                                                  */
/*       18      2372588   2372588   2372589     2372589                                                                  */
/*       19      2373983   2373983   2373983     2373983                                                                  */
/*       20      2373609   2373609   2373609     2373609                                                                  */
/*                                                                                                                        */
/**************************************************************************************************************************/

%stop_submission;

data inp ;
  set rad.rad_010inpatient(obs=10000);
run;quit;
%utl_optlenpos(inp,inp);

%utl_optlenpos(rad.rad_010inpatient,rad.rad_010inpatient);
%utl_optlenpos(rad.rad_010bne,rad.rad_010bne);
%utl_optlenpos(rad.rad_010outpatient,rad.rad_010outpatient);
%utl_optlenpos(rad.rad_010drug,rad.rad_010drug);
%utl_optlenpos(rad.rad_010carier,rad.rad_010carier);

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
