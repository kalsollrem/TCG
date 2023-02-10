package db_class;

public class LoginVO 
{
	private String no;		// 회원번호
	private String id;		// 회원 아이디
	private String name;	// 이름
	
	public String getNo() 		 	{ return no;   }
	public String getId() 		 	{ return id;   }
	public String getName() 	 	{ return name; }

	public void setNo(String no) 	{ this.no = no; }
	public void setId(String id) 	{ this.id = id; }
	public void setName(String name){ this.name = name; }

	public LoginVO(String no, String id, String name)
	{
		setNo(no);
		setId(id);
		setName(name);
	}

	public static void main(String[] args) 
	{
		
	}

}
