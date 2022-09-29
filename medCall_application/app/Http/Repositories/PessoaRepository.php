<?php

namespace App\Http\Repositories;

use App\Models\TipoTelefone;
use App\Models\Estado;
use App\Models\Cidade;
use App\Models\Bairro;

class PessoaRepository
{
    public function getTiposTelefone()
    {
        $tiposTelefone = TipoTelefone::all()->sortBy('tipo');

        return $tiposTelefone;
    }

    public function getEstados()
    {
        $estados = Estado::all();

        return $estados;
    }

    public function getCidadesByEstado($idEstado)
    {
        $cidades = Cidade::where('id_estado', $idEstado)
                    ->orderBy('nome', 'asc')
                    ->get();

        return $cidades;
    }

    public function getBairrosByCidade($idCidade)
    {
        $bairros = Bairro::where('id_cidade', $idCidade)
                    ->orderBy('nome', 'asc')
                    ->get();

        return $bairros;
    }

    public function addCidade($idEstado, $nome)
    {
        $cidade = new Cidade;
        $cidade->nome = $nome;
        $cidade->id_estado = $idEstado;
        $cidade->save();

        return $cidade;
    }

    public function addBairro($idCidade, $nome)
    {
        $bairro = new Bairro;
        $bairro->nome = $nome;
        $bairro->id_cidade = $idCidade;
        $bairro->save();

        return $bairro;
    }
}
