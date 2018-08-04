list.of.packages <- c("rjson")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(rjson)

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


list.condition <- sapply(json_data$data$tasks, function(x) x$completed == "FALSE")
output.list  <- json_data$data$tasks[list.condition]


#a2 <- lapply(output.list, `[[`, 'title')
df <- rbind_list(output.list)
df <- df %>% select(-c(created_by_id,id,completed,type))

write_table_file(df, name='lista.txt')

