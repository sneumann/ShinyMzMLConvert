#' Title
#'
#' @param inpath 
#' @param outpath 
#'
#' @return
#' @export
#'
#' @examples

executeSingularityMsconvert <- function(indir, inname, outpath) {

  # https://www.r-bloggers.com/2021/09/how-to-use-system-commands-in-your-r-script-or-package/
  simgPath <- "/vol/kubernetes/Singularity/images/chambm_pwiz-skyline-i-agree-to-the-vendor-licenses-2019-05-23-1c92fb5c2527.simg"
  cmdout <- system2("/usr/bin/singularity", 
                    args = c("exec",
                             "-B", paste(indir, "/indata", sep=":"),
                             "-B", paste(outpath, "/outdata", sep=":"),
                             "-B", "/dev/shm/wineLtL:/mywineprefix",
                             simgPath,
                             "mywine", "msconvert", "--32",
                             "--outdir", "z:/outdata",
                             paste("z:/indata", inname, sep="/")
                    )
  )
  return(cmdout)
}

indir <- "/home/sneumann/tmp"
inname <- "MSpos-Ex1-Col0-48h-Ag-1_1-A-1_01_9818.d"
outpath <- "/home/sneumann/tmp"
cmdout <- executeSingularityMsconvert(indir, inname, outpath)
cat(cmdout)


executeSingularityConvertBruker <- function(indir) {
  cmdout <- system2("/vol/local/bin/convertbruker", args = c(indir))
  return(cmdout)
}
indir <- "/home/sneumann/tmp/MSpos-Ex1-Col0-48h-Ag-1_1-A-1_01_9818.d"
cmdout <- executeSingularityConvertBruker(indir, inname, outpath)
cat(cmdout)
