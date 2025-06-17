Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3528DB57;
	Tue, 17 Jun 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146244; cv=none; b=giQ3K3NlyGw1keFqia8i5fluGikSpPUsDmIAhZC55tA8XJ+BhD3u0Jg4YZMezGMhBbq7GP1+kjvu9ZeQ0oOSHYkyO86ZZVDZG3gEf3JQEokngmRC32a/D/Zz+3aCuBFnc3AjwQOPQ+CcGty+xU52kzCygQTbNJBWp6rpz8FyTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146244; c=relaxed/simple;
	bh=4WTHFYz1KPEfTngz6Cxd3QDpVTVxy6AITJ7hz6khgek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVo1G1cKSsjlinKxzAf9MgbxCPN/BfG52rb2/RbV4zpEWHK2PvSZJdLQewT+uE2E0v6ovNAex2eaBLSgYh9XFvuTYfXi7rVmGNwYXmqGBR01ImGb7gFceQPNAPaPu22EsKn/kh3cIzdWjXW4Ad1737QPSZ/dUuCKaOZ7keBNIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2239bYTU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IEz0xVB4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2239bYTU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IEz0xVB4"
Date: Tue, 17 Jun 2025 09:44:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750146241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHw+LYCuKLsVEpOzyNsKG3uAxfu+BsQJDR2nDB6hLdg=;
	b=2239bYTUjqneckR/wjogJlOwEFAAtgX+WNFfk2vc2uIOdBSF+Sg9T9zMMzQZknZlg7rKyy
	mFAPoSwGZmcVoKLavGLvJp0EDE2dJWiJ+klYuD576TixX9w2VPEB5lld756bqYHhedpeId
	QaqJff4Jw+ZbRPAkWyyyXXulF7PFQ9Nbt3bjybJo5I0IhAhWGdoyVN5IFUtahrz6LwmD6X
	QlcqyzquEbnei3H+mF+3lYayP5J2DNFH2cwHJs5wdrKY3MDSDmv1uFan+7MLrILMXhHm7J
	OlbuaB4iQ1MAmG12/b/2lbmwV0ywkxnzPoC7bCvr6Trawa7iD8reoxZsUegA/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750146241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHw+LYCuKLsVEpOzyNsKG3uAxfu+BsQJDR2nDB6hLdg=;
	b=IEz0xVB4btunCUETNInZEqp4wZA4cztpwEGVdZOfTlQHU4W8Am447G+XVzz6TGMvyc/S4G
	R2QS6r5OcNixcKDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernelci@lists.linux.dev, Clark Williams <williams@redhat.com>
Cc: kernelci-results@groups.io, gus@collabora.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [REGRESSION] =?utf-8?Q?stable-rt=2Fv6?=
 =?utf-8?Q?=2E6-rt=3A_=28build=29_conflicting_types_for_=E2=80=98check=5Fu?=
 =?utf-8?B?bmFsaWduZWRfYWNjZXNz4oCZOyBoYXZlIOKAmGludCh2b2lkICop4oCZLi4u?=
Message-ID: <20250617074400.iJhBLT0H@linutronix.de>
References: <CACo-S-0_rffhUzvSbHZvQa1OHnxTpQiezNCga4Xnw+bNuBNNvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACo-S-0_rffhUzvSbHZvQa1OHnxTpQiezNCga4Xnw+bNuBNNvA@mail.gmail.com>

On 2025-06-16 23:59:03 [-0400], KernelCI bot wrote:
> Hello,
Hi,

> New build issue found on stable-rt/v6.6-rt:
>=20
> ---
>  conflicting types for =E2=80=98check_unaligned_access=E2=80=99; have =E2=
=80=98int(void *)=E2=80=99 in
> arch/riscv/kernel/cpufeature.o (arch/riscv/kernel/cpufeature.c)
> [logspec:kbuild,kbuild.compiler.error]
> ---
>=20
> - dashboard: https://d.kernelci.org/i/maestro:09fe4370872596f20cdca497ccf=
7239e25067afa
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable=
-rt.git
> - commit HEAD:  5495197730f86d3227ddfc243ff2980747a321ff
>=20
>=20
> Log excerpt:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> arch/riscv/kernel/cpufeature.c:580:12: error: conflicting types for
> =E2=80=98check_unaligned_access=E2=80=99; have =E2=80=98int(void *)=E2=80=
=99
>   580 | static int check_unaligned_access(void *param)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ./arch/riscv/include/asm/hwcap.h:73,
=E2=80=A6
> #kernelci issue maestro:09fe4370872596f20cdca497ccf7239e25067afa
>=20
> Reported-by: kernelci.org bot <bot@kernelci.org>

Oh this makes me happy. Well, it does not build, yes, but the bot
noticed it and reported it. So this counts.

On the productive side:

This was introduced by commit 502f0a5eb68b8 ("Merge tag 'v6.6.84' into
v6.6-rt") noting a conflict in arch/riscv/include/asm/cpufeature.h.

The prototype should be removed:

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/c=
pufeature.h
index 13b7d35648a9c..788fd575c21a9 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,7 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
=20
-void check_unaligned_access(int cpu);
 void riscv_user_isa_enable(void);
=20
 #endif

This happened in the upstream commit 55e0bf49a0d03 ("RISC-V: Probe
misaligned access speed in parallel")

Sebastian
