<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\MikrotikService;

class ProvisioningController extends Controller
{
    private MikrotikService $mt;

    public function __construct(MikrotikService $mt)
    {
        $this->mt = $mt;
    }

    public function index()
    {
        return response()->json([]);
    }

    public function store(Request $request)
    {
        // validate & dispatch job to queue for PPPoE/static provisioning
        // For brevity, dispatching omitted.
        return response()->json(['status'=>'queued'], 202);
    }

    public function update(Request $request, $id)
    {
        return response()->json(['status'=>'queued'], 202);
    }

    public function destroy($id)
    {
        return response()->json(['status'=>'deleted']);
    }

    public function testConnection(Request $request)
    {
        $ok = $this->mt->ping();
        return response()->json(['ok'=>$ok]);
    }
}