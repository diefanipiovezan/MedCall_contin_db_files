<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class AutenticacaoController extends Controller
{
    public function getLogin()
    {
        if (Auth::check()) {
            return redirect()->route('home');
        }

        return view('login');
    }

    public function postLogin(Request $request)
    {
        $credenciais = $request->only('username', 'password');
        if (Auth::attempt($credenciais)) {
            // TODO: Ver o tipo de pessoa e redirecionar de acordo com o tipo
            return redirect()->route('home');
        }

        return redirect()->route('login')->with('error-msg', 'Usuário ou senha inválidos!');
    }

    public function getLogout()
    {
        Auth::logout();
        return redirect()->route('home');
    }
}
