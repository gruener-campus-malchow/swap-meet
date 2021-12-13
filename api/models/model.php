<?php
class model {
	protected $name;
	protected $id;
	protected $db;
	protected $debug;
	protected $request;
	public $debugMessages;
	
	public function __construct($name, $db, $debug, $request)
	{
		$this->name = $name;
		$this->db = $db;
		$this->debugMessages = array();
		$this->request = $request;
	}
	public function setId($id)
	{
		$this->id = $id;
	}
	public function getName()
	{
		return $this->name;
	}
	
	public function readAll()
	{
		$query = 'SELECT * FROM '.$this->name;
		
		$statement = $this->db->prepare($query);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
		$this->addDebugMessages($statement);
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
        $this->addDebugMessages($statement);
		return $data;
	}

	public function readSpecial()
	{
		//this method have to be implemented in special model
		$data = array('You want special things, I cannot serve right now.');
		return $data;
	}


	private function update($id)
	{
		//this method have to be implemented with special model
		return TRUE;
	}
	
	public function delete($id)
	{
		
		$query = "DELETE FROM ".$id." WHERE id = :id;";
		
		$statement = $this->db->prepare($query);
		$statement->bindParam(':id', $id);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
		$this->addDebugMessages($statement);
		return $data;
	}
	private function create()
	{
		
		//this method have to be implemented with special model
		return TRUE;
		
	}
	
	protected function pdoDump($stmt) 
	{
		ob_start();
		$stmt->debugDumpParams();
		$r = ob_get_contents();
		ob_end_clean();
		return $r;
	}
	protected function addDebugMessages($statement)
	{
		if($this->debug)
		{
			$this->debugMessages = array_push(
					$this->debugMessages, 
					array(
						'errorcode' => $this->db->errorCode(),
						'errorinfo' => $this->db->errorInfo(),
						'pdoDump'	=> $this->pdoDump($statement)
					)
				);
		}
	}
	
}
?>
