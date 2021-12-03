<?php

require_once('./models/model.php');

class Api {
	private $db;
	private $json;
	private $config;
	private $debug;
	private $debugMessages;
	
    public function __construct(){
		
		
		$this->config = parse_ini_file('config.ini');
		
		$this->debug = $this->config['debug'];
		
		if($this->debug){
			$this->debugMessages = array();
		}
        header('Content-Type: application/json');
        
        $this->dbConnect();
        
        $this->testUrlHandling();
        //$this->createTest();
        //$this->testDB();
        
        if($this->debug){
			$this->json = json_encode($this->debugMessages);
		}
	}
    private function dbConnect(){
		
		$this->db = new PDO('mysql:host='.$this->config['db_host'].
								';dbname='.$this->config['db_name'],
								$this->config['db_user'], 
								$this->config['db_password']);
        if ($this->debug){
			$this->debugMessages = array_merge(array(
				'errorcode' => $this->db->errorCode(),
				'errorinfo' => $this->db->errorInfo()
			), $this->debugMessages);
		}
       // $this->json = json_encode($data);
    }
    private function executeSELECT($query){
		$statement = $this->db->prepare($query);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
        
        if ($this->debug){
			$this->debugMessages = array_merge(array(
				'errorcode' => $this->db->errorCode(),
				'errorinfo' => $this->db->errorInfo()
			), $this->debugMessages);
		}
        
        return $data;
	}
	public function getJson()
	{
		return $this->json;
	}
	private function createTest(){
		$collection = array();
		
		$testmodel = new Model('item',$this->db, $this->debug);
		$data = $testmodel->readAll();
		array_push($collection, $data);
		if ($this->debug){
			array_push($this->debugMessages, $testmodel->debugMessages);
		}
				
		$testmodel = new Model('pictures',$this->db, $this->debug);
		$data = $testmodel->readAll();
		array_push($collection, $data);
		if ($this->debug){
			array_push($this->debugMessages, $testmodel->debugMessages);
		}

		$testmodel = new Model('item',$this->db, $this->debug);
		$data = $testmodel->readSingle('1');
		array_push($collection, $data);
		if ($this->debug){
			array_push($this->debugMessages, $testmodel->debugMessages);
		}

		$this->json = json_encode($collection);
	}
	private function testDB(){
		
		$data = $this->executeSELECT('SELECT * FROM item');
		$this->json = json_encode($data);
	}
	
	private function testUrlHandling(){
		$data = array();
		array_push($data, $_SERVER['REQUEST_URI']);
		$this->json = json_encode($data);
	}
	
}

$api = new Api();
echo $api->getJson();


?>
