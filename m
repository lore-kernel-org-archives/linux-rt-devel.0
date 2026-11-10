Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305286;
	b=vtpqdnMARtGnzotKL/hlqmkFQ4YCHO636epOiTxDyzQzVoio84G+fPb1sNHWA/B2SIdU
	 31Aa0Pl32rRfZxlGd5fQQt3O1yOD0qBvPEa+8q2HbcagwY0CSgaxj1+F195Pz4Jzf5f5t
	 2Sw0xo/jFlWp/dpv3ul+OsfvbV2gG8ZaMFuzcPPDry2H50LbVstR/9jUJq/al3kA11enV
	 p6FenCi67ky2zUwf+crDsS0LAE8JkMEEq3xK0pJvxtFmFlM1LrG6/60CJUB8qbDyV1JA2
	 8Kyto20VAzUFXCwo4sh6Npii5egGrfTXMZaQ6lmEiF+jm8+m4H816IjNLJ8YMNKojlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rZGE+BhyFy6y6QawUK8spIczafnOnl4GAegteQPB6PY=;
	b=IS46pGbaDXEeXh8hyuSL4HAIAINQ6dz3NGvP3UNYqhIQ6drictwTlHntdcqEWM0OOjqn
	 izv2HyySprWWdw++jyXr7qysI4js7QPo7UOqR2JOf7t2P9kW2/p08X+A78wEsxbjtNl9L
	 W5RsmUZh7jtFVF52GHsrWetB3g51SjPYbFU3kcbSMyaEWEEs+F4GDPTHKQSPXbqYXao2P
	 Sh/iVWqKFuAgcVcW5lv2J/dCRwy64V5wu6OMVxHYD4FS2pE8ghOiZxqEDcbfg4U2HQFkq
	 FDQuB/IM7298SEy5dMsjSBoQSs2TNPw/alGndQaGMStPDIGTNhsZKwqAhft6kdIwEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C67QTUYk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53868606A337;
	Tue, 10 Nov 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C67QTUYk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056BB1F008BC;
	Tue, 10 Nov 2026 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305286;
	bh=rZGE+BhyFy6y6QawUK8spIczafnOnl4GAegteQPB6PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C67QTUYk3Gt38+YSSonUE26t5zBRT+aC9zwCaGLFT34OZidKKfUINxkgGhdVYlzo+
	 J4xuEeNaC7S+TsPT7XTLbbopiUv56bqxrh/Rca0EhNH9U8ysW6aGAQxAeVWyZ/7ncn
	 5cJLhWPXFi1oexVyga4dywryeMGOVVbeJFrg1cJh1sNeWPVBZLgokrEkYFQLMMHUIM
	 fTE7zjsIVXMEez8ZnUtH92DTwm5nsRcP3hCTvhtSWsP0JjCLksUrHgT74Hlsu/1ih/
	 LADludNK7F7Pitf05/sQZpwC+iYgmVlhV/aDxw0Cr+9/24W01ZSj5hCHuWa9qVDSf3
	 gK3yH5OiXdaeA==
Message-ID: <sashiko-outbox-206835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261109180748.33682-1-haoranwangsec@gmail.com>
References: <179241614797.5916.13928836073297916808@whr>
 <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
 <20261109180748.33682-1-haoranwangsec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:08:05 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] libcxgb: missing Fixes: trailer on bug-fix commit for
  ppm_get_cpu_entries()
--

commit f26f870fe2fc150e7c6210fe2807b65ce57e879d
Author: Haoran Wang <haoranwangsec@gmail.com>

> libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
>
> ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
> current CPU's pool with per_cpu_ptr(), then acquires the pool's
> spin_lock_bh() while preemption is still disabled, and finally put_cpu().
>
> On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
> (rt_spin_lock), so the task may sleep with preempt_count elevated:
> scheduling while atomic, reported as a BUG by CONFIG_DEBUG_ATOMIC_SLEEP
> and a deadlock once the lock is contended.  Any iSCSI offload I/O
> through a Chelsio NIC that reaches ppm_get_cpu_entries() triggers it.
>
> Read the current CPU with raw_cpu_ptr() without raising preempt_count,
> and derive the global index base from pool->base (initialised when the
> pools are allocated) instead of cpu * pool_index_max, so the base
> always matches the pool that was locked.  The owning CPU remains in the
> debug output, now derived from pool->base.
>
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>

[Severity: Low]
Since this fixes a sleeping-while-atomic bug in ppm_get_cpu_entries() on
PREEMPT_RT kernels, should this include a Fixes: tag?

  Fixes: 47da7e62b391 ("cxgb4: add iSCSI DDP page pod manager")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109180748.3368=
2-1-haoranwangsec@gmail.com?part=3D1
