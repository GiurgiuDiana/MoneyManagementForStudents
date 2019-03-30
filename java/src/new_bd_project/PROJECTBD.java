package new_bd_project;

import java.awt.EventQueue;
import java.awt.Window;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
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
public class PROJECTBD {

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

	private JFrame frame;
	private JTextField textField;
	private JTextField textField_1;
	static PROJECTBD window = new PROJECTBD();

	/**
	 * Launch the application.
	 */
	private void doQuery(String queryStr)
	{
		try {
			
			Connection con= DriverManager.getConnection("jdbc:mysql://localHost:3306/mydb?useSSL=false","root","daiana3426220");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery(queryStr);
			//table.setModel(DbUtils.resultSetToTableModel(rst));
			ResultSetMetaData rsmd = rst.getMetaData();

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
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					
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
	public PROJECTBD() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	public void initialize() {
		
		frame = new JFrame();
		frame.setBounds(100, 100, 336, 224);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		JLabel lblNewLabel = new JLabel("ID");
		lblNewLabel.setBounds(77, 67, 47, 29);
		frame.getContentPane().add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("PASSWORD");
		lblNewLabel_1.setBounds(153, 67, 98, 29);
		frame.getContentPane().add(lblNewLabel_1);
		
		textField = new JTextField();
		textField.setBounds(48, 92, 86, 20);
		frame.getContentPane().add(textField);
		textField.setColumns(10);
		
		textField_1 = new JTextField();
		textField_1.setBounds(144, 92, 86, 20);
		frame.getContentPane().add(textField_1);
		textField_1.setColumns(10);
		// intre 1 si 8 avem studenti, 9 ii secretra, 10 ii  admin, 11 ii angajator
		JButton btnOk = new JButton("OK");
		btnOk.setBounds(112, 126, 47, 23);
		frame.getContentPane().add(btnOk);
		
		btnOk.addActionListener(new ActionListener()
		{public void actionPerformed(ActionEvent arg0)
			{
			String id=textField.getText();
			String pass=textField_1.getText();
			if(id.equals("1")&&pass.equals("0000"))
			{
				USER_STUDENT_INPUT in=new  	USER_STUDENT_INPUT();
				in.frame.setVisible(true);
				window.frame.setVisible(false);
				
			}
			else if(id.equals("2")&&pass.equals("0000"))
			{
				user_2 in=new  user_2();
				in.frame.setVisible(true);
				window.frame.setVisible(false);
			
			}
		
			else if(id.equals("9")&&pass.equals("1111"))
			{
				user_secretara in=new user_secretara();
				in.frame.setVisible(true);
				window.frame.setVisible(false);
			
			}
			
			
			}});

		
	
	}
}
