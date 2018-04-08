package guestbook;

import java.util.Calendar;
import java.util.HashMap;
import java.text.SimpleDateFormat;
//import java.io.BufferedReader;
//import java.io.FileReader;
import java.io.*;
import java.sql.*;

public class Utils {

	public static final String DATE_FORMAT_NOW = "yyyy-MM-dd HH:mm:ss";

	public static String now() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
		return sdf.format(cal.getTime());
	}

	public static String now(String dateFormat) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		return sdf.format(cal.getTime());
	}

	public static Timestamp currentTimestamp() {
		// create a calendar instance
		Calendar calendar = Calendar.getInstance();

		// get a java.util.Date from the Calendar instance.
		// this date will represent the current instant, or "now".
		java.util.Date now = calendar.getTime();

		// create a JDBC Timestamp instance
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
		return currentTimestamp;
	}

    /**
     * Utility method that reads pair strings from a file into a HashMap.
     * @param file directory and file name.
     * @return a HashMap which keys are all fist items of the pair in the 
     * file, and the value is the second item of the corresponding key.
     */
	public static HashMap<String, String> getHashMapFromFile(String filename, boolean errExit) {
		HashMap<String, String> res = new HashMap<String, String>();
		BufferedReader in;
		try {
			//bpan: to allow chinese char in text file. Note: text file must be saved in UTF-8
			//in = new BufferedReader(new FileReader(filename));
			in = new BufferedReader(
			        new InputStreamReader(new FileInputStream(filename), "UTF8"));
			if (in == null) {
				//bpan: if error, probably not going here, instead, to catch block
				System.out.println("file not found: " + filename);
				System.exit(0);
			}
			while (in.ready()) {
				String s = in.readLine();
				String[] pair = s.split("\\,");
				if (pair.length == 2) {
					//System.out.println("Read File One Line --- " + pair[0] + " : " + pair[1]);
					res.put(pair[0].trim(), pair[1].trim());
				}
			}
			in.close();
		} catch (UnsupportedEncodingException e) { //bpan: must be UTF-8 encoding for text file
			System.out.println("File Encoding error: " + e);
			e.printStackTrace();
			if (errExit)	//bpan: distinguish severity
				System.exit(0);
			else
				return null;
		} catch (Exception e) {
			System.out.println("File read error: " + e);
			e.printStackTrace();
			if (errExit)	//bpan: distinguish severity
				System.exit(0);
			else
				return null;
		}
		
		return res;
	}

	  public static String isGender(String mf)
	  {
		  if ( mf.compareTo("M")== 0 )
		  {
			  return "Male";
		  }
		  else if ( mf.compareTo("F") == 0 )
		  {
			  return "Female";
		  }
		  else
		  {
			  return "";
		  }
	  }

	  public static int listCost(String prog_code, String need_bed, String is_member)
	  {
		  // 0~2, and 3 歲"
		  if (prog_code.compareTo("B") == 0 ||prog_code.compareTo("T") == 0)
		  {
			  return 0;
		  }
		  else
		  {
			  if (is_member.compareTo("N") == 0)
			  {
				  return 170;
			  }
			  else // HOC member
			  {
				  // age 4-11 without bed
				  if ((need_bed.compareTo("N") == 0) && (prog_code.compareTo("F") == 0 || prog_code.compareTo("P") == 0 
						  || prog_code.compareTo("S") == 0 || prog_code.compareTo("N") == 0))
				  {
					  return 90;
				  }
				  else
				  {
					  return 170;
				  }
			  }
		  }
	  }

	  public static String isProg_Code(String meynsftb)
	  {
		  if ( meynsftb.compareTo("M")== 0 )
		  {
			  return "中文成人";
		  }
		  else if ( meynsftb.compareTo("E") == 0 )
		  {
			  return "English";
		  }
		  else if ( meynsftb.compareTo("Y") == 0 )
		  {
			  return "12~18 yr.";
		  }
		  else if ( meynsftb.compareTo("N") == 0 )
		  {
			  return "9~11 yr.";
		  }
		  else if ( meynsftb.compareTo("S") == 0 )
		  {
			  return "7~8 yr.";
		  }
		  else if ( meynsftb.compareTo("F") == 0 )
		  {
			  return "5~6 yr.";
		  }
		  else if ( meynsftb.compareTo("T") == 0 )
		  {
			  return "4 yr.";
		  }
		  else if ( meynsftb.compareTo("R") == 0 )
		  {
			  return "3 yr.";
		  }
		  else if ( meynsftb.compareTo("B") == 0 )
		  {
			  return "0~2 yr.";
		  }
		  else
		  {
			  return "";
		  }
	  }


	  public static String isTop(String t1234)
	  {
      if ( t1234.compareTo("1")== 0 )
		  {
			  return "為耶路撒冷求平安!";
		  }
		  else if ( t1234.compareTo("2") == 0 )
		  {
			  return "家庭婚姻专题：在主爱中成长 ，在盼望中合一";
		  }
		  else if ( t1234.compareTo("3") == 0 )
		  {
			  return "基督徒职场生活";
		  }
		  else if ( t1234.compareTo("4") == 0 )
		  {
			  return "財經講座:天國投資";
		  }
		  else if ( t1234.compareTo("6") == 0 )
		  {
			  return "English Youth Program";
		  }		 
		  else if ( t1234.compareTo("7") == 0 )
		  {
			  return "English Adult Program";
		  }
		  else if ( t1234.compareTo("8") == 0 )
		  {
			  return "未定 Undecided";
		  }
		  else if ( t1234.compareTo("X") == 0 )
		  {
			  return "N/A";
		  }			
		  else
		  {
			  return "";
		  }
	  }

	  public static String isTopShort(String t1234)
	  {
		  return isTop(t1234);
	  }


	  public static String isBed(String yn)
	  {
		  if ( yn.compareTo("Y")== 0 )
		  {
			  return "需要安排床位 Bed Needed";
		  }
		  else if ( yn.compareTo("N") == 0 )
		  {
			  return "不需要安排床位 No Bed Needed";
		  }
		  else
		  {
			  return "";
		  }
	  }


	  public static String isRide(String yn)
	  {
		  if ( yn.compareTo("Y")== 0 )
		  {
			  return "需要安排接送 Ride Needed";
		  }
		  else if ( yn.compareTo("N") == 0 )
		  {
			  return "不需要安排接送 No Ride Needed";
		  }
		  else
		  {
			  return "";
		  }
	  }
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Now : " + Utils.now());

		System.out.println(Utils.now("dd MMMMM yyyy"));
		System.out.println(Utils.now("yyyyMMdd"));
		System.out.println(Utils.now("dd.MM.yy"));
		System.out.println(Utils.now("MM/dd/yy"));
		System.out.println(Utils.now("yyyy.MM.dd G 'at' hh:mm:ss z"));
		System.out.println(Utils.now("EEE, MMM d, ''yy"));
		System.out.println(Utils.now("h:mm a"));
		System.out.println(Utils.now("H:mm:ss:SSS"));
		System.out.println(Utils.now("K:mm a,z"));
		System.out.println(Utils.now("yyyy.MMMMM.dd GGG hh:mm aaa"));

	}

}
