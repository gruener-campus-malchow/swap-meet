<?php
class Model {
	protected $name;
	protected $id;
	protected $db;
	
	public function __construct($name, $db)
	{
		$this->name = $name;
		$this->db = $db;
	}
	public function setId($id)
	{
		$this->id = $id;
	}
	
	public function read()
	{
		$query = 'SELECT * FROM '.$this->name;
		
		$statement = $this->db->prepare($query);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
		
		return $data;
	}
	
	// TODO: everything from now on!!!
	public function read($id)
	{
		return TRUE;
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
