<?php

use Exception;

class client
{
    private string $nom;
    private string $prenom;
    private string $cin;
    private string $tel;

    public function __construct(string $nom = "", string $prenom = "", string $cin = "", string $tel = "")
    {

        $this->nom = $nom;
        $this->prenom = $prenom;
        $this->cin = $cin;
        $this->tel = $tel;
    }
    public function getcin()
    {
        return $this->cin;
    }
    public function setcin($cin)
    {
        if (!preg_match("/^[A-Z]{2,4}\d{2,7}$/", $cin))
            throw new Exception("cin invalide!");
        $this->cin = $cin;
    }
    public function getnom()
    {
        return $this->nom;
    }
    public function setnom($nom)
    {
        $this->nom = $nom;
    }
    public function gettel()
    {
        return $this->tel;
    }
    public function settel($tel)
    {
        $this->tel = $tel;
    }
    public function getprenom()
    {
        return $this->prenom;
    }
    public function setprenom($prenom)
    {
        $this->prenom = $prenom;
    }
    public function __toString()
    {
        return "nom :$this->nom,<br> prenom :$this->prenom ,<br>cin :$this->cin ,<br>tel :$this->tel";
    }
}
