package xml;

//for batch insert
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;

//for xml parsing
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/*
 * Must handle "dirty data" such as invalid types like 19yy - can assign as NULL
 * will need to update movies, and then stars_in_movies, genres_in_movies tables if necessary
 * not all tags are the same to specify same data? --> <dirname> vs <dirn>
 * 
 * need from mains:
 * 		movie title
 * 		movie year
 * 		movie director
 * need from cast:
 * 		star first name
 * 		star last name
 * 
 * ----can be ignored----
 * need from actors:
 * 		star dob
 */




public class xmlParse {
	
	Document dom;
	HashMap<ArrayList<String>, Integer> movies;
	HashMap<String, Integer> actors;
	HashMap<String, Integer> genres;
	
	public xmlParse() {
		movies = new HashMap<ArrayList<String>, Integer>();
		actors = new HashMap<String, Integer>();
		genres = new HashMap<String, Integer>();
	}

	public void batchInsert() throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		
		Connection conn = null;
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String jdbcURL = "jdbc:mysql://localhost:3306/moviedb?autoReconnect=true&useSSL=false";
		
		try {
			conn = DriverManager.getConnection(jdbcURL,"root","ryanjew");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		PreparedStatement movieInsertRecord=null;
		PreparedStatement genreInsertRecord=null;
		PreparedStatement castInsertRecord=null;
		
		String sqlInsertMovie=null;
		String sqlInsertGenre=null;
		String sqlInsertCast=null;
		
		int[] movieRows=null;
		int[] genreRows=null;
		int[] castRows=null;
		
		sqlInsertMovie="insert ignore into movies (title, year, director, banner_url, trailer_url) values (?, ?, ?, ?, ?)";
		sqlInsertGenre="insert ignore into genres (name) values (?)";
		sqlInsertCast="insert ignore into stars (first_name, last_name, dob, photo_url) values (?, ?, ?, ?)";
		
		ResultSet rs;
		ResultSet rs2;
		ResultSet rs3;
		String queryMovie = "select id, year, director, banner_url, trailer_url from movies where title = ?";		
		String queryGenre = "select id from genres where name = ?";
		String queryCast = "select id from stars where first_name = ? and last_name = ?";
		try {

			conn.setAutoCommit(false);
			movieInsertRecord=conn.prepareStatement(sqlInsertMovie);
			for (Map.Entry<ArrayList<String>, Integer> entry: movies.entrySet()) {
				if (entry.getKey().get(0) == null || entry.getKey().get(1) == null || entry.getKey().get(2) == null) {
					continue;
				}
				PreparedStatement movieQuery = conn.prepareStatement(queryMovie);
				movieQuery.setString(1, entry.getKey().get(0));
//					System.out.println("MOVE QUERY: " + movieQuery);
				rs = movieQuery.executeQuery();
				if (!rs.next()) {
					try {
					movieInsertRecord.setString(1, entry.getKey().get(0)); //title
					movieInsertRecord.setInt(2, Integer.parseInt(entry.getKey().get(1))); //year
					movieInsertRecord.setString(3, entry.getKey().get(2)); //dir
					movieInsertRecord.setString(4, null);
					movieInsertRecord.setString(5, null);
					movieInsertRecord.addBatch();
					} catch (Exception e) {
						continue;
					}
				}
			}
			
			movieRows=movieInsertRecord.executeBatch();
			conn.commit();

			
			
			
			conn.setAutoCommit(false);
			genreInsertRecord=conn.prepareStatement(sqlInsertGenre);
			for (Map.Entry<String, Integer> entry: genres.entrySet()) {
				if (entry.getKey() == null) {
					continue;
				}
				PreparedStatement genreQuery = conn.prepareStatement(queryGenre);
				genreQuery.setString(1, entry.getKey());
				System.out.println("genre QUERY: " + genreQuery);
				rs2 = genreQuery.executeQuery();
		/*
		 * need to check if genre is in the db, if not, add it if not null
		 */
				if (!rs2.next()) {
					if (entry.getKey() != null) { //cat/genre
//						System.out.println("HERE");
						genreInsertRecord.setString(1,entry.getKey());
					} else {
						genreInsertRecord.setString(1, null);
					}
					genreInsertRecord.addBatch();
				}
			}
			genreRows=genreInsertRecord.executeBatch();
			conn.commit();
		
			
			conn.setAutoCommit(false);
			castInsertRecord=conn.prepareStatement(sqlInsertCast);
			for (Map.Entry<String, Integer> entry: actors.entrySet()) {
				if (entry.getKey() == null) {
					continue;
				}
				PreparedStatement actorQuery = conn.prepareStatement(queryCast);
				String[] names = entry.getKey().split(" ");
				
				if (names.length > 1) {
//					System.out.println(names[0] + " " + names[1]);
					actorQuery.setString(1, names[0]);
					actorQuery.setString(2, names[names.length-1]);
				}
				else {
//					System.out.println(names[0]);
					actorQuery.setString(1, "");
					actorQuery.setString(2, names[0]);
				}
				rs3 = actorQuery.executeQuery();
				if(!rs3.next()) {
					if (names.length > 1) {
						castInsertRecord.setString(1, names[0]);
						castInsertRecord.setString(2, names[names.length-1]);
						castInsertRecord.setString(3, null);
						castInsertRecord.setString(4, null);
						castInsertRecord.addBatch();
					}
					else {
						castInsertRecord.setString(1, "");
						castInsertRecord.setString(2, names[0]);
						castInsertRecord.setString(3, null);
						castInsertRecord.setString(4, null);
						castInsertRecord.addBatch();
					}
				}
			}
			castRows=castInsertRecord.executeBatch();
			conn.commit();	
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			if (movieInsertRecord != null)
				movieInsertRecord.close();
			if (conn != null) 
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void parseXML(String file) {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		
		try {
			
			//Using factory to get an instance of document builder
			DocumentBuilder db = dbf.newDocumentBuilder();
			
			//Parse using builder to get DOM representation of XML File
			dom = db.parse(file);
			
		} catch (ParserConfigurationException pce) {
			pce.printStackTrace();
		} catch (SAXException se) {
			se.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		
	}
	
	public void parseDocument(String tagName, String[] fieldNames, String file) {
		
		//get root of dom representation
		Element domRoot = dom.getDocumentElement();
		
		NodeList nl = domRoot.getElementsByTagName(tagName);
		if (nl != null && nl.getLength() > 0) {
			for (int i = 0; i < nl.getLength(); i++) {
//				System.out.println((Element)nl.item(i));
				Element el = (Element)nl.item(i);
				Element e = getElement(el, fieldNames, file);
//				info.add(e);
			}
		}	
		
	}
	
	public Element getElement(Element element, String[] fieldNames, String file) {
		//
		ArrayList<String> temp = new ArrayList<String>();
		try {
			for (int i = 0; i < fieldNames.length; i++) {
				if (fieldNames[i].equals("cat")) {
					String s = getTextValues(element, fieldNames[i]).trim();
//					System.out.println(i);
					genres.put(s,1);
				} else {
					if (file.equals("mains243.xml")) {
					String s = getTextValues(element, fieldNames[i]);
	//				System.out.println(fieldNames[i] + ": " + s);
					temp.add(s);
					} else if (file.equals("casts124.xml")) {
						String s = getTextValues(element, fieldNames[i]).trim().replaceAll("\\s+"," ");
//						System.out.println(s);
						actors.put(s, 1);
					}
				}
			}
			if (file.equals("mains243.xml")) {
//				System.out.println("HEEEYEY");
				movies.put(temp,1);
			}
		} catch (Exception e) {
			System.out.println("=============================================================================");
			System.out.println("XML Could Not Be Parsed");
			System.out.println("=============================================================================");

		}
		
		return element;
	}
	
	public String getTextValues(Element element, String tagName) {
		//
		
		String textVal = null;
		NodeList nl = element.getElementsByTagName(tagName);
		if (nl != null && nl.getLength() > 0) {
			Element el = (Element)nl.item(0);
			textVal = el.getFirstChild().getNodeValue();
		}
		
		return textVal;
	}
	
//	public int getIntValues(Element element, String tagName) {
//		return Integer.parseInt(getTextValues(element, tagName));
//	}
	
	public void runParse(String file, String elementName, String[] fieldNames) {
		parseXML(file);
		parseDocument(elementName, fieldNames, file);
		
//		for (int i = 0; i < movies.size(); i++) {
//			for (int j = 0; j < movies.get(i).size(); j++) {
//				System.out.println(movies.get(i).get(j));
//			}
//		}
		
	}
	
	public static void main(String[] args) {
		//parser for each file
		
		xmlParse mains = new xmlParse();
		xmlParse cast = new xmlParse();
		//xmlParse actors = new xmlParse();
		
//		xmlParse parsed = new xmlParse();
		
		//tags for the data we want to scrape
		String[] movieTags = {"t", "year", "dirn", "cat"};
		String[] castTags = {"a"};
		
		//String[] actorTags = {"dob", "firstname", "familyname"};
		
		//runs parse routine for each file
		mains.runParse("mains243.xml", "film", movieTags);
		cast.runParse("casts124.xml", "m", castTags);
		

		//actors.runParse("actors63.xml", "actor", actorTags);
		
		try {
		mains.batchInsert();
		cast.batchInsert();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
