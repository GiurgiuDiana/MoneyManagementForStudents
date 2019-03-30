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

public class INPUT_TASTATURA {
	
	
	
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
	private JTextField textField;
	private JTextField textField_1;
	private JTextField textField_2;
	private JTextField textField_3;
	private JTextField textField_4;

	
	//private JFrame frame;
	private void doQuery(String queryStr)
	{
		try {
			
			Connection con= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(queryStr);
		table.setModel(DbUtils.resultSetToTableModel(rst));
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
					INPUT_TASTATURA window = new INPUT_TASTATURA();
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
	public INPUT_TASTATURA() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 698, 714);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
frame.getContentPane().setLayout(null);
		
		JLabel lblNewLabel = new JLabel("SELECT OPERATIE");
		lblNewLabel.setBounds(20, 11, 150, 42);
		frame.getContentPane().add(lblNewLabel);
		
		JComboBox comboBox = new JComboBox();
		comboBox.setModel(new DefaultComboBoxModel(new String[] {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"}));
		comboBox.setBounds(33, 57, 89, 23);
		frame.getContentPane().add(comboBox);
		
		JButton btnExecuta = new JButton("EXECUTA");
		btnExecuta.setBounds(53, 111, 89, 23);
		frame.getContentPane().add(btnExecuta);
	
		JTextPane txtpnCare = new JTextPane();
		txtpnCare.setText("#1.Care sunt studentii din baza de date a UTCN-ului ?\r\n#2. Care sunt sumele de bani ale studentilor la inceputul anului universitar?;\r\n#3.Care este suma totala cheltuita pe divertisment de studenti in luna octombrie?\r\n#4.Care este suma totala cheltuita pe mancare de studenti in luna octombrie ?\r\n#5.Care este suma totala cheltuita pe transport de studenti in luna octombrie \r\n#6.Care este suma totala cheltuita pe cumparaturi extra de studenti in luna octombrie \r\n.Care sunt mediile studentilor la intrare in semestrul 1?;\r\r\n#8.Care e situatia sociala a fiecarui student in anul universitar 2017-2018?\r\n9.Care sunt mediile studentilor la intrare in semestrul 2?\r\r\n#10.Care sunt veniturile pe membru de familie ale studentilor?\r\n11.Cati elevi iau bursa de merit in semestrul 1 ?\r\n12.Cati elevi iau in primul semestru atat bursa de merit cat si bursa sociala?\r\n#13.Cati elevi iau bursa sociala pe primul semestru ?\r\n,");
		txtpnCare.setBounds(219, 32, 412, 360);
		frame.getContentPane().add(txtpnCare);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(53, 427, 589, 220);
		frame.getContentPane().add(scrollPane);
		
		
		table = new JTable();
		table.setEnabled(false);
		scrollPane.setViewportView(table);
		
		textField = new JTextField();
		textField.setColumns(10);
		textField.setBounds(95, 156, 86, 20);
		frame.getContentPane().add(textField);
		
		JLabel label = new JLabel("ID");
		label.setBounds(51, 149, 34, 35);
		frame.getContentPane().add(label);
		
		JLabel label_1 = new JLabel("Semestrul");
		label_1.setBounds(20, 203, 95, 20);
		frame.getContentPane().add(label_1);
		
		textField_1 = new JTextField();
		textField_1.setColumns(10);
		textField_1.setBounds(95, 203, 86, 20);
		frame.getContentPane().add(textField_1);
		
		textField_2 = new JTextField();
		textField_2.setColumns(10);
		textField_2.setBounds(95, 245, 86, 20);
		frame.getContentPane().add(textField_2);
		
		JLabel label_2 = new JLabel("An");
		label_2.setBounds(24, 248, 61, 20);
		frame.getContentPane().add(label_2);
		
		textField_3 = new JTextField();
		textField_3.setColumns(10);
		textField_3.setBounds(95, 277, 86, 20);
		frame.getContentPane().add(textField_3);
		
		JLabel label_3 = new JLabel("Luna");
		label_3.setBounds(16, 279, 69, 30);
		frame.getContentPane().add(label_3);
		
		textField_4 = new JTextField();
		textField_4.setColumns(10);
		textField_4.setBounds(95, 309, 86, 20);
		frame.getContentPane().add(textField_4);
		
		JLabel label_4 = new JLabel("Zi");
		label_4.setBounds(16, 312, 77, 20);
		frame.getContentPane().add(label_4);
		btnExecuta.addActionListener(e->{String choice, cMonth,sqlSt;
		String m=(String) comboBox.getSelectedItem();
		String L=(String)textField_3.getText();
		if(L.equals(null)) {
			System.out.println("eroare");
		}
		
      int  choice1=Integer.parseInt(m);
              //  printMenu();
               // choice = getLine();
                if (choice1==1)				
    			{	sqlSt = "select s.id as ID,s.nume as Nume,s.prenume as Prenume ,s.anul_de_studiu as An,s.adresa as Domiciliul_Stabil"+" from student s order by s.id asc;\r\n";
    				doQuery(sqlSt);
    			}
                else if(choice1==2)
                {
                	sqlSt="select s.id AS ID,s.nume AS NUME,s.prenume as PRENUME ,b.buget_nou as BUGET from evidenta_bani_primiti b inner join student s on b.STUDENT_id=s.id where\r\n" + 
                			"(( year(b.data_intermediara)=2017) and (month(b.data_intermediara)=10)and (day(b.data_intermediara)=2))order by s.id asc;";
                	doQuery(sqlSt);
                }
                else if (choice1==3)	
    			{	int sLuna;
                	//System.out.print("Introdu luna:: ");
                sLuna=Integer.parseInt(L);
               if(sLuna==0) {
        			System.out.println("eroare");
        		}
                
    			
    				sqlSt="select m.id,m.nume,m.prenume,sum(t.plata_activitate),month(data_d) as luna from student m inner join divertisment t on m.id=t.STUDENT_id\r\n" + 
    						"where (month(data_d)="+sLuna+") group by m.id;";
    				doQuery(sqlSt);
    			
    			}
                else if (choice1==4)		
    			{	String sLuna;
            	System.out.print("Introdu luna:: ");
			
    				sqlSt ="select s.id,s.nume,s.anul_de_studiu,SUM(p.plata_mancare) from student s inner join mancare p on s.id=p.STUDENT_id where\r\n" + 
    						"month(p.data_m)="+Integer.parseInt(L)+" group by s.id;";
    				doQuery(sqlSt);
    			}
                else if (choice1==5)		
    			{	int sLuna;
    			System.out.print("Introdu luna:: ");
    			sLuna=Integer.parseInt(L);
    			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,SUM(t.plata_transport) from student s inner join transport t on s.id=t.STUDENT_id where \r\n" + 
    					"month(t.data_t)="+sLuna+" group by s.id ;\r\n" + 
    					"";
    			doQuery(sqlSt);
    			}
                else if (choice1==6)		
    			{	String sLuna;
    			System.out.print("Introdu luna:: ");
    			sLuna=L;
    			sqlSt="select s.id,s.nume,s.anul_de_studiu,SUM(e.plata_cumparaturi) AS cumparaturi from student s inner join cumparaturi_extra e on s.id=e.STUDENT_id where\r\n" + 
    					"month(e.data_c)="+L+" group by s.id;\r\n" + 
    					"";
    			doQuery(sqlSt);
    			}
                else if (choice1==7)		
    			{	String cSem;
    			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,m.media_an_anterior from student s inner join medie m on m.situatie_scolara_STUDENT_id=s.id ; ";
    			doQuery(sqlSt);
    			}
                else if (choice1==8)		
    			{	String cSem;
    			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,g.tip_social from student s inner join situatie_sociala g on g.STUDENT_id=s.id ;";
    			doQuery(sqlSt);
    			}
                else if (choice1==9)		
    			{ 		
    			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,m.media_sem1 from student s inner join medie m on m.situatie_scolara_STUDENT_id=s.id ;";
    			doQuery(sqlSt);
    			}
                else if (choice1==10)		
    			{ 		
    			sqlSt="select s.id,s.nume,s.prenume,s.anul_de_studiu,s.buget_membru from student s ;";
    			doQuery(sqlSt);
    			}
                else if (choice1==11)		
    			{	String sSem;
    			System.out.println("Introduceti Luna");
    			sSem=getLine();
    			sqlSt=" sselect s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id \r\n" + 
    					"where b.tip_bursa ='bursa merit'  and b. medie_situatie_scolara_id_semestru="+sSem+" group by s.id ;";
    			doQuery(sqlSt);
    			}
                else if (choice1==12)		
    			{	
    			sqlSt=" select s.id,s.nume,s.prenume,s.anul_de_studiu,b.tip_bursa from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id where \r\n" + 
    					"b.tip_bursa='bursa merit+sociala'";
    			doQuery(sqlSt);
    			}
                else if (choice1==13)		
    			{	String cSem;
    		System.out.print("Introdu semestrul:: ");
    		cSem=getLine();
    			sqlSt=" select s.id,s.nume,s.prenume ,s.anul_de_studiu as an ,b.suma_bursa  from student s inner join bursa b on s.id=b.medie_situatie_scolara_STUDENT_id \r\n" + 
    					"where b.tip_bursa ='bursa sociala'  and b. medie_situatie_scolara_id_semestru="+cSem+"group by s.id ;\r\n";
    			doQuery(sqlSt);
    			}
                else if (choice1==12)		
    			{	String sLuna;
    			System.out.println("Introduceti Luna");
    			sLuna=L;
    			sqlSt="SELECT s.id, CONCAT(s.nume, ' ',s.prenume) as student,MONTH(c.data_intermediara) as luna,sum(c.suma_primita) as SumaPrimita\r\n" + 
    					"FROM student s INNER JOIN evidenta_bani_primiti c\r\n" + 
    					" ON s.id = c.STUDENT_id  where month(c.data_intermediara)="+L+"group by s.id";
    			doQuery(sqlSt);
    			}
//                
//                try {
//					CallableStatement stm= (CallableStatement)con.prepareCall("{call imprumut(id_student_cerere int,_id_student_imprumutor int,_suma_imprumutata int,_data_imprumut datetime)}");
//				stm.setInt(1, 2);;} catch (SQLException e1) {
//					// TODO Auto-generated catch block
//					e1.printStackTrace();
//				}
////      
                                  


		
	});
	}
	public void setVisible(boolean b) {
		// TODO Auto-generated method stub
		
	}	
}

