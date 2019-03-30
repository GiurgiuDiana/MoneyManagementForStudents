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

public class user_2 {

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
	private JTable table;
	private JTextPane txtpnbugetbaniCheltuiti;
	private JTable table_1;
	private JScrollPane scrollPane;
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
					user_2 window = new user_2();
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
	public user_2() {
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
		
		table = new JTable();
		table.setBounds(25, 11, 509, 23);
		frame.getContentPane().add(table);
		
		JComboBox comboBox = new JComboBox();
		comboBox.setModel(new DefaultComboBoxModel(new String[] {"1", "2", "3", "4", "5", "6"}));
		comboBox.setBounds(38, 67, 45, 35);
		frame.getContentPane().add(comboBox);
		
		txtpnbugetbaniCheltuiti = new JTextPane();
		txtpnbugetbaniCheltuiti.setText("1.BUGET\r\n2.BANI CHELTUITI\r\n3.BANI PRIMITI\r\n4.situatia_scolara\r\n5.CUMPARATURI");
		txtpnbugetbaniCheltuiti.setBounds(197, 67, 162, 113);
		frame.getContentPane().add(txtpnbugetbaniCheltuiti);
	
		JButton btnExecuta = new JButton("EXECUTA");
		btnExecuta.setBounds(25, 147, 89, 23);
		frame.getContentPane().add(btnExecuta);
		String sqlSt_table;
		sqlSt_table="select s.nume as NUME,s.prenume as PRENUME, s.adresa as ADRESA, s.domiciliu_temporar AS DOMICILIU, s.buget_membru AS BUGET_FAMILIE from student s where s.id=2;";
		try{Connection con= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sqlSt_table);
	table.setModel(DbUtils.resultSetToTableModel(rst));
	
	scrollPane = new JScrollPane();
	scrollPane.setBounds(83, 248, 424, 134);
	frame.getContentPane().add(scrollPane);
	
	table_1 = new JTable();
	table_1.setEnabled(false);
	scrollPane.setViewportView(table_1);}
	catch (SQLException ex) {
		System.err.println("SQLException: " + ex);
	}
		btnExecuta.addActionListener(e->{String sqlSt;
		String content_combobox=(String) comboBox.getSelectedItem();
		int choice=Integer.parseInt(content_combobox);
		if(choice==1)
		{
			sqlSt="select b.buget_initial,b.buget_temporar,b.data_initiala,b.data_temporala from buget b where b.STUDENT_id=2;";
			doQuery(sqlSt);
		}
		else if(choice==2)
		{//banii consumati, cand, cat , ramas
			sqlSt="select c.data_intermediara, c.suma_cheltuita ,c.buget_ramas from evidenta_cheltuieli c where c.STUDENT_id=2;";
			doQuery(sqlSt);
		}
		else if(choice==3)
		{//bani primiti, cand cat total
			sqlSt="select c.data_intermediara, c.suma_primita ,c.buget_nou from evidenta_bani_primiti c where c.STUDENT_id=2;";
			doQuery(sqlSt);
		}
		else if(choice==4)
		{
			sqlSt="select s.tip_finantare,s.nr_examen_r,s.nr_ani_examen_r,s.nr_laboratoare_r from situatie_scolara s where s.student_id=2;";
			doQuery(sqlSt);
		}
		else if(choice==5)
		{
			sqlSt="select c.tip_cumparaturi,c.plata_cumparaturi,c.data_c from cumparaturi_extra c where c.STUDENT_id=2;";
			doQuery(sqlSt);
		}
		else if(choice==6)
		{
			sqlSt="select d.tip_activitate,d.plata_activitate,d.data_d from divertisment d where d.STUDENT_id=2;";
			doQuery(sqlSt);
		}
		else if(choice==7)
		{
			sqlSt="select m.id_masa,m.data_m,m.plata_mancare from mancare m where m.STUDENT_id=2;";
			doQuery(sqlSt);
		}
		});
	}
}
