package db_class;

public class LoginVO 
{
	private String no;		// ȸ����ȣ
	private String id;		// ȸ�� ���̵�
	private String name;	// �̸�
	
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
