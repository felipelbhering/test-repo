list.of.packages <- c("rjson")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#functions
###############
write_table_clipboard <-function(df, rownames = FALSE, dec = '.', sep = '\t'){	
  
  write.table(file = "clipboard-2^25", df, row.names = rownames, quote = FALSE, sep = sep, dec = dec)	
  
}

write_table_file<-function(name, df, rownames = FALSE, dec = '.', sep = '\t'){	
  
  write.table(file = name, df, row.names = rownames, quote = FALSE, sep = sep, dec = dec, na = "")	
  
}


#############

json_file <- "wunderlist-2018083-20_52_08.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

#write_table_clipboard (a)

list.condition <- sapply(json_data$data$tasks, function(x) x$completed == "FALSE")
output.list  <- json_data$data$tasks[list.condition]

#length(json_data$data$tasks)
#length(output.list)

a=lapply(json_data$data$tasks, `[[`, 'title')
a2=lapply(output.list, `[[`, 'title')


write_table_file(a2,name='lista.txt')

