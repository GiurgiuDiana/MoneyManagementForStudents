package new_bd_project;

import java.awt.EventQueue;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JComboBox;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JTextPane;

import net.proteanit.sql.DbUtils;

import javax.swing.JTable;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

public class user_secretara {

	private BufferedReader reader;
	private Connection con; 
	private static String spaces(int space)
	{
		String sp = "";
		for(int i=0;i<space;i++)
			sp = sp+" ";
		return sp;
	}
	private String convertSQLString(String st)
	{	// Main function is to replace "'" in string with "''"
		return st.replaceAll("'","''");
	}
	private String getLine()
	{	 String inputLine = "";
		  try{
			 inputLine = reader.readLine();
		  }catch(IOException e){
			 System.out.println(e);
			 System.exit(1);
		  }//try
	     	 return inputLine;
	}
	JFrame frame;
	private JTextPane txtpnbugetbaniCheltuiti;
	private JTable table_1;
	private JScrollPane scrollPane;
	private JTextField txtUserSecretaraParola;
	private void doQuery(String queryStr)
	{
		try {
			
			Connection con= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(queryStr);
		table_1.setModel(DbUtils.resultSetToTableModel(rst));
			ResultSetMetaData rsmd = rst.getMetaData();
			//table.setModel(DbUtils.resultSetToTableModel(rsmd));
			// Calculate column sizes (cut off large columns to 35)
			int colCount = rsmd.getColumnCount();
			int rowCount = 0;
			int colWidth[] = new int[colCount];
			for (int i=1; i <= colCount; i++)
			{	colWidth[i-1] = rsmd.getColumnDisplaySize(i);
				if (colWidth[i-1] > 35)
					colWidth[i-1] = 35;
			}

			System.out.println();
			// Print header
			for (int i=1; i <= colCount; i++)
			{	String colName = rsmd.getColumnName(i);
				System.out.print(colName+spaces(colWidth[i-1]-colName.length())+' ');
			}
			System.out.println("\n-----------------------------------------------------------------------");

			while (rst.next())
			{
				for (int i=1; i <= colCount; i++)
				{	Object obj = rst.getObject(i);
					if (obj == null)
						System.out.print(spaces(colWidth[i-1]));
					else
					{	String data = obj.toString();
						System.out.print(data+spaces(colWidth[i-1]-data.length())+' ');
					}
				}
				System.out.println();
				rowCount++;
			}
			if (rowCount == 0)
				System.out.println("No results.");

			rst.close();
		}
		catch (SQLException ex) {
			System.err.println("SQLException: " + ex);
		}
	}

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					user_secretara window = new user_secretara();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public user_secretara() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 560, 443);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		JComboBox comboBox = new JComboBox();
		comboBox.setModel(new DefaultComboBoxModel(new String[] {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"}));
		comboBox.setBounds(38, 67, 45, 35);
		frame.getContentPane().add(comboBox);
		
		txtpnbugetbaniCheltuiti = new JTextPane();
		txtpnbugetbaniCheltuiti.setText("1.STUDENTI UTCN\r\n2.MEDIILE STUDENTILOR IN SEMESTRUL I\r\n3.MEDIILE STUDENTILOR IN SEMESTRUL II\r\n4. BURSE MERIT SEMESTRUL I\r\n5. BURSE MERIT SEMESTRUL II\r\n6.BURSE MERIT+SOCIALE\r\n7.BURSE SOCIALE\r\n8.SITUATIA SCOLARA STUDENTI\r\n9.SITUATIE SOCIALA  STUDENTI\r\n10.BAZA DE DATE FACULTATE");
		txtpnbugetbaniCheltuiti.setBounds(372, 11, 162, 226);
		frame.getContentPane().add(txtpnbugetbaniCheltuiti);
	
		JButton btnExecuta = new JButton("EXECUTA");
		btnExecuta.setBounds(25, 147, 89, 23);
		frame.getContentPane().add(btnExecuta);
		String sqlSt_table;
		sqlSt_table="select s.nume as NUME,s.prenume as PRENUME, s.adresa as ADRESA, s.domiciliu_temporar AS DOMICILIU, s.buget_membru AS BUGET_FAMILIE from student s where s.id=2;";
		try{Connection con= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sqlSt_table);
	
	scrollPane = new JScrollPane();
	scrollPane.setBounds(83, 248, 424, 134);
	frame.getContentPane().add(scrollPane);
	
	table_1 = new JTable();
	table_1.setEnabled(false);
	scrollPane.setViewportView(table_1);
	
	txtUserSecretaraParola = new JTextField();
	txtUserSecretaraParola.setText("user: SECRETARA \r\ncod: 1528");
	txtUserSecretaraParola.setBounds(10, 11, 225, 23);
	frame.getContentPane().add(txtUserSecretaraParola);
	txtUserSecretaraParola.setColumns(10);}
	catch (SQLException ex) {
		System.err.println("SQLException: " + ex);
	}
		btnExecuta.addActionListener(e->{String sqlSt;
		String content_combobox=(String) comboBox.getSelectedItem();
		int choice=Integer.parseInt(content_combobox);
		if(choice==1)
		{//STUDENTIII DIN BAZA DE DATE A UTCN
			sqlSt="select s.id as ID,s.nume as Nume,s.prenume as Prenume ,s.anul_de_studiu as An,s.adresa as Domiciliul_Stabil from student s order by s.id asc;";
			doQuery(sqlSt);
		}
		else if(choice==2)
		{//banii consumati, cand, cat , ramas
			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,m.media_an_anterior from student s inner join medie m on m.situatie_scolara_STUDENT_id=s.id ;";
			doQuery(sqlSt);
		}
		else if(choice==3)
		{//bani primiti, cand cat total
			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,m.media_sem1 from student s inner join medie m on m.situatie_scolara_STUDENT_id=s.id;";
			doQuery(sqlSt);
		}
		else if(choice==4)
		{
			sqlSt="select s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id \r\n" + 
					"where b.tip_bursa ='bursa merit'  and b. medie_situatie_scolara_id_semestru=1 group by s.id ;";
			doQuery(sqlSt);
		}
		else if(choice==5)
		{
			sqlSt="select s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id \r\n" + 
					"where b.tip_bursa ='bursa merit'  and b. medie_situatie_scolara_id_semestru=2 group by s.id ;";
			doQuery(sqlSt);
		}
		else if(choice==6)
		{
			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,b.tip_bursa from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id where \r\n" + 
					"b.tip_bursa='bursa merit+sociala';";
			doQuery(sqlSt);
		}
		else if(choice==7)
		{
			sqlSt="select s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id \r\n" + 
					"where b.tip_bursa ='bursa sociala'  and b. medie_situatie_scolara_id_semestru=1 group by s.id ;;";
			doQuery(sqlSt);
		}
		else if(choice==9)
		{
			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,g.tip_social from student s inner join situatie_sociala g on g.STUDENT_id=s.id ;";
			doQuery(sqlSt);
		}
		else if(choice==8)
		{
			sqlSt="select * from situatie_scolara group by student_id;";
			doQuery(sqlSt);
		}
		else if(choice==10)
		{//facultate persoane
			sqlSt="select * from facultate group by student_id;\r\n;";
			doQuery(sqlSt);
		}
		});
	}
}
