macro "Subtract Measured Background 2" {
      n = roiManager("count");
      if (n==0)
          exit("This macro requires at least one ROI Manager entry");
      sum = 0;
      for (i=0; i<n; i++) {
          roiManager("select", i);
          getStatistics(area, mean);
          sum += mean;
      }
      average = sum/n;
      run("Select None");
      run("Subtract...", "stack value="+average);
  }