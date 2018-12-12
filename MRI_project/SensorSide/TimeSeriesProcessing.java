/**
 * This is a specialized static class for handling Time series data as objects.
 * Mainly getter and setter methods for handling different properties
 * of time series data
 * Still under development; could be merged with Time Series Class.
 * 
 *  @author Rittika Shamsuddin
 *  @version 2.0
 *  @since December, 2018
 */

package SensorSide;

import java.util.ArrayList;


public final class TimeSeriesProcessing {
	
	/**
	 * Finds the peaks of the time series
	 * @param ts
	 * @return the peak values and the location of the peaks
	 */
	public static ArrayList<ArrayList<Double>> findingPeaks(TimeSeries ts){
		ArrayList<Double> pk= new ArrayList<Double>();
		ArrayList<Double> loc= new ArrayList<Double>();
		
		int size=ts.getLength();
		ArrayList<Double> data =ts.getData();
		for(int i=1; i<=size-2; i++){
			//when finding peaks
			// looks for local maxima e.g.
			//decreasing values on both sides
            if(data.get(i)>data.get(i-1) && data.get(i)>data.get(i+1)){
            	pk.add(data.get(i));
            	loc.add((double) i+1);
            	
            }
        }
		
		
		ArrayList<ArrayList<Double>> pkLoc=new ArrayList<ArrayList<Double>>(2);
		pkLoc.add(pk);
		pkLoc.add(loc);
		System.out.println(pkLoc.size());
		return pkLoc;
		
	}
	
	/**
	 * Prints out the peaks that were found
	 * @param ts
	 * @return n/a
	 */
	public static void viewPeaks(ArrayList<ArrayList<Double>> pkLoc){
		int len= pkLoc.get(0).size();
		
		for(int i=0; i<=len-1; i++){
			double p=pkLoc.get(0).get(i);
			double l=pkLoc.get(1).get(i);
			
			System.out.println("Peak is: "+ p +" AT "+ l);
		}
		
	}
	
	/**
	 * A function that lets the user put
	 * a threshold on amplitude value
	 * @param aL
	 * @param th
	 * @return 1 if values in aL are larger than threshold, th; 0 otherwise
	 */
	public static ArrayList<Integer> threshold(ArrayList<Double> aL,Double th){
		Integer sz=aL.size();
		ArrayList<Integer> binAL=new ArrayList<Integer>(sz);
		
		for (int i=0;i<sz;i++){
			if(aL.get(i)>th){
				binAL.add(i,1);
			}
			else{
				binAL.add(i,0);
			}
		
		}
		
		return binAL;
	}

}
