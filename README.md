# wolf-sheep
ASU ABM club adaptation of the [NetLogo wolf sheep predation model](http://ccl.northwestern.edu/netlogo/models/WolfSheepPredation) with added kill tracking from @mmannin5

# sample netlogo behaviorspace data
Sample data from @mmannin5, @felix-john, and Andres Baeza-Castro is available at https://dev.commons.asu.edu/data/abmclub/wolf-sheep 

# Reproducible R analysis workflow

1. Clone this repository
2. Open the `wolf-sheep.Rproj` project file in RStudio (`File > Open Project...` and select `wolf-sheep.Rproj`)
3. The previous step will take some time as it will install packrat and all the dependencies needed by the RMarkdown document, probably 5-10 minutes.   
4. Open `src/wolf_sheep_AB.Rmd`
5. Run the `knit` command

   ![Location of Knit button on RStudio](images/knit.png "RStudio knit")


# Packrat Resources

- [Setting up Packrat with an RStudio Project](https://rstudio.github.io/packrat/rstudio.html)
- [Packrat Documentation](https://rstudio.github.io/packrat/)
- [Packrat Video Walthrough](https://www.rstudio.com/resources/webinars/managing-package-dependencies-in-r-with-packrat/)

# References
Wilensky, U. (1997). NetLogo Wolf Sheep Predation model. http://ccl.northwestern.edu/netlogo/models/WolfSheepPredation.
Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.
