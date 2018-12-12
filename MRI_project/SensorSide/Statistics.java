/**
 * This is a static class that provides to calculate statistical features of
 * time series segments. Some methods like Max, Min maybe redundant as they are also present in
 * the Math java class but are included here for completion. 
 * 
 *  @author Rittika Shamsuddin
 *  @version 2.0
 *  @since December, 2018
 */

package SensorSide;

import java.util.ArrayList;
import java.util.Arrays;

public final class Statistics{
	
	/**Calculates mean of input object Time Series
	 * @param ts
	 * @return mean, m
	 */
	public static Double Mean(TimeSeries ts){
		//get the actual data from Time Series object
		ArrayList<Double> data=ts.getData();
		Integer size = ts.getLength();
	
		//calculate mean
		Double sum = 0.0;
        for(int i=0; i<=size-1; i++){
            sum = sum +data.get(i);
        }
        Double m = sum/size;
        
		return m;
	}
	
	/**Calculates variance of input object Time Series
	 * @param ts
	 * @return variance, var
	 */
	public static Double Variance(TimeSeries ts){
		//get the actual data from Time Series object
		ArrayList<Double> data=ts.getData();
		Integer size = ts.getLength();
		
		//get mean
		Double mean =Mean(ts);
		Double sumTemp =0.0;
		
		//calculate variance: sum[(x-mean)^2]
		for(int i=0; i<=size-1; i++){
			sumTemp=sumTemp+ ((data.get(i)-mean)*(data.get(i)-mean));
		}
		
		//normalize the sum of squared difference to get variance
		Double var =sumTemp/size;
		return var;
	}
	

	/**Calculates variance of object Time Series 
	 * @param ts
	 * @return Standard Deviation: returns the square root of Variance
	 */
	public static Double Std(TimeSeries ts){
		return Math.sqrt(Variance(ts));
	}
	
	
	/**
	 * Calculate median of object Time Series
	 * @param ts
	 * @return Median
	 */
	 public static Double Median(TimeSeries ts){
		//get the actual data from Time Series object
		 ArrayList<Double> data=ts.getData();
		 Integer size = ts.getLength();
		 
		 
		 //Convert arrayList to array for sorting
		  Double a[] = new Double[data.size()];
	      a = data.toArray(a);
	      Arrays.sort(a);

	      //find the middle of the list
	      //and return the average of the 2 middle elements
	      //if length of ts divisible by 2
	       if (a.length % 2 == 0){
	          return (double) (a[(size/2) - 1] + a[(size/2)]) / 2.0;
	       } 
	       
	       //if not divisible by 2, then return the
	       // middle element
	       return a[(int) Math.floor(size/2)];
	    }
	 
	 
	 /**
	  * Calculate quantiles of object Time Series
	  * Can also use this method to find the median(50th quantile)
	  * @param ts
	  * @param dp
	  * @return the quantile of ts as specified by dp
	  */
	 public static Double Quantiles(TimeSeries ts, Double dp){
		//get the actual data from Time Series object
		 ArrayList<Double>  data=ts.getData();
		 Integer size = ts.getLength();
		 
		//Convert arrayList to array for sorting
		 Double a[] = new Double[data.size()];
	      a = data.toArray(a);
	     Arrays.sort(a);
	      
	     Double[] quantiles=new Double[size];
	     
	     int index=-1;
	     Double q=0.0;
	     
	     //first the location of the array
	     // which corresponds to the quantile 
	     // as specified by dp
	     for(int i=0; i<=size-1; i++){
				quantiles[i]=(i+1-0.5)/size;				
					if(i>0){						
						if(dp>= quantiles[i-1] && dp<=quantiles[i]){
							index=i;						
							break;
						}
					}
	     }
	

	     //if a valid location is found
	     // return the value of the array at that location
	     if(index !=-1){	    	 
			if(index<=size-1){
				q= a[index-1] + (a[index]-a[index-1])*((dp-quantiles[index-1])/(quantiles[index]-quantiles[index-1]));
			}
			
	     }
	     else if((1-dp) <=(dp-0)){
	    	 q=a[size-1];
	     }
	     else{
	    	 q=a[0];
	     }
	     
	      
	     return q;
	 }
	 
	 /**
	  * Calculate inter-quartile range of object Time Series
	  * @param ts
	  * @return iqr
	  */
	 public static Double IQR(TimeSeries ts){
		 return Quantiles( ts, .75)-Quantiles( ts, .25);
	 }
	 
	 /**
	  * Calculate max value of object Time Series
	  * @param ts
	  * @return max
	  */
	 public static Double Max(TimeSeries ts){
		 return Quantiles( ts, 1.0);
	 }
	 
	 
	 /**
	  * Calculate min value of object Time Series
	  * @param ts
	  * @return min
	  */
	 public static Double Min(TimeSeries ts){
		 return Quantiles( ts, 0.0);
	 }
	 
	 /**
	  * Return string representation of a double arraylist
	  * @param row
	  * @return string
	  */
	 public static StringBuilder getStringDouble(ArrayList<Double> row){
			
			StringBuilder sb =new StringBuilder();
			for (Double d: row){
				String s=d.toString();
				sb.append(s);
				sb.append("\t");
			}
			return sb;		
		}
	 
	 /**
	  * Return string representation of a interger arraylist
	  * @param row
	  * @return string
	  */ 
	 public static StringBuilder getStringInteger(ArrayList<Integer> row){
			
			StringBuilder sb =new StringBuilder();
			for (Integer d: row){
				String s=d.toString();
				sb.append(s);
				sb.append("\t");
			}
			return sb;		
		}
	 
	 
}
