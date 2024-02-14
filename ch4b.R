# Update dplyr
ifelse(packageVersion("dplyr") >= 1,
       "The installed version of dplyr package is greater than or equal to 1.0.0", update.packages("dplyr")
)

# Load pacman
if (!require("pacman")) install.packages("pacman")

# Load a bunch of packages
pacman::p_load(
    tidyverse, # the tidyverse framework
    skimr, # skimming data 
    here, # computational reproducibility
    infer, # statistical inference 
    tidymodels, # statistical modeling 
    gapminder, # toy data
    nycflights13, # for exercise
    ggthemes, # additional themes
    ggrepel, # arranging ggplots
    patchwork, # arranging ggplots
    broom, # tidying model outputs
    waldo # side-by-side code comparison
)

# T I D Y V E R S E

# Reshaping from wide to long
table4a

t4a_long <- table4a %>%
    pivot_longer(
        cols = c("1999", "2000"), # Selected columns
        names_to = "year", # Shorter columns (the columns going to be in one column called year)
        values_to = "cases"
    )

t4a_long
t4a_long$year <- as.numeric(t4a_long$year)
# or t4a_long$year <- t4a_long$year %>% as.numeric()
t4a_long

# Dealing with lots of columns

billboard
names(billboard)

billboard %>%
  pivot_longer(
    cols = starts_with("wk"), # Use regular expressions
    names_to = "week",
    values_to = "rank",
  )

# Dropping NAs

billboard %>%
  pivot_longer(
    cols = starts_with("wk"), # Use regular expressions
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE # Drop NAs
  )

# Reshaping from long to wide

table2

t2_wide <- table2 %>%
    pivot_wider(
        names_from = type, # first
        values_from = count # second
    )

t2_wide

# Implicit missing values: simply not present in the data.
# Explicit missing values: flagged with NA

stocks <- tibble(
    year = c(2019, 2019, 2019, 2020, 2020, 2020),
    qtr = c(1, 2, 3, 2, 3, 4),
    return = c(1, 2, 3, NA, 2, 3)
)

stocks

stocks %>%
    pivot_wider(
        names_from = year,
        values_from = return
    )

# Reshaping to create dummy variables

fish_encounters

fe_wide <- fish_encounters %>%
    pivot_wider(
        names_from = station,
        values_from = seen
    )

fe_wide

fe_wide <- fish_encounters %>%
    pivot_wider(
        names_from = station,
        values_from = seen,
        values_fill = 0
    )

fe_wide

# Separating a variable using a delimiter
# Note: 'unite' does the opposite

table3

table3 %>%
    separate(rate,
             into = c("cases", "population"),
             sep = "/"
    )

table3 %>%
    separate(rate,
             into = c("cases", "population"),
             sep = "/",
             convert = TRUE
    )


# D P L Y R

# Sorting rows by columns

mtcars 
dplyr::arrange(mtcars, mpg) # Low to High (default)
mtcars %>% arrange(mpg) # Same
mtcars %>% arrange(mpg) %>% head() # First 6 rows

# Sorting in decreasing order

mtcars %>% arrange(desc(mpg)) %>% head()

# Sorting by multiple variables

mtcars %>% arrange(desc(cyl),desc(mpg)) %>% head()

# Subsetting rows

starwars %>% head()

table(starwars$gender) # Tabulate by gender
table(starwars$gender)[1]

starwars %>%
    filter(gender == "feminine")

starwars %>%
  dplyr::filter(gender == "feminine") %>%
  arrange(desc(height))

starwars %>% nrow()

starwars %>%
    filter(height < 180, height > 160) %>%
    nrow()

starwars %>%
    filter(height < 180 & height > 160) %>%
    nrow() # Same

starwars %>%
    filter(height < 180 | height > 160) %>%
    nrow() # Different

is.na(starwars$height)

starwars %>%
    filter(is.na(height))

starwars %>%
    filter(!is.na(height))

# Subsetting by substring match

starwars %>%
    filter(grepl("ars", tolower(name))) # Base R

starwars %>%
    filter(str_detect(tolower(name), "ars")) # dplyr

starwars %>%
    filter(str_detect(tolower(name), "ars")) %>%
    nrow()

starwars %>%
    filter(str_detect(tolower(name), "ars")) %>%
    slice(2:3)

table(starwars$hair_color)

starwars %>%
  filter(hair_color %in% c("black", "brown"))

starwars %>%
  filter(hair_color %in% c("black", "brown")) %>%
  filter(eye_color %in% c("black", "brown")) 

# Sampling rows

# by %

starwars %>%
  slice_sample(
    prop = 0.10,
    replace = FALSE
  )

% by number

starwars %>%
  slice_sample(
    n = 20,
    replace = FALSE
  ) 

set.seed(1234)

starwars %>%
  slice_sample(
    n = 20,
    replace = FALSE
  ) 


# Subsetting columns

msleep

names(msleep)

msleep %>% select(order)

msleep %>% select(1:4)

msleep %>% select(order,name)

msleep %>%
  select(contains("sleep"))

msleep %>%
  select(starts_with("b"))

msleep %>%
  dplyr::select(ends_with("wt"))

msleep %>% select(order,everything())
