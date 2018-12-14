package login;

import java.util.Comparator;

public class CollectionList implements Comparator<String> {
	private static CollectionList instance = new CollectionList();
	public static CollectionList getInstance() {
	      return instance;
	   }
	   
	   private CollectionList() {}
	   
	public int compare(String arg0, String arg1) {
		// TODO Auto-generated method stub
		return arg1.compareTo(arg0);
	}
}
