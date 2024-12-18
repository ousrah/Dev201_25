<?php
require_once("client.class.php");
class compte
{
    private float $solde;
    private  static $nbr = 0;
    private int  $code;
    private client  $propritaire;
    public function __construct($solde = 0, $propritaire = new client())
    {
        self::$nbr++;
        $this->solde = $solde;
        $this->code = self::$nbr;
        $this->propritaire = $propritaire;
    }


    public function __toString()
    {
        return "Compte: code = : " . $this->code . ", Nom propriétaire = " . $this->propritaire->getnom() . ", Solde = " . $this->solde . "<br> Détails du propriétaire:  " . $this->propritaire;
    }
    public function créditer($somme, $compte2 = null)
    {

        if ($compte2 != null) {
            $compte2->solde -= $somme;
        }

        $this->solde += $somme;
    }
    public function débiter($somme, $compte2 = null)
    {
        $this->solde -= $somme;
        if ($compte2 != null) {
            $compte2->solde += $somme;
        }
    }
    public static function getNombreComptes()
    {
        return self::$nbr;
    }
}
