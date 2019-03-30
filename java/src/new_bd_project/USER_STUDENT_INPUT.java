package new_bd_project;

import java.awt.EventQueue;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
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

public class USER_STUDENT_INPUT {

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
	private JTextField textField;
	private JTextField textField_1;
	private JTextField textField_2;
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
					USER_STUDENT_INPUT window = new USER_STUDENT_INPUT();
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
	public USER_STUDENT_INPUT() {
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
		table.setBounds(25, 11, 509, 35);
		frame.getContentPane().add(table);
		
		JComboBox comboBox = new JComboBox();
		comboBox.setModel(new DefaultComboBoxModel(new String[] {"1", "2", "3", "4", "5", "6", "7"}));
		comboBox.setBounds(38, 67, 45, 35);
		frame.getContentPane().add(comboBox);
		
		txtpnbugetbaniCheltuiti = new JTextPane();
		txtpnbugetbaniCheltuiti.setText("1.BUGET\r\n2.BANI CHELTUITI\r\n3.BANI PRIMITI\r\n4.SITUATIA SCOLARA\r\n5.CUMPARATURI\r\n6.DIVERTISMENT\r\n7.MANCARE");
		txtpnbugetbaniCheltuiti.setBounds(124, 67, 162, 113);
		frame.getContentPane().add(txtpnbugetbaniCheltuiti);
	
		JButton btnExecuta = new JButton("EXECUTA");
		btnExecuta.setBounds(25, 147, 89, 23);
		frame.getContentPane().add(btnExecuta);
		String sqlSt_table;
		sqlSt_table="select s.nume AS NUME,s.prenume AS PRENUME, s.adresa AS ADRESA, s.domiciliu_temporar AS DOMICILIU, s.buget_membru AS BUGET_FAMILIE from student s where s.id=1;";
		try{Connection con= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
		Statement stmt = con.createStatement();
		ResultSet rst = stmt.executeQuery(sqlSt_table);
	table.setModel(DbUtils.resultSetToTableModel(rst));
	
	scrollPane = new JScrollPane();
	scrollPane.setBounds(51, 224, 426, 134);
	frame.getContentPane().add(scrollPane);
	
	table_1 = new JTable();
	table_1.setEnabled(false);
	scrollPane.setViewportView(table_1);
	
	JButton btnImprumut = new JButton("IMPRUMUT");
	btnImprumut.setBounds(377, 57, 89, 23);
	frame.getContentPane().add(btnImprumut);
	
	textField = new JTextField();
	textField.setBounds(311, 101, 86, 20);
	frame.getContentPane().add(textField);
	textField.setColumns(10);
	
	textField_1 = new JTextField();
	textField_1.setBounds(311, 129, 86, 20);
	frame.getContentPane().add(textField_1);
	textField_1.setColumns(10);
	
	textField_2 = new JTextField();
	textField_2.setBounds(311, 160, 86, 20);
	frame.getContentPane().add(textField_2);
	textField_2.setColumns(10);
	
	JLabel lblStudentImprumutor = new JLabel("STUDENT\r\n IMPRUMUTOR");
	lblStudentImprumutor.setBounds(406, 91, 116, 28);
	frame.getContentPane().add(lblStudentImprumutor);
	
	JLabel lblSuMa = new JLabel("SUMA");
	lblSuMa.setBounds(420, 132, 46, 14);
	frame.getContentPane().add(lblSuMa);
	btnImprumut.addActionListener(e->{
	try { Connection conne= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
		CallableStatement stm= (CallableStatement)conne.prepareCall("{call imprumut(id_student_cerere,_id_student_imprumutor,_suma_imprumutata,_data_imprumut)}");

	stm.setInt(1,1);
	stm.setInt(2,Integer.parseInt(textField.getText()));
	stm.setInt(3,Integer.parseInt(textField_1.getText()));
	stm.setDate(4, Date.valueOf(textField_2.getText()));} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}});
	JLabel lblData = new JLabel("DATA");
	lblData.setBounds(420, 163, 46, 14);
	frame.getContentPane().add(lblData);}
	catch (SQLException ex) {
		System.err.println("SQLException: " + ex);
	}
		btnExecuta.addActionListener(e->{String sqlSt;
		String content_combobox=(String) comboBox.getSelectedItem();
		int choice=Integer.parseInt(content_combobox);
		if(choice==1)
		{
			sqlSt="select b.buget_initial AS BUGET_INITIAL,b.buget_temporar AS BUGET_TEMPORAR,b.data_initiala AS DATa_INITIALA,b.data_temporala DATA from buget b where b.STUDENT_id=1;";
			doQuery(sqlSt);
		}
		else if(choice==2)
		{//banii consumati, cand, cat , ramas
			sqlSt="select c.data_intermediara, c.suma_cheltuita ,c.buget_ramas from evidenta_cheltuieli c where c.STUDENT_id=1;";
			doQuery(sqlSt);
		}
		else if(choice==3)
		{//bani primiti, cand cat total
			sqlSt="select c.data_intermediara, c.suma_primita ,c.buget_nou from evidenta_bani_primiti c where c.STUDENT_id=1;";
			doQuery(sqlSt);
		}
		else if(choice==4)
		{
			sqlSt="select s.tip_finantare,s.nr_examen_r,s.nr_ani_examen_r,s.nr_laboratoare_r from situatie_scolara s where s.student_id=1;";
			doQuery(sqlSt);
		}
		else if(choice==5)
		{
			sqlSt="select c.tip_cumparaturi,c.plata_cumparaturi,c.data_c from cumparaturi_extra c where c.STUDENT_id=1;";
			doQuery(sqlSt);
		}
		else if(choice==6)
		{
			sqlSt="select d.tip_activitate,d.plata_activitate,d.data_d from divertisment d where d.STUDENT_id=1;";
			doQuery(sqlSt);
		}
		else if(choice==7)
		{
			sqlSt="select m.id_masa,m.data_m,m.plata_mancare from mancare m where m.STUDENT_id=1;";
			doQuery(sqlSt);
		}
		});
	}
}
