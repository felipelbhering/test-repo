
###############
#Install packages 
list.of.packages <- c("rjson", "dplyr", "magrittr", "stringr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#required libraries
library(rjson)
library(dplyr)
library(magrittr)
library(stringr)

#functions
###############

write_table_clipboard <-function(df, rownames = FALSE, dec = '.', sep = '\t'){	
  
  write.table(file = "clipboard-2^25", df, row.names = rownames, quote = FALSE, sep = sep, dec = dec)	
  
}

write_table_file<-function(name, df, rownames = FALSE, dec = '.', sep = '\t'){	
  
  write.table(file = name, df, row.names = rownames, quote = FALSE, sep = sep, dec = dec, na = "")	
  
}


#############

#import json 
json_file <- "wunderlist-2018083-20_52_08.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))


list.condition <- sapply(json_data$data$tasks, function(x) x$completed == "FALSE")
output.list  <- json_data$data$tasks[list.condition]


#a2 <- lapply(output.list, `[[`, 'title')
df <- rbind_list(output.list) %>% 
        select(-c(created_by_id, id, completed, type, created_by_request_id)) %>% 
          arrange(desc(list_id),desc(starred),desc(revision)) %>% mutate(urgency = "", importance = "")
df <- data.frame(year = str_sub(df$created_at,1,4), due_date_true = !(df$due_date %>% is.na()), df)
df$created_at <- as.Date(str_sub(df$created_at,1,10), "%Y-%m-%d")

#export data.frame
write_table_file(df, name='lista.txt')

