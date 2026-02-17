Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFED23A98E
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314187; cv=none; b=QqMkHx5ce3NQBTK4nJGyJFoL7+koLbJXf5hkHUsYiq/xeWQ+wIxxOqOvhlthRV8RabqGFxX+VZHPYhF84g9nstlLS0n+8WEI344l6P8enH7zJGrcHlPqHxa0AmFKMKIggQ4iwrf5yXkYBRVJJ0PstKjevFoYA7bjtv3PsTmjEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314187; c=relaxed/simple;
	bh=GyhuzfTKc9azg92IljxvkgkmeGTKYpXl5LUzUn+KqOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwUxthluy5CfW2VTxDUDvEomYtiLfOsnqrgYyw8ODtkOjU9LK1cNEtwZjaY9Uj+Tl/KuuiOeVnqSHi7/iXwuRlfOZACJ+5HzDfpRsMhxN0NEDv00+3TQvw5tbdFjHyvqXawDENC3LNft992+rsFCk6Mjf96IYuqFDDLov6o1mwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UeUxhY0G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XxjZNW6h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeUxhY0G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxjZNW6h"
Date: Tue, 17 Feb 2026 08:43:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771314185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GyhuzfTKc9azg92IljxvkgkmeGTKYpXl5LUzUn+KqOk=;
	b=UeUxhY0G+UqdM9PdYKA9MazplqRkMefwPQh76oCDjKnNA9wDciUHgwi7/iSi76NpIuGZyW
	pu6g41NbQ0GI+j5X9lQTgpovf5nnBxs6ht9pXb1z6bGAIKA4uJjBT5OdyTdoMkYTMUhlYQ
	HsaalDsmJOu0i1O70v91rhyONULOSXigk4FtNl3ZNtOrbhxKQ2llhRQfQ83wz8DFa1ZPpf
	tjSfNTX+krK/6DXAmJtw78xPYypTAgpVOz/14YUu7lfmNA2ZKosRribcTz6fR2TKjnyBPl
	P/Hu+jGksWdP4Y7ng3MXZ9Qc8i7Pd6f7f0s957e4DF3H83WitNb60l882iZsPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771314185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GyhuzfTKc9azg92IljxvkgkmeGTKYpXl5LUzUn+KqOk=;
	b=XxjZNW6hQE5t4LsmEhyv1PVamaqNcnnZoFjkzqmIxc9fhnOrcilnZS7wr2eEAIaqOV9wPp
	K3h2VMcIMjKGAFDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: jiayuan.chen@shopee.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3 0/2] bpf: cpumap/devmap: fix per-CPU bulk queue
 races on PREEMPT_RT
Message-ID: <20260217074303.aWlBuoFG@linutronix.de>
References: <20260213034018.284146-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260213034018.284146-1-jiayuan.chen@linux.dev>

- xxx@vger.kernel.org

On 2026-02-13 11:40:13 [+0800], Jiayuan Chen wrote:
> On PREEMPT_RT kernels, local_bh_disable() only calls migrate_disable()
> (when PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
> preemption. This means CFS scheduling can preempt a task inside the
> per-CPU bulk queue (bq) operations in cpumap and devmap, allowing
> another task on the same CPU to concurrently access the same bq,
> leading to use-after-free, list corruption, and kernel panics.
>=20
> Patch 1 fixes the cpumap race in bq_flush_to_queue(), originally
> reported by syzbot [1].
>=20
> Patch 2 fixes the same class of race in devmap's bq_xmit_all(),
> identified by code inspection after Sebastian Andrzej Siewior pointed
> out that devmap has the same per-CPU bulk queue pattern [2].
=E2=80=A6

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
