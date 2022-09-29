<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your application. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/

// TODO: Retirar este teste daqui... OK, acesso ao banco blz, Model OK.
// Mapear e criar Controllers e Repositories
use App\Models\Estado;
use App\Models\Especialidade;
use App\Models\Procedimento;

Route::get('/', function () {
    $estados = Estado::all();
    $especialidades = Especialidade::all();
    $procedimentos = Procedimento::all();
    return view('home', [
        'estados' => $estados,
        'especialidades' => $especialidades,
        'procedimentos' => $procedimentos
    ]);
})->name('home');
// FIM TODO

// Login/Logout
Route::get('login', 'AutenticacaoController@getLogin')->name('login');
Route::post('login', 'AutenticacaoController@postLogin');
Route::get('logout', 'AutenticacaoController@getLogout')->name('logout');

// Cadastros (Pacientes, Profissionais PF, Profissionais PJ)
Route::group(['prefix' => 'cadastro'], function() {
    Route::get('paciente', 'PacienteController@getCreate');
    Route::get('pessoafisica', 'PessoaFisicaController@getCreate');
    Route::get('pessoajuridica', 'PessoaJuridicaController@getCreate');

    Route::post('paciente/store', 'PacienteController@postStore');
    Route::post('pessoafisica/store', 'PessoaFisicaController@postStore');
    Route::post('pessoajuridica/store', 'PessoaJuridicaController@postStore');

    // Busca cidade e bairro
    Route::group(['prefix' => 'busca'], function() {
        Route::get('cidades', 'PessoaController@getCidadesByEstado');
        Route::get('bairros', 'PessoaController@getBairrosByCidade');
    });

    // Salvar cidade e bairro
    Route::group(['prefix' => 'salvar'], function() {
        Route::post('cidade', 'PessoaController@postAddCidade');
        Route::post('bairro', 'PessoaController@postAddBairro');
    });
});
