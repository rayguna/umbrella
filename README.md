# Umbrella

See notes in [this lesson](https://learn.firstdraft.com/lessons/104).

Tips:
- I converted the epoch time obtained from the weather API to coordinated universal time as follows: 

```
#change from epoch to universal time
utc_time = Time.at(current["time"]).utc
```
- UTC time can then be converted to, e.g., Chicago central time as follows:

```
#define CST time zone
cst_timezone = TZInfo::Timezone.get('America/Chicago') # 'America/Chicago' represents the Central Time Zone

#convert UTC to CST - not being used.
cst_time = cst_timezone.utc_to_local(utc_time)
```

- Here is the sample output:
<br>

<pre>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Will you need an umbrella today?    
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Where are you located?"
Chicago 

"Thanks. Checking the weather at Chicago..."
"Your coordinates are: 41.8781136, -87.6297982."
"The current date and time is: 2024-01-11 05:01:00 UTC"
"It is currently 32.52 °F"

Next hour: Clear
In 1 hours, there is a 7% chance of precipitation.
In 2 hours, there is a 31% chance of precipitation.
In 3 hours, there is a 55% chance of precipitation.
In 4 hours, there is a 78% chance of precipitation.
In 5 hours, there is a 83% chance of precipitation.
In 6 hours, there is a 87% chance of precipitation.
In 7 hours, there is a 91% chance of precipitation.
In 8 hours, there is a 61% chance of precipitation.
In 9 hours, there is a 30% chance of precipitation.
In 10 hours, there is a 0% chance of precipitation.
In 11 hours, there is a 0% chance of precipitation.
In 12 hours, there is a 0% chance of precipitation.
You might want to take an umbrella!

"Hours from now vs Precipitation probability"
 
 
95.0|                                    
90.0|                   *                
85.0|             *  *                   
80.0|          *                         
75.0|                                    
70.0|                                    
65.0|                                    
60.0|                      *             
55.0|       *                            
50.0|                                    
45.0|                                    
40.0|                                    
35.0|                                    
30.0|    *                    *          
25.0|                                    
20.0|                                    
15.0|                                    
10.0|                                    
 5.0| *                                  
 0.0+----------------------------*--*--*-
</pre>
