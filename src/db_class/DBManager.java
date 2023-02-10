package db_class;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBManager 
{
	//DB�� �����Ѵ�
	//���ϰ� : ������ true, ���н� false
	
/* ========================================================================= */
	
	private Connection conn  = null;
	private String host      = "";
	private String userid    = "";
	private String passwd    = "";	
	
	private ResultSet result = null;
	private Statement stmt   = null;
	
/* ========================================================================= */

	
	public DBManager()
	{
		host   = "jdbc:mariadb://localhost:3306/novel?useSSL=false&useUnicode=true&characterEncoding=utf8";
		userid = "root";
		passwd = "1234";	
	}
	
	public void setHost(String host)     { this.host   = host;   }
	public void setUserid(String userid) { this.userid = userid; }
	public void setPasswd(String passwd) { this.passwd = passwd; }


	public boolean DBOpen()
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");  //JDBC����̹� Ŭ������ �ε�.
			conn = DriverManager.getConnection(host, userid, passwd);
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
		
	//DB�� �ݴ´�.
	public void DBclose()
	{
		try 
		{
			conn.close();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
	}
	
/* ========================================================================= */
	
	
	//Insert, Update, Delete SQL����ó��
	public boolean RunSQL(String sql)
	{
		System.out.println("=================================");
		System.out.println(sql);  									//SQL������ ǥ���Ѵ�.
		System.out.println("=================================");
		
		try
		{
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);				
			stmt.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
/* ========================================================================= */
	//SQL Query�� �����Ѵ�.
	public boolean OpenQuery(String sql)
	{
		try
		{
			stmt   = conn.createStatement();
			result = stmt.executeQuery(sql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//SQL Query�� �����Ѵ�.
	public void CloseQuery()
	{
		try 
		{
			result.close();
			stmt.close();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
	}
/* ========================================================================= */
	//���� ����� �����´�.
	public boolean GetNext()
	{
		try 
		{
			return result.next();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
			return false;
		}
	}

	//�÷����� �����´�.
	public String GetValue(String column)
	{
		try
		{
			return result.getString(column);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	public int GetInt(String column)
	{
		try
		{
			return result.getInt(column);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	/* ========================================================================= */

	public String GetDate(String rdate)  
	{	
		try
		{
			rdate = rdate.substring(0, 10);
			return rdate;			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return "";
		}
	}
	public String GetTime(String rdate)  
	{	
		try
		{
			rdate = rdate.substring(11);
			return rdate;			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return "";
		}
	}
	
}

