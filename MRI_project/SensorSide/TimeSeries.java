/**
 * This is a specialized class for handling Time series data as objects.
 * Mainly getter and setter methods for handling different properties
 * of time series data
 * Still under development
 *  @author Rittika Shamsuddin
 *  @version 2.0
 *  @since December, 2018
 */

package SensorSide;

import java.util.ArrayList;

public class TimeSeries {
	
	private ArrayList<Double> data;
	private ArrayList<Double> time;
	private Integer length;
	
	public TimeSeries(ArrayList<Double> x){
		data=x;
		length= (int) data.size();
	}
	
	
	public ArrayList<Double> getData(){
		return data;
	}
	
	public ArrayList<Double> getTime(){
		return time;
	}
	
	public void setTime(ArrayList<Double> t){
		time=t;
	}
	
	public Integer getLength(){
		return length;
	}

}
