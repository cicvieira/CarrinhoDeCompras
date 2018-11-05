<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Http\Controllers\Controller;
use App\Produto;
use App\Categorias_has_produtos;


class ProdutoController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    public function index()
    {
        $produtos = Produto::all();
        return view('admin.produto.index', compact('produtos'));
    }

    public function adicionar()
    {
        return view('admin.produto.adicionar');
    }

    public function editar($id)
    {

        $registro = Produto::find($id);
        $registro->categorias = '';
        $arr = array();

        $resultado = DB::table('categorias_has_produtos AS ca')
        ->select('ca.categorias_id','c.categoria','c.descricao')
        ->join('categorias AS c',function($join) {
           $join->on('ca.categorias_id','=','c.id');
        })->where('ca.produtos_id','=',$registro->id)
        ->get();

        foreach ($resultado as $key => $item) {
            $arr[$key]['categorias_id']= $item->categorias_id;
            $arr[$key]['categorias']   = $item->categoria;;
        }
        $registro->categorias = $arr;

        if( empty($registro->id) ) {
            return redirect()->route('admin.produtos');
        }

        //echo '<pre>';
        //print_r($registro);

        return view('admin.produto.editar', compact('registro'));
    }

    public function salvar(Request $req)
    {
        $dados = $req->all();

        Produto::create($dados);

        $req->session()->flash('admin-mensagem-sucesso', 'Produto cadastrado com sucesso!');

        return redirect()->route('admin.produtos');
    }

    public function atualizar(Request $req, $id)
    {
        $dados = $req->all();

        Produto::find($id)->update($dados);

        $req->session()->flash('admin-mensagem-sucesso', 'Produto atualizado com sucesso!');

        return redirect()->route('admin.produtos');
    }

    public function deletar($id)
    {

        Produto::find($id)->delete();

        $req->session()->flash('admin-mensagem-sucesso', 'Produto deletado com sucesso!');

        return redirect()->route('admin.produtos');
    }
}
