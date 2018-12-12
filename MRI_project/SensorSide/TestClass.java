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

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class TestClass {
	

	public static void main(String[] args){

		
		String csvFile = "/Users/Sky/Documents/workspace/SensorAPI/src/SensorSide/read1.csv";
        String line = "";
        String cvsSplitBy = ",";
        
        ArrayList<ArrayList<Double>> mat=new ArrayList<ArrayList<Double>>();
       
        //read in a .csv file
        try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {

        	int count=1;
            while ((line = br.readLine()) != null) {
            	if(count>2){
            		// use comma as separator
            		ArrayList<Double> temp=new ArrayList<Double>();
            		String[] country = line.split(cvsSplitBy);
            		Integer length=country.length;
            		
            		for(int i=0; i<length;i++){
            			Double val=new Double(country[i]);
            			temp.add(val);
            		}
            		temp.trimToSize();
            		
            		
            		mat.add(temp);
            		
                }
            	count=count+1;

            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        
        /////////////////////////////////////////////
        ////////// Test Methods As Needed////////////
        ////////////////////////////////////////////
        ArrayList<Double> row=mat.get(11);
	 
        ArrayList<Integer> thAL=TimeSeriesProcessing.threshold(row,7.0);
        System.out.println(Statistics.getStringInteger(thAL));
		
		
	}
	
	

}
