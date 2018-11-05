<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Produto;

class PesquisaController extends Controller
{
    public function pesquisar(Request $request)
    {
        $registros = Produto::where([
            'ativo' => 'S'
        ])->get();

        return view('home.pesquisa', compact('registros'));
    }

    public function pesquisa(Request $request)
    {
        $dados = [];
        $dados['url'] = url('/');
        $dados['produto'] = Produto::where('nome','like','%'.$request->input('pesquisar').'%')->where('ativo','=','S')->get();
        foreach ($dados['produto'] as $key => $value) {

            $dados['produto'][$key] = $value;

        }
        return response()->json($dados);
    }


}
