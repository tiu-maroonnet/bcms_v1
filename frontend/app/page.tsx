"use client";

import { useQuery } from "@tanstack/react-query";
import axios from "axios";

export default function Home() {
  const { data } = useQuery({
    queryKey: ["me"],
    queryFn: async () => {
      const res = await axios.get(`${process.env.NEXT_PUBLIC_API_URL}/me`, { withCredentials: true });
      return res.data;
    }
  });

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold">BCMS Dashboard</h1>
      <pre className="mt-4 bg-white p-4 rounded border">{JSON.stringify(data, null, 2)}</pre>
    </main>
  );
}