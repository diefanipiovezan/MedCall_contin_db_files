<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PessoaFisica extends Model
{
    protected $table = 'tbl_pessoa_fisica';
    public $timestamps = false;

    public function pessoa()
    {
        return $this->belongsTo('App\Models\Pessoa', 'id_pessoa');
    }

    public function logradouro()
    {
        return $this->belongsTo('App\Models\Logradouro', 'id_logradouro');
    }
}
