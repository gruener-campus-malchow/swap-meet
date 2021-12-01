<?php
class Model {
	protected $name;
	protected $id;
	protected $db;
	public $debugMessages;
	
	public function __construct($name, $db)
	{
		$this->name = $name;
		$this->db = $db;
		$this->debugMessages = array();
	}
	public function setId($id)
	{
		$this->id = $id;
	}
	
	public function readAll()
	{
		$query = 'SELECT * FROM '.$this->name;
		
		$statement = $this->db->prepare($query);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
		
		$this->debugMessages = array_push(
					$this->debugMessages, 
					array(
						'errorcode' => $this->db->errorCode(),
						'errorinfo' => $this->db->errorInfo()
					)
				);
		
		return $data;
	}
	
	// TODO: everything from now on!!!
	public function readSingle($id)
	{
		$query = "SELECT * FROM ".$this->name." WHERE id = :id";
		
		$statement = $this->db->prepare($query);
		$statement->bindParam(':id', $id);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
        
		$this->debugMessages = array_push(
					$this->debugMessages, 
					array(
						'errorcode' => $this->db->errorCode(),
						'errorinfo' => $this->db->errorInfo()
					)
				);
		
		//$statement->debugDumpParams();
		
		return $data;
	}

	public function update($id)
	{
		return TRUE;
	}
	
	public function delete($id)
	{
		return TRUE;
	}
	public function create()
	{
		return TRUE;
	}
	
}
?>
