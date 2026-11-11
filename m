Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387481;
	b=OETwpeRj0RbyqyuUGMGpm6LuFbmnzw3TUCGqr0cx0xMUpVVAOyPPfiUdeRXzWGQ266HI
	 B4Nj33nU08BdSGvU0LSfgZF07BA1cN4Nhr1WdtSLyLgrlqiqCbN+u+856nrpRi9apOibn
	 9kkl95VpQvCGio6VdncM+B6oTZhNgIPCvK8KO1tcif176+9dXX3euokWfrqWKjVoLYrdj
	 u23PVO0/ppDCgGNyR6K0AnNpRv91Ke5W7oKoVIZBSEg9Sl1uXwYG1zdJl16YZGwFapSOs
	 J6k9Lq5kuyYDFNkRIGQnJ64mSbnyIktBL50Q/RilC8XialdH+0cQIAoMawq1sgmYmuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wEQjpj7fLC9UQSGUec0NP2E72HJFmVLfLhZxu0dRoLk=;
	b=WcP4lDe5uCfU52c99snXmjnt91NKqdbF5HOnixNANdy+G6dAiQDUjO5UaP2FJtnR42VH
	 kNVTuTHj2DdwI37ybJeVwITI6srzVXCM9xugz/IF+M0v99bI0jaBcCzqAgseeOVA0rm+Z
	 PENHXfjV4p175XTKniAsVevHVFCBX8S8azHOwudSVfxKWzKaeGyc1tl9TbZ43PdPdoUUc
	 l5NUNmfSZKRLSQi1j8pvXe2Sw9DwrFch5jfW8UAb19wJYV8O8I1p6+/GToBa0tG9uSgRC
	 liCVnV9277/lNp953xmYUxGhHaSgd8d/LXe31PdIwzT1EyRimswUQ2xmdGq3gpL3LEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J81Wrdts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091560A262E;
	Wed, 11 Nov 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J81Wrdts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD55E1F00A07;
	Wed, 11 Nov 2026 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794387480;
	bh=wEQjpj7fLC9UQSGUec0NP2E72HJFmVLfLhZxu0dRoLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J81WrdtsCiA7YQQcOBABA1pxnZw7yyq6uru3Nj9fnB9E6HycYEy1dASRubBMu9o/e
	 yZvXqYtvv23yAQkOqFgk3Wgw1DhX+Iybny9ND+E3zk+PbyQn61EOl3uZzO48Uvgw7o
	 OQ/H0EmgcJ126PGKE3aB858FfH+d5JMeYULITW4VoM60ZKbE/kNBopLx+4V87D5/37
	 KOoo9R4SMvHFLg+PHbzABztBjcquj/tB3BgzNf3esrCYISWPtOiO9o85qJ+J79Ncpc
	 kS3MEp6LHiEi5xCw9nx005vn+0giJ8+9PcvwTahLeBVg9Exlp3e/rwmmFO8Zz27uwq
	 Qu9HVMok9BzhQ==
Message-ID: <sashiko-outbox-208645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261110165742.1204-1-haoranwangsec@gmail.com>
References: <179241614797.5916.13928836073297916808@whr>
 <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
 <20261109180748.33682-1-haoranwangsec@gmail.com>
 <20261109200332.52e2fc0e@pumpkin>
 <20261110165742.1204-1-haoranwangsec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:58:00 +0000
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

commit 5481811981b3771bf6244d1b3e3e8e9871700ea8
Author: Haoran Wang <haoranwangsec@gmail.com>

> libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
>
> ppm_get_cpu_entries() must not acquire a sleeping lock while preemption
> is disabled: get_cpu() raises preempt_count and spin_lock_bh() may sleep
> on PREEMPT_RT kernels.  Read the current CPU with raw_cpu_ptr() instead,
> which keeps the per-CPU accessor stable without disabling preemption.
>
> Using the pool of a CPU the thread has since migrated away from is
> harmless: the per-CPU pools are shards of the global ppod index space,
> and the free path ppm_unmark_entries() derives the owning pool from the
> index instead of from the running CPU, so any thread can service any
> shard.  Derive the global index base from pool->base so it always
> matches the pool that was locked.
>
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>

[Severity: Low]
Since this fixes a sleeping-while-atomic bug on PREEMPT_RT in
ppm_get_cpu_entries(), should it include a Fixes: tag?

  Fixes: 47da7e62b391 ("cxgb4: add iSCSI DDP page pod manager")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110165742.1204=
-1-haoranwangsec@gmail.com?part=3D1
